class profile::dumps::rsyncer_peer(
    $rsyncer_peer_settings = hiera('profile::dumps::rsyncer_peer'),
) {
    $user = $rsyncer_peer_settings['dumps_user']
    $group = $rsyncer_peer_settings['dumps_group']
    $mntpoint = $rsyncer_peer_settings['dumps_mntpoint']

    $peer_hosts = 'dataset1001.wikimedia.org ms1001.wikimedia.org dumpsdata1001.eqiad.wmnet dumpsdata1002.eqiad.wmnet labstore1006.wikimedia.org'

    class {'::dumps::rsync::common':
        user  => $user,
        group => $group,
    }
    class {'::dumps::rsync::default':}
    class {'::dumps::rsync::memfix':}
    class {'::dumps::rsync::peers':
        hosts_allow => $peer_hosts,
        datapath    => $mntpoint,
    }
}
