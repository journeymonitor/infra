class munin {

  package { [
    "munin"
  ]:
    ensure => "installed",
    require => Exec["apt-get update"],
  }

}
