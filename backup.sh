#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

rsync -avc --progress root@journeymonitor.com:/var/tmp/selenior*sqlite* $DIR/../backup/
