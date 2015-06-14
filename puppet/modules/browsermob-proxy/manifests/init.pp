class browsermob-proxy {

  file { "/opt/puppet/install/browsermob-proxy-2.0.0-bin.zip":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/browsermob-proxy/opt/puppet/install/browsermob-proxy-2.0.0-bin.zip",
    require => File["/opt/puppet/install"],
  }

  exec { "install browsermob-proxy":
    command => "/usr/bin/unzip /opt/puppet/install/browsermob-proxy-2.0.0-bin.zip -d /opt > /opt/puppet/install/install-browsermob-proxy.log 2>&1",
    creates => "/opt/browsermob-proxy-2.0.0/bin/browsermob-proxy",
    require => [ Package[ ["unzip", "default-jre-headless"] ], File[ ["/opt/puppet/install/browsermob-proxy-2.0.0-bin.zip"] ] ],
  }

  exec { "run browsermob-proxy":
    command => "/usr/bin/nohup /bin/bash /opt/browsermob-proxy-2.0.0/bin/browsermob-proxy --address 127.0.0.1 --port 9090 --ttl 3600 >> /var/log/browsermob-proxy.log 2>&1 &",
    unless  => '/bin/ps axu | /bin/grep "java -classpath :/opt/browsermob-proxy-2.0.0" | /bin/grep -v "grep"',
    require => [ Package[ ["unzip", "default-jre-headless"] ], File[ ["/opt/puppet/install/browsermob-proxy-2.0.0-bin.zip"] ] ],
  }

}
