# JourneyMonitor

## About this repository

This repository is responsible for managing setups where JourneyMonitor applications can be run.

[![Build Status](https://travis-ci.org/journeymonitor/infra.png?branch=master)](https://travis-ci.org/journeymonitor/infra)


## About the JourneyMonitor project

Please see [ABOUT.md](ABOUT.md) for more information.


## Setup instructions

### Setting up a development environment

- Install VirtualBox
- Install Vagrant
- Install Git
- `git clone git@github.com:journeymonitor/control.git`
- `git clone git@github.com:journeymonitor/monitor.git`
- `git clone git@github.com:journeymonitor/infra.git`
- `cd infra`
- `vagrant up`

This gives you a virtual machine at IP `192.168.59.99`. Right now, the inital setup takes
quite some time because Node.js is compiled from sources.

The following applies to this machine:

- If there is a change to the master branch of this repository, the changes are applied
  to the machine via puppet - that is, the VM automatically stays up to date. Within the
  VM, the file `/etc/cron.d/journeymonitor-infra` is responsible for this.
- Within the VM, `/vagrant` is a mirror of the root directory of the `infra` git clone itself.
- Within the VM, `/opt/journeymonitor/control` is a mirror of the root directory of the `control` git clone.
- Within the VM, `/opt/journeymonitor/monitor` is a mirror of the root directory of the `monitor` git clone.


### Setting up a production environment

This has been tested to work on an Ubuntu 14.04 64bit system.

- In `puppet/hieradata/host`, add a file named `<fqdn of your host>.yaml`.
- In this file, declare `env: prod` and `role: all`.
- Commit and push.
- On the target system, run `sudo apt-get update && sudo apt-get install puppet`.
- Then, clone this repository: `git clone git@github.com:journeymonitor/infra.git`.
- `cd infra/puppet`
- Run `./apply.sh`.

This will result in the `control` and `monitor` applications being installed and set up after some minutes, will set up
continuous delivery for these apps, and will serve the JourneyMonitor platform on port 80.


### Setting up Continuous Delivery with TravisCI and SimpleCD

The following describes how we realize Continuous Delivery from all JourneyMonitor repositories to our production
systems at http://journeymonitor.com.

- At https://github.com/settings/connections/174611, enable TravisCI access for the organization that holds the
  repositories
- At https://travis-ci.org/profile, hit the *Sync* button, and wait for your GitHub organization to become available
- Switch to the *journeymonitor* organization and switch on all repositories
- At https://github.com/settings/tokens, generate a new token with *public_repo* and *repo_deployment* rights
- Copy the newly generated token to the clipboard
- Install the *travis* gem via `sudo gem install travis`
- Go to the root folder of each repository clone (*infra*, *control*, *monitor*, and *analyze*), and run
  `travis encrypt GITHUB_TOKEN=<token-from-clipboard>`
- Add the resulting *secure* line to the `.travis.yml` file of the according repository, like so:

```yaml
env:
  global:
  - secure: "i/g95ZV29lj...M4ZocNL+yo="
```

- For each repository, set up a `.travis.yml` file that builds and tests the application for this repository
- As the `after_success` step, define `- make travisci-after-success`
- As a consequence, each successful TravisCI run will result in a new GitHub release being generated
- This results in tags that are named `travisci-build-${TRAVIS_BRANCH}-${TRAVIS_BUILD_NUMBER}`, and for each
  repository, a SimpleCD cronjob is defined (see
  https://github.com/journeymonitor/infra/blob/puppet/modules/cronjobs/templates/etc/cron.d/journeymonitor-control.erb
  for an example) that watches these tags and triggers a deployment whenever a new tag appears


## Guide to the repository

### Noteworthy Puppet modules

`puppet/modules/env-mgmt` is the place where infrastructure-wide environment variables are managed (which are, e.g., used by the applications).

Modules starting with `app-` provide the system configuration that needs to be in place for the application in question to being able to operate - however, these modules do not install the application itself (this is achieved via the SimpleCD continuous delivery setup).

`puppet/modules/cronjobs` centralizes cronjob configuration - it uses hiera data from other namespaces (e.g. `app-analyze::`) in order to configure cronjobs for different apps.
