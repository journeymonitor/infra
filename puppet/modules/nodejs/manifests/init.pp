class nodejs {

  file { "/opt/puppet/install/node-v0.12.2.tar.gz":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/nodejs/opt/puppet/install/node-v0.12.2.tar.gz",
    require => File["/opt/puppet/install"],
  }

  file { "/opt/puppet/install/install-nodejs.sh":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/nodejs/opt/puppet/install/install-nodejs.sh",
    require => File["/opt/puppet/install"],
  }

  exec { "install nodejs":
    command => "/bin/bash /opt/puppet/install/install-nodejs.sh > /opt/puppet/install/install-nodejs.log 2>&1",
    timeout => 1200,
    unless  => "/usr/bin/test \"`/usr/local/bin/node --version`\" = \"v0.12.2\"",
    require => [ Package[ ["make", "g++"] ], File[ ["/opt/puppet/install/install-nodejs.sh", "/opt/puppet/install/node-v0.12.2.tar.gz"] ] ],
  }

}
