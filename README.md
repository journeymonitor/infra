# Selenior - MONITOR - maschine-provisionor

## About

This service is responsible for providing VMs that can be used to schedule
Selenium-based monitoring jobs onto them.


## Setup instructions

The following applies to a vanilla Ubuntu 14.04 64bit system.

    sudo apt-get install puppet
    mkdir -p /opt/selenior
    cd /opt/selenior
    git clone git@bitbucket.org:selenior/monitor-maschine-provisionor.git
    cd monitor-maschine-provisionor/puppet
    puppet apply --verbose --modulepath=./modules manifests/site.pp
    
