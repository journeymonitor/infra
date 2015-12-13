class jre8 {

  exec { "add openjdk-8-jdk ppa for jre8":
    command => "/usr/bin/add-apt-repository --yes ppa:openjdk-r/ppa",
    creates => "/etc/apt/sources.list.d/openjdk-r-ppa-trusty.list"
  }

  package { ["openjdk-7-jre-headless"]:
    ensure  => "purged",
  }

  package { ["openjdk-8-jre-headless"]:
    ensure  => "installed",
    require => [ Exec["add openjdk-8-jdk ppa for jre8"], Exec["apt-get update"] ]
  }

}
