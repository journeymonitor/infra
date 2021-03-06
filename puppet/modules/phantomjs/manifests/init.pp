class phantomjs {

  package { ["libfontconfig1"]:
    ensure => "installed",
    require => Exec["apt-get update"],
  }

  exec { "phantomjs global install":
    command => "/usr/bin/npm install -g phantomjs@1.9.16",
    creates => "/usr/lib/node_modules/phantomjs/bin/phantomjs",
    require => [ Class["nodejs"], Package["libfontconfig1"] ],
  }

}
