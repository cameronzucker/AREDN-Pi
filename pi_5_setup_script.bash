#!/bin/bash
echo "AREDN Pi 5 Setup Script"

# Pull and install package updates before starting
echo "Installing updates..."
apt-get update
apt-get upgrade -y
apt update
apt upgrade

# Install necessary background packages/dependencies
#echo "Installing required packages..."
#sudo bash -c 'apt-get -y install npm git gpsd gpsd-clients chrony >/dev/null 2>&1 & disown'

# Disable USB port power limits
#echo "Configuring USB port power limits..."
#sudo nano /boot/firmware/config.txt
#need to add "usb_max_current_enable=1" under [all]

# Install RealVNC components
#echo "Installing RealVNC..."
#sudo bash -c 'apt-get -y install realvnc-vnc-server realvnc-vnc-viewer >/dev/null 2>&1 & disown'

# Install chirp
#echo "Installing CHIRP..."
#sudo bash -c 'apt-get -y install chirp >/dev/null 2>&1 & disown'

# Install librewolf
#echo "Installing Librewolf browser..."
#sudo bash -c 'apt-get -y install librewolf >/dev/null 2>&1 & disown'

# Install patwinlink (additional config needed later)
#echo "Installing PAT Winlink..."
#cd ~
#sudo apt install wget libhamlib-utils screen
#sudo wget https://github.com/la5nta/pat/releases/download/v0.16.0/pat_0.16.0_linux_arm64.deb
#sudo dpkg -i pat_0.16.0_linux_arm64.deb

# Install docker per official docs: https://docs.docker.com/engine/install/ubuntu/
#echo "Removing old/conflicting Docker packages..."
#sudo bash -c 'for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done'

# Add Docker's official GPG key:
#sudo apt-get install ca-certificates curl
#sudo install -m 0755 -d /etc/apt/keyrings
#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
#sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
#echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get update

# Install docker components
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Change to /srv/ for Docker container installs
#cd /
#cd srv

# Make Docker container folders
#sudo mkdir filebrowser mirotalk openspeedtest openwebrx+ statping

# Edit config.txt file to enable PCIe 3.0, then reboots to affect change
#Add somehow...dtparam=pciex1_gen=3
#sudo shutdown -r now