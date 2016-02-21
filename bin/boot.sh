#!/usr/bin/env bash

ruby $build_dir/config/htpasswd.rb
erb $build_dir/config/nginx.conf.erb > $build_dir/config/nginx.conf

mkdir -p $build_dir/logs/nginx
touch $build_dir/logs/nginx/access.log $build_dir/logs/nginx/error.log

(tail -f -n 0 $build_dir/logs/nginx/*.log &)

exec $build_dir/vendor/nginx/sbin/nginx -p $build_dir -c $build_dir/config/nginx.conf
