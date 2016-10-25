#!/usr/bin/env bash

set -e

# The full path to this script, no matter where it is called from
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ ! -e docker ]
then
    echo "You need to install Docker in order to boot the JourneyMonitor docker infrastructure"
    exit 1
fi

if [ ! -d ${SCRIPTDIR}/../../control ] || [ ! -d ${SCRIPTDIR}/../../monitor ]
then
    echo "This script expects checkouts of the 'control' and 'monitor' modules at the same level as this 'infra' checkout."
    exit 1
fi

if [ -z $(docker images -q journeymonitor/control:latest 2> /dev/null) ]
then
    echo "Image 'journeymonitor/control:latest' doesn't exist, creating..."
    /usr/bin/env bash ${SCRIPTDIR}/../../control/docker/build-app-container.sh
fi

if [ -z $(docker images -q journeymonitor/monitor:latest 2> /dev/null) ]
then
    echo "Image 'journeymonitor/monitor:latest' doesn't exist, creating..."
    /usr/bin/env bash ${SCRIPTDIR}/../../monitor/docker/build-app-container.sh
fi

docker network create journeymonitor 2> /dev/null || true

echo "Starting image 'journeymonitor/control:latest' as container 'journeymonitor-control'"
/usr/bin/env bash ${SCRIPTDIR}/../../control/docker/run-app-container.sh

echo "Starting image 'journeymonitor/monitor:latest' as container 'journeymonitor-monitor'"
/usr/bin/env bash ${SCRIPTDIR}/../../monitor/docker/run-app-container.sh

echo "All done."
echo "If you need a shell on one of the containers, go to the project folder (e.g. '../control') and issue 'make docker-shell'"
