#!/usr/bin/env bash
. common.sh

[ $GA_ID ] || GA_ID="$1"

if [ -z $GA_ID ]; then
    echo "Usage $0 GA_ID"
    echo "Get GA_ID by registering at https://www.google.com/analytics"
    exit 1
fi

error() {
    local msg="${1}"
    echo "${msg}"
    exit 1
}

ga_script="<script>  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');  ga('create', '${GA_ID}', 'auto');  ga('send', 'pageview');</script>"

# Exit if already added
grep -q 'google-analytics' $DEFAULT_TPL && error "GA already added!"

cp $DEFAULT_TPL $DEFAULT_TPL.ga.bac

sed -i "s~</body>~${ga_script}</body>~" $DEFAULT_TPL

# Save for upgrades
echo "GA_ID=$GA_ID" > data/GA

# Make changes take effect
service ghost restart
