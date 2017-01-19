#!/usr/bin/env bash

set -e

usermod -u 1000 www-data

cd /opt/journeymonitor/control/php
chown -R www-data:www-data var/cache/ var/logs
sudo -u www-data make php-dependencies
make js-dependencies
sudo -u www-data php bin/console assets:install --symlink
sudo -u www-data php bin/console doctrine:migrations:migrate --no-interaction

/etc/init.d/rsyslog start
/usr/sbin/cron
/etc/init.d/php7.1-fpm start
/etc/init.d/nginx start

echo "All done."
tail -f /dev/null # keep running
