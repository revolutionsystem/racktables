FROM centos:centos7
LABEL Maintainer="Daniel Leite <danielhtleite@gmail.com>"

# Variables
ENV VOL=/var/www/html

# Nginx Repository
COPY config/nginx.repo /etc/yum.repos.d/

COPY package/ /tmp/

# Install package base
RUN yum install -y --setopt=tsflags=nodocs yum-utils /tmp/remi-release-7.rpm && \
    yum-config-manager --enable remi-php73

# Install packages
RUN yum install -y --setopt=tsflags=nodocs \
    git nginx supervisor curl \
    php-phar php-json php-iconv php-mysql php-gd php-mbstring php-bcmath php-curl php-snmp php-ldap php-pcntl php-fpm

RUN yum remove -y openssh* && yum clean all && rm -rf /tmp/*

#RUN apk add --no-cache ca-certificates git nginx supervisor curl \
#    php7 php7-phar php7-json php7-iconv php7-openssl php7-pdo_mysql php7-mysqlnd php7-mysqli php7-gd php7-mbstring php7-bcmath php7-curl php7-snmp php7-ldap php7-pcntl php7-fpm

# Configure nginx
#COPY config/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
#RUN rm -rf /etc/nginx/conf.d

# Configure PHP-FPM
#COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
#COPY config/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
#COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
#RUN chown -R nginx.nginx /run && \
#  chown -R nginx.nginx /var/lib/nginx && \
#  chown -R nginx.nginx /var/tmp && \
#  chown -R nginx.nginx /var/log

# Add Racktables Application
#COPY config/entrypoint.sh /

# Config exec install permission
#RUN chmod +x /entrypoint.sh

# Make the document root a volume
#VOLUME ${VOL}

# Diretory default
#WORKDIR ${VOL}

# Expose the port nginx is reachable on
#EXPOSE 80

# Install Racktables Applications
#ENTRYPOINT ["/entrypoint.sh"]

# Let supervisord start nginx & php-fpm
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]