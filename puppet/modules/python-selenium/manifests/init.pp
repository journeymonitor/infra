class python-selenium {

  package { "python-pip":
    ensure => present,
    require => Exec["apt-get update"],
  }

  exec { "pip install selenium":
    command => "/usr/bin/pip install --upgrade selenium",
    user    => "root",
    require => Package["python-pip"],
  }

}
