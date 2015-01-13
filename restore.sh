#!/usr/bin/env bash
. common.sh

BACKUP="$1"

if [ -z $BACKUP ]; then
    echo "Usage $0 BACKUP"
    exit 1
fi

tar xfv $BACKUP -C $GHOST_HOME 
