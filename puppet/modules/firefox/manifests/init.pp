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
    command => "/usr/bin/curl -o /var/tmp/firefox-45.4.0esr.tar.bz2 https://ftp.mozilla.org/pub/firefox/releases/45.4.0esr/linux-x86_64/en-US/firefox-45.4.0esr.tar.bz2 > /opt/puppet/install/install-firefox.log 2>&1",
    creates => "/var/tmp/firefox-45.4.0esr.tar.bz2",
    require => [ Package["curl", "firefox"] ],
  }

  exec { "extract firefox":
    cwd     => "/opt",
    command => "/bin/tar xvfj /var/tmp/firefox-45.4.0esr.tar.bz2",
    creates => "/var/opt/firefox",
    require => [ Package["bzip2"] ],
  }

  file { "/usr/bin/firefox":
    ensure => "link",
    target => "/opt/firefox/firefox",
    require => [ Exec["extract firefox"], Package["libxcomposite1", "libasound2", "libgtk2.0-0"] ],
  }

}
