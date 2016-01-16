class simplecd {

  file { "/opt/simplecd":
    ensure  => "directory",
    require => Package["git"],
  }

  exec { "install simplecd":
    command => "/usr/bin/curl https://raw.githubusercontent.com/manuelkiessling/simplecd/master/simplecd.sh -o /opt/simplecd/simplecd.sh",
    user    => "root",
    require => File["/opt/simplecd"],
  }

  file { "/opt/simplecd/simplecd.sh":
    mode    => "0755",
    require => Exec["install simplecd"],
  }

}