package searchqa;
use strict;
use Net::DNS::Resolver;
use URI::Escape;

our $servers; # hostname to ip address cache for api servers

our $conf = {
	'out_dir_prefix' => '/tmp/fire_in_the_hole-', # where we'll drop search response logs
	'default_api_log' => '/opt/searchqa/data/api-usage.log', # list of URLs from api.php
	'server_timeout' => 5, # seconds to wait for a response from an API server
	'server_timeout_limit' => 3, # how many timeouts to tolerate before dropping a server
	'api_tcp_port' => 8123, # lucene listens here
	'user_agent' => $0, # user agent for web request, probably don't care
	'max_queries_per_type' => 25, # don't rerun *everything*, just the first 25 queries
	'perl_threads' => 50, # 50 threads is a fairly mellow number
	'datacenter' => 'eqiad,pmtpa', # process both datacenters by default
	'api_hosts' => [ qw(
		search1.pmtpa.wmnet search2.pmtpa.wmnet search3.pmtpa.wmnet search4.pmtpa.wmnet search5.pmtpa.wmnet
		search6.pmtpa.wmnet search7.pmtpa.wmnet search8.pmtpa.wmnet search9.pmtpa.wmnet search10.pmtpa.wmnet
		search11.pmtpa.wmnet search12.pmtpa.wmnet search13.pmtpa.wmnet search14.pmtpa.wmnet search15.pmtpa.wmnet
		search16.pmtpa.wmnet search17.pmtpa.wmnet search18.pmtpa.wmnet search19.pmtpa.wmnet search20.pmtpa.wmnet
		search1001.eqiad.wmnet search1002.eqiad.wmnet search1003.eqiad.wmnet search1004.eqiad.wmnet
		search1005.eqiad.wmnet search1006.eqiad.wmnet search1007.eqiad.wmnet search1008.eqiad.wmnet
		search1009.eqiad.wmnet search1010.eqiad.wmnet search1011.eqiad.wmnet search1012.eqiad.wmnet
		search1013.eqiad.wmnet search1014.eqiad.wmnet search1015.eqiad.wmnet search1016.eqiad.wmnet
		search1017.eqiad.wmnet search1018.eqiad.wmnet search1019.eqiad.wmnet search1020.eqiad.wmnet
	)],
};

# The routines determine_api_host() and determine_database() combine for a
# coarse approximation of how lvs pools, apache config, and mediawiki code
# combine to route search subrequests. It would be nice if we could just
# recycle existing code to do this, but I don't see how that is feasible.  So
# we hack and replicate as best we can.

sub determine_api_host {
	# approximate the combination of lvs + lucene.php (pmtpa) + lucene.php (eqiad)
	# to determine which hosts to query based on search parameters
	my $q = shift;
	my @hosts;
	if (defined $q->{'suggest'}) {
		if ($q->{'wgDBname'} eq 'enwiki') {
			push @hosts, qw(search1002.eqiad.wmnet search1006.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
			push @hosts, qw(search8.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
		} else { # default mwsuggest host
			push @hosts, qw(search1017.eqiad.wmnet search1018.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
			push @hosts, qw(search18.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
		}
	} elsif ($q->{'wgDBname'} eq 'enwiki') {
		#return qw(10.2.1.11); # search_pool1 pmtpa
		push @hosts, qw(search1001.eqiad.wmnet search1002.eqiad.wmnet search1003.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
		push @hosts, qw(search1.pmtpa.wmnet search3.pmtpa.wmnet search4.pmtpa.wmnet search9.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
	} elsif ($q->{'wgDBname'} =~ /^(dewiki|frwiki|jawiki)$/) {
		#return qw(10.2.1.12); # search_pool2 pmtpa
		push @hosts, qw(search1007.eqiad.wmnet search1008.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
		push @hosts, qw(search6.pmtpa.wmnet search15.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
	} elsif ($q->{'wgDBname'} =~ /^(itwiki|ptwiki|plwiki|nlwiki|ruwiki|svwiki|zhwiki)$/) {
		#return qw(10.2.1.13); # search_pool3 pmtpa
		push @hosts, qw(search1011.eqiad.wmnet search1012.eqiad.wmnet search1013.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
		push @hosts, qw(search7.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
	} elsif ($q->{'wgDBname'} eq 'eswiki') {
		push @hosts, qw(search1011.eqiad.wmnet search1012.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
		push @hosts, qw(search14.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
	} else {
		push @hosts, qw(search1015.eqiad.wmnet search1016.eqiad.wmnet) if $q->{'datacenter'} =~ /eqiad/;
		push @hosts, qw(search11.pmtpa.wmnet) if $q->{'datacenter'} =~ /pmtpa/;
	}
	return @hosts;
}

sub determine_database {
	# approximate how api.php and mediawiki figure out which wiki database applies
	# for the hostname used for the api.php request
	my $q = shift;
	if ($q->{'host'} =~ /^([a-z]{2,3})\.(?:m\.)?wikipedia\./) {
		return "$1wiki";
	} elsif ($q->{'host'} =~ /^([a-z]{2,3})\.(?:m\.)?(wikinews|wikibooks|wikiversity|wiktionary|wikisource|wikiquote)\./) {
		return "$1$2";
	}
}

sub dig {
	# simple DNS resolver to grab the first A record, caches for entire script run
	my $hostname = shift;
	return $servers->{$hostname} if defined $servers->{$hostname};
	my $resolver = Net::DNS::Resolver->new;
	my $answer = $resolver->search($hostname);
	if ($answer) {
		for my $r ($answer->answer) {
 			if ($r->type eq 'A') {
				# grab the first A record
				$servers->{$hostname} = $r->address;
	 			return $r->address;
			}
		}
	}
	die "ugh we fail to find the IP for $hostname, fix this darn it\n";
}

sub timestamp {
	my $date = `/bin/date "+%Y%m%d-%H%M%S"`;
	chomp $date;
	return $date;
}

sub sanitize_response {
	my $data = shift;
	$data =~ s/^#.*\R//mg; # i.e. #info prefix=[search1008] in 0 ms
	$data =~ s/^(\d+\.\d{2})\d+/$1/mg; # slight score differences aren't interesting
	return $data;
}

# turn an array of hostnames into an array of ip addresses
sub hosts_to_ips {
	my @ips;
	for (@_) {
		push @ips, dig($_);
	}
	return @ips;
}


sub affirm {
	my ($question,$string) = @_;
	print "\n[1m$question [$string/n]: [0m";
	while (1) {
		my $input = <STDIN>;
		chomp $input;
		if ($input =~ /^n/i) {
			return "no";
		} elsif ($input eq $string) {
			return "yes";
		} else {
			print "1mHuh? [$string/n]:[0m ";
		}
	}
}

1;
