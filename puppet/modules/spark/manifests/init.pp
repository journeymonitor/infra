class spark ($worker_webui_startport = 8081) {

  exec { "download spark":
    command => '/usr/bin/curl -L "https://dl.bintray.com/journeymonitor/infra-artifacts/spark-1.5.1-bin-hadoop-2.6_scala-2.11.tgz" -o /opt/puppet/install/spark-1.5.1-bin-hadoop-2.6_scala-2.11.tgz > /opt/puppet/install/download-spark.log 2>&1',
    timeout => 1800,
    creates => "/opt/puppet/install/spark-1.5.1-bin-hadoop-2.6_scala-2.11.tgz",
    require => File["/opt/puppet/install"],
  }

  exec { "install spark":
    command => "/bin/tar xvfz /opt/puppet/install/spark-1.5.1-bin-hadoop-2.6_scala-2.11.tgz -C /opt > /opt/puppet/install/install-spark.log 2>&1",
    creates => "/opt/spark-1.5.1-bin-hadoop-2.6_scala-2.11/",
    require => Exec["download spark"],
  }

  exec { "run spark master":
    command => "/bin/bash /opt/spark-1.5.1-bin-hadoop-2.6_scala-2.11/sbin/start-master.sh >> /var/log/spark-master.log 2>&1",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.master.Master" | /bin/grep -v "grep"',
    require => [ Exec["install spark"], Package["default-jre-headless"] ],
  }

  exec { "run spark worker":
    environment => ["SPARK_WORKER_WEBUI_PORT=${worker_webui_startport}"],
    command => "/bin/bash /opt/spark-1.5.1-bin-hadoop-2.6_scala-2.11/sbin/start-slave.sh spark://127.0.0.1:7077 >> /var/log/spark-worker.log 2>&1",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.worker.Worker" | /bin/grep -v "grep"',
    require => Exec["run spark master"],
  }

}
