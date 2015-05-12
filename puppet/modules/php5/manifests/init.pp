class php5 {

  package { ["php5-cli", "php5-sqlite"]:
    ensure => present,
  }

}
