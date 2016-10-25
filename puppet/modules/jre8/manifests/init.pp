class jre8 {

  exec { "add openjdk-8-jdk ppa for jre8":
    command => "/usr/bin/add-apt-repository --yes ppa:openjdk-r/ppa",
    creates => "/etc/apt/sources.list.d/openjdk-r-ppa-trusty.list"
  }

  exec { "apt-get update after adding openjdk-8-jdk ppa":
    command => "/usr/bin/apt-get update",
    require => [ Exec["add openjdk-8-jdk ppa for jre8"] ]
  }

  package { ["openjdk-8-jre-headless"]:
    ensure  => "installed",
    require => [ Exec["add openjdk-8-jdk ppa for jre8"], Exec["apt-get update after adding openjdk-8-jdk ppa"] ]
  }

  exec { "make openjdk-8-jre the default Java":
    command => "/usr/bin/update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java",
    require => Package["openjdk-8-jre-headless"]
  }

}
