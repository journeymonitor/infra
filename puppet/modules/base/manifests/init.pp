class base {

  package { ["make", "g++", "sqlite", "htop"]:
    ensure => "installed",
  }

  file { ["/opt/puppet", "/opt/puppet/install"]:
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

}
