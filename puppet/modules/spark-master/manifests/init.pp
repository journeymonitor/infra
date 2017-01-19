class spark-master ($worker_webui_startport = 8081) {

  file { "/tmp/spark-events":
    ensure => "directory",
    owner  => "journeymonitor",
    group  => "journeymonitor",
    mode   => 0644,
  }

  exec { "download spark":
    command => '/usr/bin/curl -L "http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2-bin-hadoop2.7.tgz" -o /opt/puppet/install/spark-2.0.2-bin-hadoop2.7.tgz > /opt/puppet/install/download-spark.log 2>&1',
    timeout => 1800,
    creates => "/opt/puppet/install/spark-2.0.2-bin-hadoop2.7.tgz",
    require => File["/opt/puppet/install"],
  }

  exec { "install spark":
    command => "/bin/tar xvfz /opt/puppet/install/spark-2.0.2-bin-hadoop2.7.tgz -C /opt > /opt/puppet/install/install-spark.log 2>&1",
    creates => "/opt/spark-2.0.2-bin-hadoop2.7/",
    require => Exec["download spark"],
  }

  exec { "run spark master":
    environment => [
      "SPARK_WORKER_WEBUI_PORT=${worker_webui_startport}",
    ],
    command => "/bin/bash /opt/spark-2.0.2-bin-hadoop2.7/sbin/start-master.sh >> /var/log/spark-master.log 2>&1",
    unless  => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.master.Master" | /bin/grep -v "grep"',
    require => [ File["/tmp/spark-events"], Exec["install spark"], Class["jre8"] ],
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
    command     => "/bin/bash /opt/spark-2.0.2-bin-hadoop2.7/sbin/start-slave.sh spark://${fqdn}:7077 >> /var/log/spark-worker.log 2>&1",
    unless      => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.worker.Worker" | /bin/grep -v "grep"',
    require     => [ Exec["install spark"], Exec["run spark master"] ],
    tag         => "run-spark-worker"
  }
  */

}
