# JourneyMonitor - INFRA

## About

This repository is responsible for providing setups where JourneyMonitor applications can be run.


## Setup instructions

### Setting up a development environment

- Install VirtualBox
- Install Vagrant
- Install Git
- `git clone git@bitbucket.org:selenior/control.git`
- `git clone git@bitbucket.org:selenior/monitor.git`
- `git clone git@bitbucket.org:selenior/infra.git`
- `cd infra`
- `vagrant up`

This gives you a virtual machine at IP `192.168.99.99`. Right now, the inital setup takes
quite some time because Node.js is compiled from sources.

The following applies to this machine:

- If there is a change to the master branch of this repository, the changes are applied
  to the machine via puppet - that is, the VM automatically stays up to date. Within the
  VM, the file `/etc/cron.d/selenior-infra is responsible for this.
- Within the VM, `/vagrant` is a mirror of the root directory of the `infra` git clone itself.
- Within the VM, `/opt/selenior/control` is a mirror of the root directory of the `control` git clone.
- Within the VM, `/opt/selenior/monitor` is a mirror of the root directory of the `monitor` git clone.

### Setting up a production environment

This is tested to work on an Ubuntu 14.04 64bit system.

- In `puppet/hieradata/host`, add a file name `<fqdn of your host>.yaml`.
- In this file, declare `env: prod` and `role: all`.
- Commit and push.
- On the target system, clone the repository.
- cd `infra`
- `sudo apt-get update && sudo apt-get install puppet`
- `sudo FACTER_puppet_root=./puppet puppet apply --verbose --modulepath=./modules --hiera_config=./hiera.yaml manifests/site.pp`

This will result in the `control` and `monitor` applications being installed and set up after some minutes, will set up continuous delivery for these apps, and will serve the JourneyMonitor platform on port 80.
