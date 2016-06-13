class jre7 {

  package { ["openjdk-7-jre-headless"]:
    ensure  => "installed",
    require => [ Class["jre8"] ] # jre7 is an additional install next to jre8 (which also sets up the PPA etc.)
  }

  # Make extra sure that Java 8 JRE is the default
  exec { "really make openjdk-8-jre the default Java":
    command => "/usr/bin/update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java",
    require => [ Class["jre8"], Package["openjdk-7-jre-headless"] ]
  }

}
