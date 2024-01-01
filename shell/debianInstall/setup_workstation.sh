#!/bin/bash

# Prompt for the new username
read -p "Enter the new username: " USERNAME

# Check if running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Add new user
adduser $USERNAME

# Add user to sudo group
usermod -aG sudo $USERNAME

# Make directories in the user's home folder
su - $USERNAME -c "mkdir -p ~/bin ~/logs ~/logs/update"

# Create and make executable shell scripts in user's bin directory
su - $USERNAME -c "touch ~/bin/update.sh ~/bin/startup.sh && chmod +x ~/bin/update.sh ~/bin/startup.sh"

# Update package list
apt update

# Install curl
apt install -y curl

# Install snapd
apt install -y snapd

# Install core
snap install core

# Install Git
apt install -y git

# Install Python
apt install -y python3

# Install Java
apt install -y default-jdk

# Install speedtest
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
apt-get install -y speedtest

echo "Setup completed for $USERNAME!"

