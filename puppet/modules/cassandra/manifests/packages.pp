class cassandra::packages {

  file { "/etc/apt/sources.list.d/cassandra.sources.list":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cassandra/etc/apt/sources.list.d/cassandra.sources.list",
  }

  # todo: check for lockfile
  exec { "add datastax apt key":
    command => "/usr/bin/curl -L https://debian.datastax.com/debian/repo_key | /usr/bin/apt-key add -",
    require => File["/etc/apt/sources.list.d/cassandra.sources.list"]
  }

  # todo: check for age of lockfile (only run every 24h)
  exec { "apt-get update for cassandra":
    command => "/usr/bin/apt-get -qq -y update",
    require => [ File["/etc/apt/sources.list.d/cassandra.sources.list"], Exec["add datastax apt key"] ]
  }

  # distinct "package" blocks are needed in order to ensure that
  # "cassandra" is installed first, because else we get
  # "Some packages could not be installed." from apt.
  package { [
    "dsc21",
    "cassandra",
  ]:
    require => Exec["apt-get update for cassandra"]
  }

  package { [
    "cassandra-tools"
  ]:
    require => Package["dsc30"]
  }

  file { "/etc/init.d/cassandra":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/cassandra/etc/init.d/cassandra",
    require => Package["dsc30"]
  }

}
