#!/usr/bin/env bash
. common.sh

HERE=$(dirname $(readlink -f $0))

apt-get -y install nginx nodejs nodejs-legacy npm curl unzip

# # add ghost user / group
useradd -r ghost -U

# # install ghost
mkdir -p /srv/www
curl -L https://ghost.org/zip/ghost-latest.zip -o /tmp/ghost.zip
unzip -uo /tmp/ghost.zip -d $GHOST_HOME
cd $GHOST_HOME ; npm install --production

rsync -av $HERE/conf/ /
chown -R ghost:ghost /var/run/ghost $GHOST_HOME

# remove nginx default site
rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default

# start ghost service on startup
update-rc.d ghost defaults
update-rc.d ghost enable

service ghost start
service nginx restart

echo "Ghost installed"
echo "You can now further configure ghost."
echo
echo "Run under a specific domain e.g. blog.example.com:"
echo "./set-domain.sh blog.example.com"
echo
echo "Add disqus:"
echo "./add-disqus.sh DISQUS_SHORTNAME"
echo 
echo "Add mail sending via postfix:"
echo "./add-mail.sh blog.example.com"
