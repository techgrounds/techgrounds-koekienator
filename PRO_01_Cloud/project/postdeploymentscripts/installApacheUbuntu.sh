#!/bin/bash

# Update package list
sudo apt update

# Install Apache
sudo apt install apache2 -y

# Start Apache service
sudo systemctl start apache2

# Enable Apache to start on boot
sudo systemctl enable apache2

# Display status
sudo systemctl status apache2