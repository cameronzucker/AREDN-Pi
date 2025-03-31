# Simplifying AREDN Service Deployment through Scripting
Setup tools to automate the deployment of practical services on a Pi 5, specifically for use with the AREDN network.

Scripts are menat to be run with a Pi 5/CM5 (untested) unless otherwise expressly indicated.

**Usage Instructions:**<br>
Image your Pi 5 with the official Pi imager utility: https://github.com/raspberrypi/rpi-imager
Use the 64-bit Raspbian option. Configure your account username and password, SSH, and other required settings in customization before you write the image.

Boot your Pi, then SSH in.

In your home directory, run:
<br>
```
sudo git clone https://github.com/cameronzucker/aredn-pi-setup.git
cd aredn-pi-setup
sudo chmod +x setup-script.bash
sudo ./setup-script.bash
```
