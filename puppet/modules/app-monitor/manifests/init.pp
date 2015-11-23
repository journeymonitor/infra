# Additional stuff for satisfying the requirements
# for running the MONITOR applications

class app-monitor {

  package { [
    "imagemagick"
  ]:
    ensure  => present
  }

  file { ["/var/tmp/journeymonitor-screenshots"]:
    ensure => "directory",
    owner  => "journeymonitor",
    group  => "journeymonitor",
    mode   => 0755,
  }

}
