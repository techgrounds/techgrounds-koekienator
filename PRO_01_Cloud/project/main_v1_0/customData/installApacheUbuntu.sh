#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo ufw allow 'Apache'
sudo systemctl start apache2
sudo systemctl enable apache2
sudo chown -R $USER:$USER /var/www
cd /var/www/html
echo '<!DOCTYPE html>' > index.html
echo '<html>' >> index.html
echo '<head>' >> index.html
echo '<title>WebServer van Koek</title>' >> index.html
echo '<meta charset="UTF-8">' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
echo '<h1>You got the the landing page, well done!</h1>' >> index.html
echo '<h3>This is just for testing purposes</h3>' >> index.html
echo '</body>' >> index.html
echo '</html>' >> index.html