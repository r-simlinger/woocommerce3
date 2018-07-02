#!/bin/bash
URL="https://$1/"
WP_VERSION="$2"
SHOP_VERSION="$3"
#HOST=localhost
HOST="%"

## Init DB
/etc/init.d/mysql start

commands="CREATE DATABASE \`secu\`;CREATE USER 'secu'@'${HOST}' IDENTIFIED BY 'secu';GRANT USAGE ON *.* TO 'secu'@'${HOST}' IDENTIFIED BY 'secu';GRANT ALL privileges ON \`secu\`.*
TO 'secu'@'${HOST}';FLUSH PRIVILEGES;"

echo "${commands}" | mysql


## Install WordPress
cd /www

echo "Download WordPress v${WP_VERSION}"
#wget -q https://github.com/WordPress/WordPress/archive/${WP_VERSION}.zip
#unzip -q ${WP_VERSION}.zip -d .
#rm ${WP_VERSION}.zip

#cd /www
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
#wp --info
wp core download \
    --allow-root \
    --path=/www \
    --locale=de_DE \
    --version=${WP_VERSION} \
    --force

wp config create \
    --allow-root \
    --dbhost=localhost \
    --dbname=secu \
    --dbuser=secu \
    --dbpass="secu" \
     --locale=de_DE \
    --force

(
  echo "define('WP_DEBUG', true);"
  echo "define('WP_DEBUG_LOG', true);"
  echo "define('WP_HOME','${URL}');";
  echo "define('WP_SITEURL','${URL}');";
) >> wp-config.php

wp core install \
    --allow-root \
    --url=${URL} \
    --title="Test Wordpress" \
    --admin_user=secu \
    --admin_password=secu123 \
    --admin_email=secu@example.com \
    --skip-email

rm -rf /www/wp-config-sample.php /app/wp-admin/install*.php
  
## Setting file permissions
chown -R www-data /www
chgrp -R www-data /www
