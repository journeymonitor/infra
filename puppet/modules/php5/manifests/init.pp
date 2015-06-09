class php5 ($fpm_user = "www-data") {

  package { ["php5-cli", "php5-sqlite", "php5-curl", "php5-fpm"]:
    ensure => present,
    require => Exec["apt-get update"],
  }

  service { "php5-fpm":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [ Package["php5-fpm"] ],
  }

  file { "/etc/php5/fpm/pool.d/www.conf":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("php5/etc/php5/fpm/pool.d/www.conf.erb"),
    require => [ Package["php5-fpm"] ],
    notify  => Service["php5-fpm"],
  }

}
