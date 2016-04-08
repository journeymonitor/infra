class composer {

  file { "/usr/bin/composer-1.0.0.phar":
    owner   => "root",
    group   => "root",
    mode    => 06755,
    source  => "puppet:///modules/composer/usr/bin/composer-1.0.0.phar",
    require => [ Class["php5"] ],
  }

  file { "/usr/bin/composer":
    ensure  => "link",
    target  => "/usr/bin/composer-1.0.0.phar",
    require => File["/usr/bin/composer-1.0.0.phar"],
  }

}
