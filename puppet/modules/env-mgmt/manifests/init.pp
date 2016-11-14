class env-mgmt {

  file { "/etc/journeymonitor":
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => 0644
  }

  file { "/etc/journeymonitor/app-analyze-env.sh":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("env-mgmt/etc/journeymonitor/app-analyze-env.sh.erb"),
    require => File["/etc/journeymonitor"]
  }

  file { "/etc/journeymonitor/app-control-env.sh":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("env-mgmt/etc/journeymonitor/app-control-env.sh.erb"),
    require => File["/etc/journeymonitor"]
  }

}
