#!/usr/bin/env bash
# From: https://help.disqus.com/customer/portal/articles/1454924-ghost-installation-instructions
. common.sh

[ $DISQUS_SHORTNAME ] || DISQUS_SHORTNAME="$1"
[ $DISQUS_COUNT ]     || DISQUS_COUNT="$2"

if [ -z $DISQUS_SHORTNAME ]; then
    echo "Usage $0 DISQUS_SHORTNAME [COUNT]"
    echo "Give COUNT a value to enable"
    echo "Get DISQUS_SHORTNAME by registering at https://disqus.com/admin/signup/"
    exit 1
fi

# comments
html_comments="<div id='disqus_thread'></div><script type='text/javascript'>var disqus_shortname = '$DISQUS_SHORTNAME'; var disqus_identifier = '{{post.id}}';(function() { var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true; dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js'; (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq); })();</script><noscript>Please enable JavaScript to view the <a href='http://disqus.com/?ref_noscript'>comments powered by Disqus.</a></noscript><a href='http://disqus.com' class='dsq-brlink'>comments powered by <span class='logo-disqus'>Disqus</span></a>"

# comment count
html_counts="<script type='text/javascript'>var disqus_shortname = '$DISQUS_SHORTNAME'; (function () {var s = document.createElement('script'); s.async = true;s.type = 'text/javascript';s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';(document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);}());</script>"

html_counts_index="<span class='post-meta'><time datetime='{{date format='YYYY-MM-DD'}}'>{{date format='DD MMM YYYY'}}</time> {{tags prefix='on '}} <a href='{{url}}#disqus_thread'>Comments</a></span>"

# Exit if already added
grep -q 'disqus.com' $POST_TPL && error "Disqus already added!"

cp $POST_TPL $POST_TPL.disqus.bac

if [ ! -z "$DISQUS_COUNT" ]; then
    cp $DEFAULT_TPL $DEFAULT_TPL.disqus.bac
    cp $INDEX_TPL $INDEX_TPL.disqus.bac
fi

sed -i "s~</article>~$html_comments</article>~" $GHOST_THEME_PATH/post.hbs
if [ ! -z "$DISQUS_COUNT" ]; then
    sed -i "s~</body>~$html_counts</body>~" $GHOST_THEME_PATH/default.hbs
    sed -i "s~<span class=\"post-meta\".*~$html_counts_index~" $GHOST_THEME_PATH/index.hbs
fi

# Save for upgrades
echo "DISQUS_SHORTNAME=$DISQUS_SHORTNAME" > data/DISQUS
if [ ! -z "$DISQUS_COUNT" ]; then
    echo "DISQUS_COUNT=$DISQUS_COUNT" >> data/DISQUS    
fi

service ghost restart
