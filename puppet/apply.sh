#!/bin/bash

sudo FACTER_puppet_root=./ puppet apply --verbose --modulepath=./modules --hiera_config=./hiera.yaml manifests/site.pp
