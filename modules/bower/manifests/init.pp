class bower {
    npm::package { 'bower':
        require => Package['npm'],
    }
}
