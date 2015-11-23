class selenium {

  package { ["xvfb", "firefox"]:
    ensure => "installed",
    require => [ Class["jre"], Exec["apt-get update"] ],
  }

  file { "/opt/selenese-runner-java":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "0755",
  }

  file { "/opt/selenese-runner-java/selenese-runner.jar":
    owner   => "root",
    group   => "root",
    mode    => "0755",
    source  => "puppet:///modules/selenium/opt/selenese-runner-java/selenese-runner.jar",
    require => File["/opt/selenese-runner-java"],
  }

}
