# == Define: npm::install
#
# Custom resource for installing node.js module dependencies
#
# === Parameters
#
# [*directory*]
#   Name of the directory where to execute the install command
#
# [*user*]
#   User to run the installation as.
#
# [*global*]
#   Whether to install the package globally.
#
# [*package*]
#   A specific package to install. Default: install everything in
#   packages.json.
#
define npm::install(
    $directory = $title,
    $user = 'vagrant',
    $global = false,
    $package = undef,
) {
    $flags = $global ? { true => '-g', default => '--no-bin-links' }

    $modules_path = $global ? {
        true => "/usr/lib/node_modules",
        default => "${directory}/node_modules",
    }

    $created_path = $package ? {
        undef   => $modules_path,
        default => "${modules_path}/${package}",
    }

    exec { "npm_install_${title}":
        command     => "/usr/bin/npm install ${package} ${flags}",
        cwd         => $directory,
        user        => $user,
        environment => [
            'NPM_CONFIG_GLOBAL=false',
            'LINK=g++',
            "HOME=/home/${user}",
        ],
        creates     => $created_path,
        timeout     => 60 * 20,
        logoutput   => true,
        require     => Package['nodejs'],
    }
}
