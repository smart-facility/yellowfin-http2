# Overview
[http/2](https://en.wikipedia.org/wiki/HTTP/2) is the latest version of the [Hypertext Transfer Protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol), based on the [spdy](https://en.wikipedia.org/wiki/SPDY) work by Google.

It is possible to take advantage of this for serving [YellowFin](http://http://www.yellowfinbi.com) content using a reverse proxy that supports http/2 such as [nginx](http://nginx.org) or [Apache httpd](http://httpd.apache.org). Here I demonstrate how to use nginx, which I prefer as it is:
* Easier to configure,
* More lightweight, and
* Optimized for reverse proxying and caching.

The following sections outline (in order) the steps to get it working

# Setup
## YellowFin tomcat setup
The file [server.xml](server.xml) needs to be modified with your hostname and then copied into `/path/to/yellowfin/appserver/conf` (if you use the supplied embedded tomcat server) or to your tomcat configuration directory if you're using a separate tomcat install (on [Ubuntu](http://www.ubuntu.com) this is in `/etc/tomcat7`).
Then you will need to restart YellowFin (or the separate tomcat install).

## nginx installation
You need a recent nginx version. I recommend the latest stable version as per the [download page](http://nginx.org/en/download.html). Notably, Ubuntu doesn't yet (at least in the 14.x releases) ship with a version of nginx that has http/2 enabled, and the version is a bit dated. I have supplied a bash script, [install.sh](install.sh) that you can run using the command `sudo bash install.sh` on an Ubuntu system to install the latest version of nginx.

## nginx configuration
The [nginx_sites.conf](nginx_sites.conf) file needs to be modified to set the hostname (this should be the same as in [server.xml](server.xml)) and if you don't want to use [OCSP stapling](https://raymii.org/s/tutorials/OCSP_Stapling_on_nginx.html) because you are concerned about CPU load (though unless you have a very large number of users, not worth worrying about), or because you are using a self-signed SSL certificate, then you will want to disable that section by commenting it out or deleting it. That file then needs to be placed in the directory of .conf files imported by the main nginx config. In the nginx-supplied version of nginx for Ubuntu this is directory in `/etc/nginx/conf.d`, otherwise you will need to check the main config file for the include line in the http section, example:

```Nginx
http {
  # ...

  include /etc/nginx/conf.d/*.conf;
}
```
