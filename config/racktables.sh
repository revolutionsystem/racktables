#!/bin/sh

echo "Initial setup..."

# Verify install Racktables
if [ ! -f /var/www/html/inc/secret.php ] ; then
        id
        ls -ltr /var/www/
        cd /tmp/
        git clone https://github.com/RackTables/racktables.git                
        mv racktables/wwwroot/* /var/www/html/
        touch /var/www/html/inc/secret.php
        chown -R nginx.nginx /var/www/html
else
        echo "Racktables is ready."        
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf