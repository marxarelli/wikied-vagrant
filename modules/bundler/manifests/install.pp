# == Define: bundler::install
#
# Installs gem dependencies according to the given directory's Gemfile.
#
# === Parameters
#
# [*directory*]
#   Project directory containing Gemfile. Default: $title.
#
# [*gemfile*]
#   A specific path to the Gemfile. Default: "$directory/Gemfile".
#
# [*user*]
#   The user to run bundler commands as. Default: 'vagrant'.
#
# === Examples
#
# Ensure dependencies are installed for browsertests.
#
#   ruby::bundle { '/srv/browsertests/test/browser': }
#
define bundler::install(
    $directory  = $title,
    $gemfile    = undef,
    $user       = 'vagrant',
) {
    require ::bundler

    $bundle = "${::bundler::ruby} -- ${::bundler::bin}"
    $bundle_gemfile = $gemfile ? {
        undef   => "${directory}/Gemfile",
        default => $gemfile,
    }

    exec { "bundle_install_${title}":
        command     => "${bundle} install",
        provider    => 'shell',
        cwd         => $directory,
        environment => [
            "BUNDLE_GEMFILE=${bundle_gemfile}",
            "HOME=/home/${user}",
        ],
        user        => $user,
        unless      => "${bundle} check",
        timeout     => 60 * 20,
        logoutput   => true,
    }
}
