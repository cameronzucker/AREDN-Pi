#!/bin/bash
echo "AREDN Pi 5 Setup Script"

# Pull and install package updates before starting
echo "Updating system..."
apt-get update >/dev/null 2>&1
echo "Upgrading packages..."
apt-get upgrade -y >/dev/null 2>&1
echo "Pulling OS updates..."
apt update >/dev/null 2>&1
echo "Upgrading OS..."
apt upgrade -y >/dev/null 2>&1

# Install necessary background packages/dependencies
echo "Installing required packages..."
apt-get -y install npm git gpsd gpsd-clients chrony >/dev/null 2>&1

# Disable USB port power limits
#echo "Configuring USB port power limits..."
#sudo nano /boot/firmware/config.txt
#need to add "usb_max_current_enable=1" under [all]

# Install RealVNC components
echo "Installing RealVNC..."
apt-get -y install realvnc-vnc-server realvnc-vnc-viewer >/dev/null 2>&1

# Install chirp
echo "Installing CHIRP..."
apt-get -y install chirp >/dev/null 2>&1

# Install librewolf
echo "Installing Librewolf browser..."
apt-get -y install librewolf >/dev/null 2>&1

# Install patwinlink (additional config needed later)
echo "Installing PAT Winlink..."
cd ~
apt-get install -y wget libhamlib-utils screen >/dev/null 2>&1
echo "Pulling PAT .deb package from source..."
wget https://github.com/la5nta/pat/releases/download/v0.16.0/pat_0.16.0_linux_arm64.deb >/dev/null 2>&1
echo "Running dpkg..."
dpkg -i pat_0.16.0_linux_arm64.deb >/dev/null 2>&1

# Install docker per official docs: https://docs.docker.com/engine/install/ubuntu/
echo "Removing old/conflicting Docker packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done >/dev/null 2>&1

# Add Docker's official GPG key:
echo "Adding Docker's official GPG key..."
apt-get install ca-certificates curl >/dev/null 2>&1
install -m 0755 -d /etc/apt/keyrings >/dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc >/dev/null 2>&1
chmod a+r /etc/apt/keyrings/docker.asc >/dev/null 2>&1

# Add the repository to Apt sources:
echo "Add the Docker repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
sudo apt-get update >/dev/null 2>&1

# Install docker components
echo "Install Docker components..."
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1

# Change to /srv/ for Docker container installs
cd /
cd srv

# Make Docker container folders
echo "Creating service directories under /srv..."
mkdir filebrowser mirotalk openspeedtest openwebrx+ statping

# Edit config.txt file to enable PCIe 3.0, then reboots to affect change
#Add somehow...dtparam=pciex1_gen=3
#sudo shutdown -r now