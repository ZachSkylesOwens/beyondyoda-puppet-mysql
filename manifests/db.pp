define beyondyoda_mysql::db ( $user, $password ) {
	exec { "create-${name}-db":
		unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
		command => "/usr/bin/mysql -uroot -p$mysql_password -e \"CREATE DATABASE ${name}; GRANT ALL ON ${name}.* TO ${user}@localhost IDENTIFIED BY '$password';\"",
		require => Service['mysql'],
	}
}
