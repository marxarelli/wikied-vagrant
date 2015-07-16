# == Define: npm::package
#
# Install an NPM package globally.
#
# === Parameters
#
# [*package*]
#   Name of the package to install.
#
define npm::package(
    $package = $title,
) {
    npm::install { "global-${title}":
        directory => '/',
        user      => 'root',
        package   => $package,
        global    => true,
    }
}
