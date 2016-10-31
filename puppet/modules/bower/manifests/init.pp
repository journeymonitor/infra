class bower {

  exec { "bower global install":
    command => "/usr/bin/npm install -g bower@1.4.1",
    creates => "/usr/lib/node_modules/bower/bin/bower",
    require => [ Class["nodejs"] ],
  }

}
