class jdk8 {

  exec { "add openjdk-8-jdk ppa for jdk8":
    command => "/usr/bin/add-apt-repository --yes ppa:openjdk-r/ppa",
    creates => "/etc/apt/sources.list.d/openjdk-r-ppa-trusty.list"
  }

  package { ["openjdk-7-jdk"]:
    ensure  => "purged",
  }

  package { ["openjdk-8-jdk"]:
    ensure  => "installed",
    require => [ Exec["add openjdk-8-jdk ppa for jdk8"], Exec["apt-get update"] ]
  }

}
