# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
  end

  config.vm.define "journeymonitor1" do |journeymonitor1|
    journeymonitor1.vm.box = "ubuntu/trusty64"
    journeymonitor1.vm.network "private_network", ip: "192.168.56.101"
  end

end
