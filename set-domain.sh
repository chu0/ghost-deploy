#!/usr/bin/env bash
# Updates the domain in ghost and nginx
. common.sh

[ $DOMAIN ] || DOMAIN="$1"

if [ -z "$DOMAIN" ]; then
    echo "Usage: ${0} DOMAIN"
    exit 1
fi

# Slice out the production domain from ghost config
OLD_URL=$(grep 'url.*http' /srv/www/ghost/config.js | cut -d \' -f 2 | head -n 2 | tail -n 1)
OLD_DOMAIN=$(echo $OLD_URL | cut -d / -f 3)

sed -i "s|$OLD_DOMAIN|$DOMAIN|g" $GHOST_CONFIG
sed -i "s|server_name.*|server_name $DOMAIN;|g" $NGINX_CONFIG

echo "DOMAIN=${DOMAIN}" > data/MAIL

service ghost restart
service nginx restart
