define bundler::install(
    $directory  = $name,
    $gemfile    = undef,
    $user       = 'vagrant',
) {
    bundler::command { "install ${title}":
        directory => $directory,
        gemfile   => $gemfile,
        user      => $user,
        command   => 'install',
        unless    => 'check',
    }
}
