# == Class contint::package_builder
#
# Setup cow images and jenkins-debian-glue
#
class contint::package_builder {

    # Shell script wrappers to ease package building
    # Package generated via the mirror operations/debs/jenkins-debian-glue.git

    # jenkins-debian glue puppetization:
    file { '/srv/pbuilder':
        ensure  => directory,
        # On extended disk provided by ci::slave::labs::common
        require => Mount['/srv'],
    }

    file { '/var/cache/pbuilder':
        ensure  => link,
        target  => '/srv/pbuilder',
        require => File['/srv/pbuilder'],
    }

    class { '::package_builder':
        # We need /var/cache/pbuilder to be a symlink to /srv
        # before cowbuilder/pbuilder is installed
        require  => [
            File['/var/cache/pbuilder'],
            File['/srv/pbuilder'],
        ],
        # Cowdancer is confused by /var/cache/pbuilder being a symlink
        # causing it to fail to properly --update cow images. T125999
        basepath => '/srv/pbuilder',
    }

    package { [
        'jenkins-debian-glue',
        'jenkins-debian-glue-buildenv',
        ]:
            ensure  => present,
            # cowbuilder file hierarchy needs to be created after the symlink
            # points to the mounted disk.
            require => File['/var/cache/pbuilder'],
    }

}
