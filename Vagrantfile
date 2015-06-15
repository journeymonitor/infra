# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.59.99"

  config.vm.synced_folder "../control/", "/opt/journeymonitor/control", nfs: true
  config.vm.synced_folder "../monitor/", "/opt/journeymonitor/monitor", nfs: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 4
    vb.gui = true
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "puppet/hiera.yaml"
    puppet.facter = {
        "vagrant" => "1",
        "puppet_root" => "/vagrant/puppet"
    }
  end

  config.vm.define "journeymonitor" do |journeymonitor|
    journeymonitor.vm.box = "ubuntu/trusty64"
    journeymonitor.vm.hostname = "journeymonitor.dev"
  end

end
