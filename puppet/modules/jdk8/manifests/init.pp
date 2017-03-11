class jdk8 {

  exec { "add openjdk-8-jdk ppa for jdk8":
    command => "/usr/bin/add-apt-repository --yes ppa:openjdk-r/ppa",
    creates => "/etc/apt/sources.list.d/openjdk-r-ppa-trusty.list",
    require => Package["software-properties-common"]
  }

  exec { "apt-get update after adding openjdk-8-jdk ppa for jdk8":
    command => "/usr/bin/apt-get update",
    require => [ Exec["add openjdk-8-jdk ppa for jdk8"] ]
  }

  package { ["openjdk-7-jdk"]:
    ensure  => "purged",
  }

  package { ["openjdk-8-jdk"]:
    ensure  => "installed",
    require => [ Exec["apt-get update after adding openjdk-8-jdk ppa for jdk8"] ]
  }

}
