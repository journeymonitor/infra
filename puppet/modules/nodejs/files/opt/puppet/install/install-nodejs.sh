#!/bin/bash

# managed by puppet

cd /opt/puppet/install
tar xvfz node-v0.12.2.tar.gz
cd node-v0.12.2
./configure && make && make install
