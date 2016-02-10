define bundler::command(
    $directory,
    $command    = $name,
    $gemfile    = undef,
    $unless     = undef,
    $user       = 'vagrant',
) {
    require ::bundler

    $bundle = "${::bundler::ruby} -- ${::bundler::bin}"
    $bundle_gemfile = $gemfile ? {
        undef   => "${directory}/Gemfile",
        default => $gemfile,
    }

    $bundle_unless = $unless ? {
        undef   => undef,
        default => "${bundle} ${unless}",
    }

    exec { "bundle ${title}":
        command     => "${bundle} ${command}",
        provider    => 'shell',
        cwd         => $directory,
        environment => [
            "BUNDLE_GEMFILE=${bundle_gemfile}",
            "HOME=/home/${user}",
        ],
        user        => $user,
        unless      => $bundle_unless,
        timeout     => 60 * 20,
        logoutput   => true,
    }
}
