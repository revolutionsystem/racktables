# Verify install Racktables

echo "Initial setup..."
cd /tmp
git clone https://github.com/RackTables/racktables.git
mv /tmp/racktables/wwwroot/* ${VOL}/

if [ -f ${VOL}/inc/secret.php ] ;
then
        echo "Racktables is ready."
else
        touch ${VOL}/inc/secret.php
        chown -R apache.apache ${VOL}
        chmod -R 755 ${VOL}
        rm -rf /tmp/*
fi
