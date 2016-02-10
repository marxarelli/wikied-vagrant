class mysql {
    $create = "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'localhost';"

    exec { 'create-mysql-vagrant-user':
        command  => "/usr/bin/mysql --execute='${create}'",
        unless   => "/usr/bin/mysql --user=vagrant --execute='SELECT 1;' '${database}'",
    }
}
