class cassandra($cluster_name, $seed_nodes, $listen_interface) {
  
  file { "/etc/apt/sources.list.d/cassandra.sources.list":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cassandra/etc/apt/sources.list.d/cassandra.sources.list",
  }

  exec { "add datastax apt key":
    command => "/usr/bin/curl -L https://debian.datastax.com/debian/repo_key | /usr/bin/apt-key add -",
    require => File["/etc/apt/sources.list.d/cassandra.sources.list"]
  }

  exec { "apt-get update for cassandra":
    command => "/usr/bin/apt-get -qq -y update",
    require => [ File["/etc/apt/sources.list.d/cassandra.sources.list"], Exec["add datastax apt key"] ]
  }

  package { [
             "cassandra",
             ]:
    ensure  => "2.2.3",
    require => Exec["apt-get update for cassandra"]
  }

  package { [
    "cassandra-tools"
  ]:
    ensure  => "2.2.3",
    require => Package["cassandra"]
  }

  file { "/etc/cassandra/cassandra.yaml":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("cassandra/etc/cassandra/cassandra.yaml.erb"),
    require => Package["cassandra"]
  }

  # See http://docs.datastax.com/en/cassandra/2.2/cassandra/install/installDeb.html
  # The deb starts Cassandra after package installation, but then we don't have the
  # right cluster setup, which is why we need to throw stuff away and restart
  exec { "initialize cassandra cluster":
    command => "/usr/sbin/service cassandra stop; /bin/sleep 10; /bin/rm -rf /var/lib/cassandra/data/system/*; touch /opt/puppet/flags/cassandra.installreset.flag; /usr/sbin/service cassandra start",
    creates => "/opt/puppet/flags/cassandra.installreset.flag",
    require => [ File["/opt/puppet/flags"], Package["cassandra"], File["/etc/cassandra/cassandra.yaml"] ]
  }

  # @TODO: nproc limit

}
