class cassandra($cluster_name, $seed_nodes, $listen_interface) {

  require cassandra::packages

  file { "/etc/cassandra/cassandra.yaml":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("cassandra/etc/cassandra/cassandra.yaml.erb"),
    require => Class["cassandra::packages"],
    notify  => Service["cassandra"]
  }

  # See http://docs.datastax.com/en/cassandra/2.2/cassandra/install/installDeb.html
  # The deb starts Cassandra after package installation, but then we don't have the
  # right cluster setup, which is why we need to throw stuff away and restart
  exec { "initialize cassandra cluster":
    command => "/usr/sbin/service cassandra stop; /bin/sleep 10; /bin/rm -rf /var/lib/cassandra/data/system/*; touch /opt/puppet/flags/cassandra.installreset.flag; /usr/sbin/service cassandra start",
    creates => "/opt/puppet/flags/cassandra.installreset.flag",
    require => [ File["/opt/puppet/flags"], Package["cassandra"], File["/etc/cassandra/cassandra.yaml"] ]
  }

  service { "cassandra":
    ensure     => "running",
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [ Class["cassandra::packages"], Exec["initialize cassandra cluster"] ],
  }

  # @TODO: nproc limit

}
