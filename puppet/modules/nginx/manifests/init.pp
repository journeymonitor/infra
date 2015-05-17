class nginx {

  package { ["nginx"]:
    ensure => "installed"
  }

  file { "/etc/nginx/sites-available/journeymonitor.com":
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/nginx/etc/nginx/sites-available/journeymonitor.com",
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
    restart    => "/etc/init.d/nginx configtest && /etc/init.d/nginx reload", # Wir starten nur neu, wenn es keine Konfigurationsfehler gibt
    enable     => true,
    require    => [ Package["nginx"], Package["php5-fpm"] ],
  }

}