class nodejs {

  file { "/opt/puppet/install/nodesource_nodejs_setup_7.x.sh":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/nodejs/opt/puppet/install/nodesource_nodejs_setup_7.x.sh",
    require => File["/opt/puppet/install"],
  }

  exec { "setup nodesource nodejs":
    command => "/bin/bash /opt/puppet/install/nodesource_nodejs_setup_7.x.sh > /opt/puppet/install/nodesource_nodejs_setup_7.x.log 2>&1",
    creates => "/etc/apt/sources.list.d/nodesource.list",
    require => [ File[ "/opt/puppet/install/nodesource_nodejs_setup_7.x.sh"] ],
  }

  package { ["nodejs"]:
    ensure => "installed",
    require => Exec["setup nodesource nodejs"],
  }

}
