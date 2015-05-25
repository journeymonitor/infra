class unattended-upgrades {

  package { [ "unattended-upgrades" ]:
    ensure => present,
  }

  file { "/etc/apt/apt.conf.d/50unattended-upgrades":
    require => Package["unattended-upgrades"],
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/unattended-updates/etc/apt/apt.conf.d/50unattended-upgrades",
  }

  file { "/etc/apt/apt.conf.d/10periodic":
    require => Package["unattended-upgrades"],
    owner   => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/unattended-upgrades/etc/apt/apt.conf.d/10periodic",
  }

}
