class firefox {

  package { ["firefox"]:
    ensure => "purged",
    require => [ Exec["apt-get update"] ],
  }

  package { ["bzip2", "libxcomposite1", "libasound2", "libgtk2.0-0"]:
    ensure => "installed",
    require => [ Exec["apt-get update"] ],
  }

  exec { "download firefox":
    command => "/usr/bin/curl -o /var/tmp/firefox-45.7.0esr.tar.bz2 https://ftp.mozilla.org/pub/firefox/releases/45.7.0esr/linux-x86_64/en-US/firefox-45.7.0esr.tar.bz2 > /opt/puppet/install/install-firefox.log 2>&1",
    creates => "/var/tmp/firefox-45.7.0esr.tar.bz2",
    require => [ Package["curl", "firefox"], File["/opt/puppet/install"] ],
  }

  exec { "extract firefox":
    cwd     => "/opt",
    command => "/bin/rm -rf /opt/firefox && /bin/tar xvfj /var/tmp/firefox-45.7.0esr.tar.bz2",
    unless  => "/bin/grep '45.7.0' /opt/firefox/application.ini",
    require => [ Package["bzip2"] ],
  }

  file { "/usr/bin/firefox":
    ensure => "link",
    target => "/opt/firefox/firefox",
    require => [ Exec["extract firefox"], Package["libxcomposite1", "libasound2", "libgtk2.0-0"] ],
  }

}
