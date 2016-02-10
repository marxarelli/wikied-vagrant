define mysql::database(
    $database = $title,
    $user = 'vagrant',
) {
    require ::mysql

    $create = "CREATE DATABASE `${database}` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"

    exec { "create-mysql-database-${title}":
        command => "/usr/bin/mysql --execute='${create}'",
        unless  => "/usr/bin/mysql --execute='SELECT 1;' '${database}'",
        user    => $user,
    }
}
