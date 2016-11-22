class cassandra($cluster_name, $seed_nodes, $listen_interface, $rpc_address, $broadcast_rpc_address) {

  require cassandra::packages

  file { "/etc/cassandra/cassandra.yaml":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("cassandra/etc/cassandra/cassandra.yaml.erb"),
    require => Class["cassandra::packages"],
    notify  => Service["cassandra"]
  }

  exec { "create swapfile for cassandra":
    command => "/bin/dd if=/dev/zero of=/swapfile1 bs=1M count=2048 && /bin/chmod 0600 /swapfile1 && /sbin/mkswap /swapfile1 && /sbin/swapon /swapfile1 && /bin/cat /etc/fstab | /bin/grep swapfile1 || echo '/swapfile1 swap swap defaults 0 0' >> /etc/fstab",
    creates => "/swapfile1",
    require => [ Package["cassandra"], File["/etc/cassandra/cassandra.yaml"] ]
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
    require    => [ Class["jre8"], Class["cassandra::packages"], Exec["initialize cassandra cluster"] ],
  }

  file { "/etc/cron.d/cassandra":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cassandra/etc/cron.d/cassandra",
    require => [ Class["jre8"], Class["cassandra::packages"], Exec["initialize cassandra cluster"] ],
  }

  # @TODO: nproc limit

}
