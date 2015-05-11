# Allgemeines Modul das die Grundstuktur schafft für Programme, die manuell
# via Puppet installiert werden (wie zB Node.js)

class install {

  file { ["/opt/puppet", "/opt/puppet/install"]:
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

}
