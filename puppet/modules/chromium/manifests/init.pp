class chromium {

  package { ["chromium-browser", "chromium-chromedriver"]:
    ensure => "installed",
    require => [ Exec["apt-get update"] ],
  }

}
