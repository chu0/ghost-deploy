#!/usr/bin/env sh
HERE=$(dirname $(readlink -f $0))

apt-get install nginx nodejs nodejs-legacy npm curl unzip

# # add ghost user / group
useradd -r ghost -U

# # install ghost
mkdir -p /srv/www
curl -L https://ghost.org/zip/ghost-latest.zip -o /tmp/ghost.zip
unzip -uo /tmp/ghost.zip -d /srv/www/ghost
cd /srv/www/ghost ; npm install --production

rsync -av $HERE/conf/ /
chown -R ghost:ghost /var/run/ghost /srv/www/ghost

# remove nginx default site
rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default

# start ghost service on startup
update-rc.d ghost defaults
update-rc.d ghost enable

service ghost start
service nginx restart
