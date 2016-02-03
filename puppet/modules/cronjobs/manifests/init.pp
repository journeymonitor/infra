define createCronjobFile($env) {
  file { "/etc/cron.d/journeymonitor-${name}":
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => template("cronjobs/etc/cron.d/journeymonitor-${name}.erb"),
    require => [ File["/etc/cron.d"] ]
  }
}

class cronjobs (
  $applications = hiera_array("applications"),
  $other_cronjobs = hiera_array("other_cronjobs"),
  $env,
  $disable_infra_ci = false) {

  file { "/etc/cron.d":
    ensure  => "directory",
    mode    => "0775",
    group   => "journeymonitor",
    require => Group["journeymonitor"]
  }

  file { "/etc/cron.d/journeymonitor-infra":
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => template("cronjobs/etc/cron.d/journeymonitor-infra.erb"),
    require => [ File["/etc/cron.d"], File["/opt/simplecd/simplecd.sh"] ]
  }

  createCronjobFile { $applications:
    env         => $env,
  }

  createCronjobFile { "other-${$other_cronjobs}":
    env         => $env,
  }

}
