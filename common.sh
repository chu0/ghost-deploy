GHOST_HOME=/srv/www/ghost
GHOST_CONFIG="$GHOST_HOME/config.js"
NGINX_CONFIG=/etc/nginx/sites-available/ghost
GHOST_THEME=casper
GHOST_THEME_PATH=$GHOST_HOME/content/themes/$GHOST_THEME
DISQUS_SHORTNAME=
POST_TPL=$GHOST_THEME_PATH/post.hbs
DEFAULT_TPL=$GHOST_THEME_PATH/default.hbs
INDEX_TPL=$GHOST_THEME_PATH/index.hbs

check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "You must run the script as the 'root' user."
        exit 1
    fi
}

error() {
    local msg="${1}"
    echo "${msg}"
    exit 1
}

check_root
