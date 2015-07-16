class wikiedu::dashboard(
    $source,
    $revision,
) {
    vcsrepo { '/vagrant/WikiEduDashboard':
        ensure   => present,
        provider => git,
        source   => $source,
        revision => $revision,
        user     => 'vagrant',
    }

    bundler::install { '/vagrant/WikiEduDashboard':
        require => Vcsrepo['/vagrant/WikiEduDashboard'],
    }

    npm::install { '/vagrant/WikiEduDashboard':
        require => Vcsrepo['/vagrant/WikiEduDashboard'],
    }
}
