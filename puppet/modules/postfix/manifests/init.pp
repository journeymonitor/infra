class postfix {

  package {["postfix", "mailutils"]:
    ensure => "installed",
    require => Exec["apt-get update"],
  }

}