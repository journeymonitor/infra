class php7_1 ($fpm_user = "www-data") {

  # We want a PHP 7.1-only system as far as possible
  package { [
    "php5-cli",
    "php5-sqlite",
    "php5-curl",
    "php5-fpm",
    "php5-common",
    "php5-json",
    "php5-readline"
  ]:
    ensure  => absent,
    require => Exec["apt-get update"],
  }

  exec { "add ondrej/php ppa":
    environment => [
      "LC_ALL=C.UTF-8",
    ],
    command => "/usr/bin/add-apt-repository --yes ppa:ondrej/php",
    creates => "/etc/apt/sources.list.d/ondrej-php-trusty.list",
    require => Package[ "software-properties-common" ]
  }

  exec { "apt-get update after adding ondrej/php ppa":
    command => "/usr/bin/apt-get update",
    require => [ Exec["add ondrej/php ppa"] ]
  }

  package { [
    "php7.1-cli",
    "php7.1-sqlite3",
    "php7.1-curl",
    "php7.1-fpm",
    "php7.1-xml",
    "php7.1-mbstring"
  ]:
    ensure  => present,
    require => Exec["apt-get update after adding ondrej/php ppa"],
  }

  service { "php7.1-fpm":
    ensure  => running,
    require => [ Package["php7.1-fpm"] ],
  }

  file { "/etc/php/7.1/fpm/pool.d/www.conf":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("php7_1/etc/php/7.1/fpm/pool.d/www.conf.erb"),
    require => [ Package["php7.1-fpm"] ],
    notify  => Service["php7.1-fpm"],
  }

}
