class kafka {

  file { "/opt/puppet/install/kafka_2.11-0.8.2.2.tgz":
    owner   => "root",
    group   => "root",
    mode    => 0755,
    source  => "puppet:///modules/kafka/opt/puppet/install/kafka_2.11-0.8.2.2.tgz",
    require => [ File["/opt/puppet/install"], Class["jre7"] ]
  }

  exec { "install kafka":
    command => "/bin/tar xvfz /opt/puppet/install/kafka_2.11-0.8.2.2.tgz -C /opt > /opt/puppet/install/install-kafka.log 2>&1",
    creates => "/opt/kafka_2.11-0.8.2.2/",
    require => File["/opt/puppet/install/kafka_2.11-0.8.2.2.tgz"],
  }

  exec { "run zookeeper for kafka":
    command => "/usr/bin/nohup /bin/bash /opt/kafka_2.11-0.8.2.2/bin/zookeeper-server-start.sh /opt/kafka_2.11-0.8.2.2/config/zookeeper.properties >> /var/log/zookeeper-for-kafka.log 2>&1 &",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "kafka" | /bin/grep "zookeeper.properties" | /bin/grep -v "grep"',
    require => Exec["install kafka"],
  }

  exec { "run kafka server":
    environment => [
      "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64",
      "JRE_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre",
    ],
    command => "/usr/bin/nohup /bin/bash /opt/kafka_2.11-0.8.2.2/bin/kafka-server-start.sh /opt/kafka_2.11-0.8.2.2/config/server.properties >> /var/log/kafka-server.log 2>&1 &",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "kafka" | /bin/grep "server.properties" | /bin/grep -v "grep"',
    require => Exec["run zookeeper for kafka"],
  }

}
