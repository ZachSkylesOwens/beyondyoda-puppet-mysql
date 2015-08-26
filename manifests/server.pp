class beyondyoda_mysql::server {

	package { 'mysql-server':
		ensure => installed,
	}

	package { 'mysql-client':
		ensure => installed,
	}

	service { 'mysql':
		enable => true,
		ensure => running,
		require => Package['mysql-server'],
	}

	file { '/var/lib/mysql/my.cnf':
		owner => mysql, 
		group => mysql,
		source => 'puppet:///modules/beyondyoda_mysql/my.cnf',
		notify => Service['mysql'],
		require => Package['mysql-server'],
	}

	file { '/etc/my.cnf':
		require => File['/var/lib/mysql/my.cnf'],
		ensure => '/var/lib/mysql/my.cnf',
	}

	exec { 'set-mysql-password':
		unless => "mysqladmin -uroot -p$mysql_password status", 
		path => ['/bin', '/usr/bin'],
		command => "mysqladmin -uroot password $mysql_password",
		require => Service['mysql'],
	}
}
