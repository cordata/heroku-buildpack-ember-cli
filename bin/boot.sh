#!/usr/bin/env bash

BASE_DIR=$1

ruby $BASE_DIR/config/htpasswd.rb
erb $BASE_DIR/config/nginx.conf.erb > $BASE_DIR/config/nginx.conf

mkdir -p $BASE_DIR/logs/nginx
touch $BASE_DIR/logs/nginx/access.log $BASE_DIR/logs/nginx/error.log

(tail -f -n 0 $BASE_DIR/logs/nginx/*.log &)

exec $BASE_DIR/vendor/nginx/sbin/nginx -p $BASE_DIR -c config/nginx.conf
