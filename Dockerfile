FROM alpine:3.14
LABEL Author="Raja Subramanian" Description="A comprehensive docker image to run Apache-2.4 PHP-8.0 applications like Wordpress, Laravel, etc"

# Install apache and php8
RUN apk add --no-cache \
        php8 \
        php8-apache2 \
        php8-ctype \
        php8-curl \
        php8-fileinfo \
        php8-mbstring \
        php8-gd \
        php8-ldap \
        php8-mysqlnd \
        php8-pgsql \
        php8-session \
        php8-tidy \
        php8-intl \
        php8-pecl-uploadprogress \
        php8-zip \
        libcap && \
# Ensure apache can bind to 80 as non-root
        setcap 'cap_net_bind_service=+ep' /usr/sbin/httpd && \
        apk del libcap && \
# Create required directories and set permissions
        mkdir /var/www/html && \
        chown apache /run/apache2 /var/log/apache2

# Expose details about this docker image
COPY src/index.php /var/www/html
COPY src/default.conf /etc/apache2/conf.d

EXPOSE 80
USER apache

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
