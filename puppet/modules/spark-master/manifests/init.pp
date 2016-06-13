class spark-master ($worker_webui_startport = 8081) {

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
    environment => [
      "SPARK_WORKER_WEBUI_PORT=${worker_webui_startport}",
      "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64",
      "JRE_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre",
    ],
    command => "/bin/bash /opt/spark-1.5.1-bin-hadoop-2.6_scala-2.11/sbin/start-master.sh >> /var/log/spark-master.log 2>&1",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.master.Master" | /bin/grep -v "grep"',
    require => [ Exec["install spark"], Class["jre7"] ],
  }

  /*

  The following only works once we switch to a Master-Agent
  setup with Puppet including PuppetDB, or at least enable
  the masterless "puppet apply" approach to use a PuppetDB
  as described in https://docs.puppetlabs.com/puppetdb/latest/connect_puppet_apply.html

  # Exports the resource for starting a Spark worker to the Puppet system - gets collected and applied on all nodes with the "spark-slave" class
  # See ../../spark-slave/manifests/init.pp:L16
  @@exec { "run spark worker":
    environment => ["SPARK_WORKER_WEBUI_PORT=${worker_webui_startport}"],
    command     => "/bin/bash /opt/spark-1.5.1-bin-hadoop-2.6_scala-2.11/sbin/start-slave.sh spark://${fqdn}:7077 >> /var/log/spark-worker.log 2>&1",
    unless      => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.worker.Worker" | /bin/grep -v "grep"',
    require     => [ Exec["install spark"], Exec["run spark master"] ],
    tag         => "run-spark-worker"
  }
  */

}
