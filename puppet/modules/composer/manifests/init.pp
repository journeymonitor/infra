class composer {

  file { "/usr/bin/composer-1.3.1.phar":
    owner   => "root",
    group   => "root",
    mode    => 06755,
    source  => "puppet:///modules/composer/usr/bin/composer-1.3.1.phar",
    require => [ Class["php7_1"] ],
  }

  file { "/usr/bin/composer":
    ensure  => "link",
    target  => "/usr/bin/composer-1.3.1.phar",
    require => File["/usr/bin/composer-1.3.1.phar"],
  }

}
