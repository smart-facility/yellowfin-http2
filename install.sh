#!/usr/bin/env bash
curl http://nginx.org/keys/nginx_signing.key | apt-key add -
echo -e "deb http://nginx.org/packages/mainline/ubuntu/ `lsb_release -cs` nginx\ndeb-src http://nginx.org/packages/mainline/ubuntu/ `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list
apt-get update
apt-get install nginx
