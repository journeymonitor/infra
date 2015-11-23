class jre {

  package { ["default-jre-headless"]:
    ensure  => "installed",
    require => Exec["apt-get update"],
  }

}
