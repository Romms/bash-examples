#!/bin/bash

ROOT_UID=0
if [ $UID != $ROOT_UID ]; then
    echo "You don't have sufficient privileges to run this script."
    exit 1
fi

# Set the path to your localhost
www=/var/www
echo "Enter new domain"
read sn

# Create the file with VirtualHost configuration in /etc/apache2/site-available/
echo "<VirtualHost *:80>
        DocumentRoot $www/$sn/
        ServerName $sn
        <Directory $www/$sn/>
                Options +Indexes +FollowSymLinks +MultiViews +Includes
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/$sn.conf

# Create new directory
mkdir -p "$www/$sn"

# Add the host to the hosts file
echo 127.0.0.1 $sn >> 	

# Enable the site
a2ensite $sn

# Reload Apache2
/etc/init.d/apache2 reload

echo "Your new site is available at http://$sn"
