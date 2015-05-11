class python-selenium {

  package { "python-pip":
    ensure => present,
  }

  exec { "pip install selenium":
    command => "/usr/bin/pip install --upgrade selenium",
    user    => "root",
    require => Package["python-pip"],
  }

}
