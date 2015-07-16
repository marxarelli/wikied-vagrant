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
define npm::install(
    $directory = $title,
    $user = 'vagrant',
) {
    exec { "${title}_npm_install":
        command     => '/usr/bin/npm install --no-bin-links',
        cwd         => $directory,
        user        => $user,
        environment => [
            'NPM_CONFIG_GLOBAL=false',
            'LINK=g++',
            "HOME=/home/${user}",
        ],
        creates     => "${directory}/node_modules",
        timeout     => 60 * 20,
        logoutput   => true,
    }
}
