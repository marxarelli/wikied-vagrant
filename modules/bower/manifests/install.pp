# == Define: bower::install
#
# Install bower dependencies for a given directory.
#
# === Parameters
#
# [*directory*]
#   Name of the directory where to execute the install command
#
# [*user*]
#   User to run the installation as.
#
define bower::install(
    $directory = $title,
    $user = 'vagrant',
) {
    require ::bower

    exec { "bower_install_${title}":
        command     => '/usr/local/bin/bower install',
        cwd         => $directory,
        user        => $user,
        environment => "HOME=/home/${user}",
        timeout     => 60 * 20,
        logoutput   => true,
    }
}
