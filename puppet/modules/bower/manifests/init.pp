class bower {

  exec { "bower global install":
    command => "/usr/local/bin/npm install -g bower@1.4.1",
    creates => "/usr/local/lib/node_modules/bower/bin/bower",
    require => [ Class["nodejs"] ],
  }

}
