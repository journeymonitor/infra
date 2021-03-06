# Additional stuff for satisfying the requirements
# for running the ANALYZE applications

class app-analyze($cassandra_cqlsh_host) {

  # We need the cassandra-tools in order to be able to run cqlsh
  require cassandra::packages

  # we need maven during app deployment
  package { [
    "maven"
  ]:
    ensure  => "installed",
  }

  service { "cassandra":
    ensure     => "stopped",
    hasstatus  => true,
    hasrestart => true,
    enable     => false,
    require    => [ Class["cassandra::packages"] ],
  }

  # TODO: This will fail if applied before the C* cluster runs
  exec { "create analyze cassandra keyspace":
    command => "/usr/bin/cqlsh ${cassandra_cqlsh_host} -e \"CREATE KEYSPACE IF NOT EXISTS analyze WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };\"",
    require => Class["cassandra::packages"]
  }

}
