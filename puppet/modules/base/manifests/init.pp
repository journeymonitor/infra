class base {

  package { ["make", "g++", "sqlite", "htop", "imagemagick"]:
    ensure => "installed",
  }

  file { ["/opt/puppet", "/opt/puppet/install"]:
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

  file { ["/var/tmp/selenior-screenshots"]:
    ensure => "directory",
    owner  => "selenior",
    group  => "selenior",
    mode   => 0755,
  }

}
