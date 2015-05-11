class phantomjs {

  exec { "phantomjs global install":
    command => "/usr/local/bin/npm install -g phantomjs@1.9.7",
    creates => "/usr/local/lib/node_modules/phantomjs/bin/phantomjs",
    require => Class["nodejs"],
  }

}
