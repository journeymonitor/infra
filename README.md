# JourneyMonitor - INFRA

## About

This repository is responsible for providing setups where JourneyMonitor applications can be run.


## Setup instructions

### Setting up a development environment

- Install VirtualBox
- Install Vagrant
- Install Git

    git clone git@bitbucket.org:selenior/infra.git
    cd infra
    vagrant up
    
This gives you a virtual machine at IP 192.168.99.99.

The following applies to this machine:

- If there is a change to the master branch of this repository, the changes are applied
  to the machine via puppet - that is, the VM automatically stays up to date. Within the
  VM, the file `/etc/cron.d/selenior-infra is responsible for this.

