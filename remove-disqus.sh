#!/usr/bin/env bash
. paths.sh

if [ ! -e $POST_TPL.bac ]; then
    echo "Disqus not enabled!"
    exit 1
fi

mv $POST_TPL.bac $POST_TPL
mv $DEFAULT_TPL.bac $DEFAULT_TPL
mv $INDEX_TPL.bac $INDEX_TPL



