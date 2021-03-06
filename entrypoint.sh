#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

if [ ! -d /data/htdocs ] ; then
  mkdir -p /data/htdocs
  curl -O -sSL https://wordpress.org/latest.tar.gz
  tar -xzvf latest.tar.gz
  mv wordpress/* /data/htdocs/
  chown -R nginx:www-data /data/htdocs
fi

chown -R nginx:www-data /data/htdocs

# start php-fpm
mkdir -p /data/logs/php-fpm
php-fpm

# start nginx
mkdir -p /data/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx $@
