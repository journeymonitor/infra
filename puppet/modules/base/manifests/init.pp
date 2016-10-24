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
      "git",
      "software-properties-common"  # for add-apt-repository
    ]:
      ensure => present,
      require => Exec["apt-get update"],
  }

  file { ["/opt/puppet", "/opt/puppet/install", "/opt/puppet/flags"]:
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
  }

}
