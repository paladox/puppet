# https://wikiba.se (T99531)
class profile::microsites::wikibase {

    class { '::base::firewall': }

    ferm::service { 'wikibase_http':
        proto => 'tcp',
        port  => '80',
    }

    class { '::apache': }
    class { '::apache::mod::headers': }

    apache::site { 'wikiba.se':
        content => template('profile/wikibase/apache-wikibase.erb'),
    }

    ensure_resource('file', '/srv/es', {'ensure' => 'directory' })
    ensure_resource('file', '/srv/es/wikiba', {'ensure' => 'directory' })

    git::clone { 'wikibase/wikiba.se-deploy':
        ensure    => 'latest',
        directory => '/srv/es/wikiba',
        branch    => 'master',
    }

}
