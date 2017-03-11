class selenium {

  include firefox

  package { ["xvfb"]:
    ensure => "installed",
    require => [ Class["firefox"], Class["jre7"], Exec["apt-get update"] ],
  }

  file { "/opt/selenese-runner-java":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => "0755",
  }

  file { "/opt/selenese-runner-java/selenese-runner-2.13.0.jar":
    owner   => "root",
    group   => "root",
    mode    => "0755",
    source  => "puppet:///modules/selenium/opt/selenese-runner-java/selenese-runner-2.13.0.jar",
    require => File["/opt/selenese-runner-java"],
  }

  file { "/opt/selenese-runner-java/selenese-runner.jar":
    ensure => "link",
    target => "/opt/selenese-runner-java/selenese-runner-2.13.0.jar",
    require => File["/opt/selenese-runner-java/selenese-runner-2.13.0.jar"],
  }

}
