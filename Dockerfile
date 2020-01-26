FROM debian:buster
LABEL Maintainer="Daniel Leite <danielhtleite@gmail.com>"

# Variables
ENV VOL=/var/www/html

# Install packages
RUN apt update && apt install -y --no-install-recommends \
    apt-transport-https git nginx supervisor curl \
    php7.3-phar php7.3-json php7.3-iconv php7.3-mysql php7.3-gd php7.3-mbstring php7.3-bcmath php7.3-curl php7.3-snmp php7.3-ldap php7.3-cli php7.3-fpm

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm -rf /etc/nginx/conf.d

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php/7.3/fpm/php-fpm.conf
COPY config/php.ini /etc/php/7.3/cli/php.ini
COPY config/php.ini /etc/php/7.3/fpm/php.ini

# Configure supervisord
COPY config/supervisor.conf /etc/supervisor/supervisor.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN mkdir /run/php && chown -R www-data.www-data /run && \
  chown -R www-data.www-data /var/tmp && \
  chown -R www-data.www-data /var/log

# Add Racktables Application
COPY config/entrypoint.sh /

# Config exec install permission
RUN chmod +x /entrypoint.sh

# Make the document root a volume
VOLUME ${VOL}

# Diretory default
WORKDIR ${VOL}

# Expose the port nginx is reachable on
EXPOSE 80

# Install Racktables Applications
ENTRYPOINT ["/entrypoint.sh"]

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisor.conf"]