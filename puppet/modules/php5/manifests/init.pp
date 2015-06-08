class php5 {

  package { ["php5-cli", "php5-sqlite", "php5-curl", "php5-fpm"]:
    ensure => present,
    require => Exec["apt-get update"],
  }

}
