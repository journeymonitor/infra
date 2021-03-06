class base {

  include base-minimal

  package {
    [ "openssh-server",
      "ethtool",
      "tcpdump",
      "htop",
      "iotop",
      "sysstat",
      "acpid",
      "bwm-ng",
    ]:
      ensure => present,
      require => [ Class["base-minimal"], Exec["apt-get update"] ]
  }

}
