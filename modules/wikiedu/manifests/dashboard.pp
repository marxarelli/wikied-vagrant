class wikiedu::dashboard(
    $source,
    $revision,
) {
    $dir = '/vagrant/WikiEduDashboard'

    require ::wikiedu::dependencies
    include ::xvfb

    vcsrepo { $dir:
        ensure   => present,
        provider => git,
        source   => $source,
        revision => $revision,
        user     => 'vagrant',
    }

    bundler::install { $dir:
        require => Vcsrepo[$dir],
    }

    npm::install { $dir:
        require => Vcsrepo[$dir],
    }

    bower::install { $dir:
        require => Vcsrepo[$dir],
    }

    npm::package { 'gulp': }

    file { "${dir}/config/database.yml":
        source  => 'puppet:///modules/wikiedu/database.yml',
        owner   => 'vagrant',
        group   => 'vagrant',
        replace => false,
        require => Vcsrepo[$dir],
    }

    file { "${dir}/config/application.yml":
        source  => 'puppet:///modules/wikiedu/application.yml',
        owner   => 'vagrant',
        group   => 'vagrant',
        replace => false,
        require => Vcsrepo[$dir],
    }

    mysql::database { ['dashboard', 'dashboard_testing']:
        require => [
            File["${dir}/config/database.yml"],
            File["${dir}/config/application.yml"],
        ]
    }

    bundler::command { 'exec rake db:migrate':
        directory => $dir,
        require   => [
            Bundler::Install[$dir],
            Npm::Install[$dir],
            Mysql::Database['dashboard'],
        ]
    }

    bundler::command { 'exec rake cohort:add_cohorts':
        directory => $dir,
        require   => Bundler::Command['exec rake db:migrate'],
    }

    # Make sure the zeus socket is created outside the vboxsf mount
    file_line { '/etc/environment-ZEUSSOCK':
        path  => '/etc/environment',
        line  => 'ZEUSSOCK=/tmp/zeus.sock',
        match => '^ZEUSSOCK\=',
    }

    # Tell the Rails server (via guard) to run on all interfaces
    file_line { '/etc/environment-RAILS_HOST':
        path  => '/etc/environment',
        line  => 'RAILS_HOST=0.0.0.0',
        match => '^RAILS_HOST\=',
    }

    # Set DISPLAY to the xvfb display for running full-stack tests headlessly
    file_line { '/etc/environment-DISPLAY':
        path  => '/etc/environment',
        line  => "DISPLAY=${::xvfb::display}",
        match => '^DISPLAY\=',
    }
}
