#!/usr/bin/env bash
# Updates the domain in ghost and nginx
. common.sh

NEW_DOMAIN="$1"

if [ -z "$NEW_DOMAIN" ]; then
    echo "Usage: ${0} NEW_DOMAIN"
    return 1
fi

# Slice out the production domain from ghost config
OLD_URL=$(grep 'url.*http' /srv/www/ghost/config.js | cut -d \' -f 2 | head -n 2 | tail -n 1)
OLD_DOMAIN=$(echo $OLD_URL | cut -d / -f 3)

sed -i "s|$OLD_DOMAIN|$NEW_DOMAIN|" $GHOST_CONFIG
sed -i "s|server_name.*|server_name $NEW_DOMAIN;|" $NGINX_CONFIG

service ghost restart
service nginx restart
