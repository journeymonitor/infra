class base {

  package {
    [ "openssh-server",
      "ethtool",
      "tcpdump",
      "vim",
      "htop",
      "iotop",
      "sysstat",
      "acpid",
      "unzip",
      "bwm-ng",
      "make",
      "g++",
      "curl",
      "sqlite",
      "imagemagick", # @TODO: This probably belongs into an app-specific module
      "git"
    ]:
      ensure => present,
      require => Exec["apt-get update"],
  }

  file { ["/opt/puppet", "/opt/puppet/install"]:
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

  file { ["/var/tmp/journeymonitor-screenshots"]:
    ensure => "directory",
    owner  => "journeymonitor",
    group  => "journeymonitor",
    mode   => 0755,
  }

  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
  }

}
