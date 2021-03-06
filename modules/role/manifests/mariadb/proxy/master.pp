# db master failover with a proxy
class role::mariadb::proxy::master(
    $shard,
    $primary_name,
    $primary_addr,
    $secondary_name,
    $secondary_addr,
    ) {

    include role::mariadb::ferm

    class { 'role::mariadb::proxy':
        shard => $shard,
    }
    if os_version('debian >= stretch') {
        $master_template = 'db-master-stretch.cfg'
    } else {
        $master_template = 'db-master.cfg'
    }

    file { '/etc/haproxy/conf.d/db-master.cfg':
        owner   => 'root',
        group   => 'root',
        mode    => '0444',
        content => template("role/haproxy/${master_template}.erb"),
    }

    nrpe::monitor_service { 'haproxy_failover':
        description  => 'haproxy failover',
        nrpe_command => '/usr/lib/nagios/plugins/check_haproxy --check=failover',
    }
}

