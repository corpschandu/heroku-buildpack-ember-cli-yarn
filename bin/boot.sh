#!/usr/bin/env bash

ruby $HOME/config/htpasswd.rb
erb $HOME/config/nginx.conf.erb > $HOME/config/nginx.conf

mkdir -p $HOME/logs/nginx
touch $HOME/logs/nginx/access.log $HOME/logs/nginx/error.log

(tail -f -n 0 $HOME/logs/nginx/*.log &)

echo "load nginx conf"
exec $HOME/vendor/nginx/sbin/nginx -p $HOME -c $HOME/config/nginx.conf

cat $HOME/logs/nginx/error.log
