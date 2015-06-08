class nginx ($app_env = "prod") {

  package { ["nginx"]:
    ensure => "installed",
    require => Exec["apt-get update"],
  }

  file { "/etc/nginx/sites-available/journeymonitor.com":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    content => template("nginx/etc/nginx/sites-available/journeymonitor.com.erb"),
    require => [ Package["nginx"], Package["php5-fpm"] ],
    notify  => Service["nginx"],
  }

  file { "/etc/nginx/sites-enabled/journeymonitor.com":
    ensure  => "link",
    target  => "/etc/nginx/sites-available/journeymonitor.com",
    require => [ Package["nginx"], Package["php5-fpm"] ],
    notify  => Service["nginx"],
  }

  service { "nginx":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    restart    => "/etc/init.d/nginx configtest && /etc/init.d/nginx reload", # Only restart if configuration is okay
    enable     => true,
    require    => [ Package["nginx"], Package["php5-fpm"] ],
  }

}
