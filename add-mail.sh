#!/usr/bin/env bash
# Add mailsending via postfix
. common.sh

DOMAIN="$1"

if [ -z "$DOMAIN" ]; then
    echo "Usage: ${0} DOMAIN"
    exit 1
fi

echo "postfix postfix/main_mailer_type    select  Internet site" | debconf-set-selections
echo "postfix postfix/mailname    string  ${DOMAIN}" | debconf-set-selections

apt-get -y install postfix

# listen only on localhost
postconf -e 'inet_interfaces = 127.0.0.1, [::1]'

# Slice out mail line from from ghost config
OLD_MAIL_CONFIG=$(grep 'mail:.*{.*},' /srv/www/ghost/config.js)
NEW_MAIL_CONFIG="mail: { transport: 'sendmail', fromaddress: 'no-reply@${DOMAIN}', options: {}},"

cp $GHOST_CONFIG $GHOST_CONFIG.postfix.bac

# Replace old mail config with new one
sed -i "s|$OLD_MAIL_CONFIG|$NEW_MAIL_CONFIG|" $GHOST_CONFIG

service postfix restart
service ghost restart
