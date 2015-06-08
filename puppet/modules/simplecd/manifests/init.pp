class simplecd {

  file { "/opt/simplecd":
    ensure  => "directory",
    require => Package["git"],
  }

  exec { "install simplecd":
    command => "/usr/bin/curl https://raw.githubusercontent.com/manuelkiessling/simplecd/master/simplecd.sh -o /opt/simplecd/simplecd.sh",
    require => File["/opt/simplecd"],
    creates => "/opt/simplecd/simplecd.sh",
  }

  file { "/opt/simplecd/simplecd.sh":
    mode    => "0755",
    require => Exec["install simplecd"],
  }

}