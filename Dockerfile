FROM nginx:latest
LABEL Maintainer="Daniel Leite <danielhtleite@gmail.com>"

# Variables
ENV VOL=/var/www/html

# Install packages
RUN yum install -y --setopt=tsflags=nodocs \
    git nginx supervisor curl \
    php-phar php-json php-iconv php-mysql php-gd php-mbstring php-bcmath php-curl php-snmp php-ldap php-pcntl php-fpm

RUN yum remove -y openssh* && yum clean all && rm -rf /tmp/*

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm -rf /etc/nginx/conf.d

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php/php-fpm.d/www.conf
#COPY config/php.ini /etc/php/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
#RUN chown -R nginx.nginx /run && \
#  chown -R nginx.nginx /var/lib/nginx && \
#  chown -R nginx.nginx /var/tmp && \
#  chown -R nginx.nginx /var/log

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
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]