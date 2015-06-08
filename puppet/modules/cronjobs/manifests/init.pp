define createCronjobFile($application, $env) {
  file { "/etc/cron.d/selenior-${name}":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("cronjobs/etc/cron.d/selenior-${name}.erb"),
    require => [ File["/etc/cron.d"] ]
  }
}

class cronjobs ($applications = hiera_array("applications"), $env) {

  file { "/etc/cron.d":
    ensure => "directory",
    mode => "0775",
    group => "selenior",
    require => Group["selenior"]
  }

  file { "/etc/cron.d/selenior-infra":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("cronjobs/etc/cron.d/selenior-infra.erb"),
    require => [ File["/etc/cron.d"], File["/opt/simplecd/simplecd.sh"], Exec["composer global install"] ]
  }

  createCronjobFile { $applications:
    application => $applications,
    env         => $env,
  }

}
