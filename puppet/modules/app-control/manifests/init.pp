# Additional stuff for satisfying the requirements
# for running the CONTROL applications

class app-control {

  file { [
          "/opt",
          "/opt/journeymonitor",
          "/opt/journeymonitor/control",
          "/opt/journeymonitor/control/statisticsimporter"
         ]:
    ensure  => "directory",
    mode    => "0644",
    owner   => "root",
    group   => "root",
  }

  file { ["/opt/journeymonitor/control/statisticsimporter/start.sh"]:
    owner   => "root",
    group   => "root",
    mode    => "0755",
    content => template("app-control/opt/journeymonitor/control/statisticsimporter/start.sh.erb"),
    require => [ File["/opt/journeymonitor/control/statisticsimporter"], File["/etc/journeymonitor/app-control-env.sh"] ]
  }

}
