#!/usr/bin/env bash
. common.sh

NOW=`date +%d-%m-%Y`

mkdir -p backups
cd backups
tar cfzv content_backup_$NOW.tgz -C $GHOST_HOME content/data content/images
cd ..

echo
echo "Created backup of ghost content/data and content/images in backups/content_backup_${NOW}.tgz"
