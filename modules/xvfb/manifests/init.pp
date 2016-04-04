# == Class: xvfb
#
# Install xvfb and start a display as a systemd service.
#
# === Parameters
#
# [*display*]
#   Display port to run xvfb on.
#
# [*resolution*]
#   Resolution to run the display at.
#
class xvfb(
    $display = ':99',
    $resolution = '1024x768x24',
) {
    package { 'xvfb':
        ensure => 'installed',
    }

    file { '/etc/systemd/system/xvfb.service':
        content => template('xvfb/xvfb.service.erb'),
    }

    service { 'xvfb':
        enable   => true,
        ensure   => 'running',
        provider => 'systemd',
        require  => [
            File['/etc/systemd/system/xvfb.service'],
            Package['xvfb'],
        ],
    }
}
