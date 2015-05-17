class composer {

  exec { "composer global install":
    command => "/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php ; /bin/mv composer.phar /usr/bin/composer",
    creates => "/usr/bin/composer",
    require => [ Class["php5"] ],
  }

}
