#!/bin/bash
/etc/init.d/mysql restart
/etc/init.d/php7.1-fpm restart
/etc/init.d/nginx restart
while true; do sleep 1d; done
