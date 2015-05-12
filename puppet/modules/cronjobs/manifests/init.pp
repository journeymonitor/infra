class cronjobs {

  file { "/etc/cron.d":
    ensure => "directory",
    mode => "0775",
    group => "selenior",
    require => Group["selenior"]
  }

  file { "/etc/cron.d/selenior":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/cronjobs/etc/cron.d/selenior",
  }

}