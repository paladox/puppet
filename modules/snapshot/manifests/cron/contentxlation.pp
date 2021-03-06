class snapshot::cron::contentxlation(
    $user=undef,
) {
    $otherdir = $snapshot::dumps::dirs::otherdir
    $repodir = $snapshot::dumps::dirs::repodir
    $confsdir = $snapshot::dumps::dirs::confsdir
    $xlationdir = "${otherdir}/contenttranslation"

    $scriptpath = '/usr/local/bin/dumpcontentxlation.sh'
    file { $scriptpath:
        mode   => '0755',
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/snapshot/cron/dumpcontentxlation.sh',
    }

    cron { 'xlation-cleanup':
        ensure      => 'present',
        environment => 'MAILTO=ops-dumps@wikimedia.org',
        user        => $user,
        command     => "find ${xlationdir}/ -maxdepth 1 -type d -mtime +90 -exec rm -rf {} \\;",
        minute      => '0',
        hour        => '9',
    }

    cron { 'xlation-dumps':
        ensure      => 'present',
        environment => 'MAILTO=ops-dumps@wikimedia.org',
        user        => $user,
        command     => '/usr/local/bin/dumpcontentxlation.sh',
        minute      => '10',
        hour        => '9',
        weekday     => '5',
        require     => File[$scriptpath],
    }
}
