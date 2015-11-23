class jdk {

  package { ["default-jdk"]:
    ensure  => "installed",
    require => Exec["apt-get update"],
  }

}
