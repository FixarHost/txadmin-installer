#!/bin/sh

# Script for automatic installation of a TXAdmin server with a database

# 1. Update the system and install necessary dependencies
echo "Updating the system and installing dependencies..."
apt update && apt upgrade -y
apt install -y wget git screen unzip mariadb-server apache2 libapache2-mod-fcgid php-fpm php-mysqli php-json php-cli php-mbstring

a2enmod proxy_fcgi setenvif
a2enconf php8.1-fpm
systemctl restart apache2

# 2. Configure MariaDB (MySQL)
echo "Configuring MariaDB..."
systemctl start mariadb
systemctl enable mariadb
mysql_secure_installation <<EOF
n
y
y
y
y
EOF

# 3. Create a database user with all privileges
read -p "Enter a username for the database: " DB_USER
echo "Enter a password for the user $DB_USER: "
read -r DB_PASS

mysql -u root -e "DROP USER IF EXISTS '$DB_USER'@'localhost'; CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS'; GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# 4. Download the link for TXAdmin artifacts
read -p "Enter the link for TXAdmin artifacts: " TXADMIN_LINK

# 5. Create a directory for FiveM files
mkdir -p /root/fivem
cd /root/fivem
wget $TXADMIN_LINK -O fx.tar.xz

tar xf fx.tar.xz
rm fx.tar.xz

# 6. Configure TXAdmin
read -p "Enter a port for TXAdmin (default 40120): " TXADMIN_PORT
TXADMIN_PORT=${TXADMIN_PORT:-40120}

mkdir -p /root/fivem/server-data

# 7. Install and configure PHP and phpMyAdmin
echo "Installing and configuring phpMyAdmin..."
mkdir -p /var/www/html/phpmyadmin
cd /var/www/html/phpmyadmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz -O phpmyadmin.tar.gz
tar xf phpmyadmin.tar.gz --strip-components=1
rm phpmyadmin.tar.gz

# Set permissions for Apache
chown -R www-data:www-data /var/www/html/phpmyadmin
chmod -R 755 /var/www/html/phpmyadmin

# Restart Apache
echo "Restarting Apache..."
systemctl restart apache2

# 8. Create the startup script
echo "Creating startup script..."
cat > /root/fivem/start.sh <<EOF
#!/bin/bash
/root/fivem/run.sh +set txAdminPort $TXADMIN_PORT
EOF
chmod +x /root/fivem/start.sh

# 9. Start the server in a screen session and output the PIN
echo "Starting the server..."
screen -dmS fivem bash -c "/root/fivem/run.sh +set txAdminPort $TXADMIN_PORT | tee /root/fivem/txadmin_output.log"
sleep 5
echo "Fetching TXAdmin PIN..."
TXADMIN_PIN=$(grep -oP 'Admin PIN: \K\d{4}' /root/fivem/txadmin_output.log)
if [ -n "$TXADMIN_PIN" ]; then
    echo "TXAdmin is running. Your Admin PIN is: $TXADMIN_PIN"
else
    echo "Failed to retrieve TXAdmin PIN. Check /root/fivem/txadmin_output.log for details."
fi

# 10. Display information about the completed installation
echo "The installation of the TXAdmin server and phpMyAdmin with a database is complete!"
echo "Access phpMyAdmin at: http://<Your-IP>/phpmyadmin"
echo "Access txAdmin at: http://<Your-IP>:PORT"
