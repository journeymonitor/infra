class spark-slave ($worker_webui_startport = 8081, $master_address) {

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

  exec { "run spark worker":
    environment => [
      "SPARK_WORKER_WEBUI_PORT=${worker_webui_startport}",
    ],
    command     => "/bin/bash /opt/spark-2.0.2-bin-hadoop2.7/sbin/start-slave.sh spark://${master_address}:7077 >> /var/log/spark-worker.log 2>&1",
    unless      => '/bin/ps axu | /bin/grep "java" | /bin/grep "org.apache.spark.deploy.worker.Worker" | /bin/grep -v "grep"',
    require     => [ Exec["install spark"], Class["jre8"] ],
    tag         => "run-spark-worker"
  }


  /*

  The following only works once we switch to a Master-Agent
  setup with Puppet including PuppetDB, or at least enable
  the masterless "puppet apply" approach to use a PuppetDB
  as described in https://docs.puppetlabs.com/puppetdb/latest/connect_puppet_apply.html

  # Collect the resource that starts a Spark worker process, which has been exported by the master
  # See ../../spark-master/manifests/init.pp:L22
  Exec <<| tag == 'run-spark-worker' |>>

  */

}
