#!/usr/bin/env bash
. common.sh

NOW=`date +%d-%m-%Y`

./backup.sh

curl -L https://ghost.org/zip/ghost-latest.zip -o /tmp/ghost.zip

service ghost stop

mv $GHOST_HOME ${GHOST_HOME}_old_${NOW}

unzip -uo /tmp/ghost.zip -d $GHOST_HOME

./restore.sh backups/content_backup_$NOW.tgz

cd $GHOST_HOME; npm install --production; cd -
chown -R ghost:ghost $GHOST_HOME

for f in data/*; do 
    source $f; 
done

[ $GA_ID ]            && ./add-ga.sh $GA_ID
[ $DISQUS_SHORTNAME ] && ./add-disqus.sh $DISQUS_SHORTNAME $DISQUS_COMMENTS
[ $DOMAIN ]           && ./set-domain.sh $DOMAIN
[ $DOMAIN ]           && ./add-mail.sh $DOMAIN

service ghost start

echo "Moved old Ghost instance to ${GHOST_HOME}_old_${NOW}"
echo "If everything is OK go delete that"
