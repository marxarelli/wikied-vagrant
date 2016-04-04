# Adds an apt source for up-to-date node packages.
#
class nodesource(
    $source,
) {
    package { 'apt-transport-https':
        ensure => installed,
    }

    file { '/etc/apt/sources.list.d/nodesource.list':
        content => $source,
        require => Package['apt-transport-https'],
    }

    file { '/etc/apt/nodesource.gpg.key':
        source => 'puppet:///modules/nodesource/nodesource.gpg.key',
    }

    exec { 'trust-and-update-nodesource-apt-cache':
        command  => 'apt-key add /etc/apt/nodesource.gpg.key && apt-get update',
        provider => 'shell',
        unless   => 'apt-key finger | grep -q "9FD3 B784 BC1C 6FC3 1A8A  0A1C 1655 A0AB 6857 6280"',
        require  => File['/etc/apt/sources.list.d/nodesource.list', '/etc/apt/nodesource.gpg.key'],
    }
}
