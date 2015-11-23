class sbt {

  file { "/etc/apt/sources.list.d/sbt.sources.list":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/sbt/etc/apt/sources.list.d/sbt.sources.list",
  }

  exec { "add sbt apt key":
    command => "/usr/bin/apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823",
    require => File["/etc/apt/sources.list.d/sbt.sources.list"]
  }

  exec { "apt-get update for sbt":
    command => "/usr/bin/apt-get -qq -y update",
    require => [ File["/etc/apt/sources.list.d/sbt.sources.list"], Exec["add sbt apt key"] ]
  }

  package { [
    "sbt",
  ]:
    ensure  => present,
    require => Exec["apt-get update for sbt"]
  }

}
