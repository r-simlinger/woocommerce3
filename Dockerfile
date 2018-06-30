FROM sdafj123/php-fpm-7.1

# Define environment variables
ENV SHOP_VERSION 3.4.2
ENV WP_VERSION 4.9.6
ENV VIRTUAL_HOST woocommerce3.runtest.de
ENV LETSENCRYPT_HOST woocommerce3.runtest.de
ENV LETSENCRYPT_EMAIL foo@simlinger.eu

# Install system apps
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get -qq -y install default-mysql-server default-mysql-client unzip

# Fix permissions
WORKDIR /www

# Install the shop
COPY www.conf /etc/nginx/conf.d/www.conf
COPY install_shop.sh /root/install_shop.sh
RUN chmod +x /root/install_shop.sh
RUN /root/install_shop.sh $VIRTUAL_HOST $WP_VERSION $SHOP_VERSION

ADD start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh

EXPOSE 3306
