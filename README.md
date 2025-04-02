# Simplifying AREDN Service Deployment through Scripting
Setup tools to automate the deployment of practical services on a Pi 5, specifically for use with the AREDN network.

Scripts are menat to be run with a Pi 5/CM5 (untested) unless otherwise expressly indicated.

## Usage Instructions

***Please note that the script is still under construction and is not ready for deployment!***

Image your Pi 5 with the official Pi imager utility: https://github.com/raspberrypi/rpi-imager<br>
Use the 64-bit Raspbian option. Configure your account username and password, SSH, and other required settings in customization before you write the image.

Boot your Pi, then SSH in.

In your home directory, run:

```
sudo git clone https://github.com/cameronzucker/aredn-pi-setup.git
cd aredn-pi-setup
sudo chmod +x setup-script.bash
sudo ./setup-script.bash
```
## Hardware

This project is based on the Pi 5 for a few important reasons:
* Built-in Real Time Clock (RTC) which doens't consume GPIO pins<br>
* PCIe 3.0 bus for fast network file server storage<br>
* Native support for booting from M.2 SSDs<br>
* Enough raw performance to plausibly act as a micro server for small numbers of concurrent users

## Parts List

Scripts are intended for the following reference hardware. They will probably work with other parts, but other combinations are untested. Bolded line items are the recommended configuration.

I have no affiliation with any linked vendors, and any particular link is not a directive to buy that part there. Copy your desired SKUs and shop around to combine orders and get the best deal.

### Base Pis
* Raspberry Pi 5 8 GB: https://www.pishop.us/product/raspberry-pi-5-8gb/<br>
* **Raspberry Pi 5 16 GB:** https://www.pishop.us/product/raspberry-pi-5-16gb/

### Combination M.2/PoE hats:
There are a few PoE hats which will work depending on the desired overall footprint. 2280 drives are recommended if form factor isn't an issue.

* Waveshare POE M.2 HAT+: https://www.waveshare.com/product/raspberry-pi/hats/poe-m.2-hat-plus.htm<br>
* 52Pi M.2 NVME M-KEY PoE+ Hat: https://52pi.com/products/m-2-nvme-m-key-poe-hat-with-official-pi-5-active-cooler-for-raspberry-pi-5-support-m-2-nvme-ssd-2230-2242<br>
* **52Pi P33 M.2 NVMe 2280 PoE+ HAT:** https://52pi.com/products/p33-m-2-nvme-2280-poe-hat-extension-board-for-raspberry-pi-5

### Storage
This project makes use of M.2 drives for their quantum leap in speed and reliability over Micro SD cards. Since these Pis will be used as web application servers, including a file serve function which incurs frequent writes, this is an important factor and worth the relatively minor price increase. 2230/2242 drives are more expensive than larger 2280 drives and have worse sustained performance due to lacking DRAM cache, but they'll fit in smaller cases. The only thing precluding the use of truly robust enterprise SATA SSDs like the Intel P4610 is lack of boot support.

* For 2230/2242 - Samsung PM991a¹: https://www.amazon.com/dp/B0BDWCC47L<br>
* 2230/2242 alternate - Official Raspberry Pi NVMe SSD: https://www.pishop.us/product/raspberry-pi-nvme-ssd-512gb/<br>
* **For 2280 - Crucial P3 Plus 500GB:** https://www.amazon.com/dp/B0B25NTRGD

¹The PM991a is a high quality SSD which probably outperforms the official Pi 2230 SSD, but since the Pi 5 only offers PCIe 3.0 x1, the real world beneift of the better part may be negligible.

### RTC Battery Backup
If the Pi is shutdown or loses power, especially for extended periods, keeping the RTC running and accurate is valuable for expediting redeployment without relying on a GPS fix. While the Pi 5 has a built-in RTC chip, it needs an external battery connected to a dedicated header to supply power.

* Panasonic ML-2020 lithium manganese dioxide rechargeable battery: https://www.pishop.us/product/rtc-battery-for-raspberry-pi-5/<br>
* **RTCBattery Box Real Time Clock Holder for Pi 5²:** https://www.amazon.com/dp/B0CRKQ2MG1

²This option requires you to furnish a common CR2032 battery. This may be preferable due to their abundance if something should happen to the RTC battery. They are also higher capacity than rechargeable options, allowing for extended shutdown standby time (potentially years).

### Coolers
These Pis are intended for remote deployment in hot Southwest desert conditions and require active cooling. The following are known to work well:

* **Official Raspberry Pi 5 Active Cooler:** https://www.amazon.com/dp/B0CZLPX2HC<br>
* GeeekPi Active Cooler for Raspberry Pi 5: https://www.amazon.com/dp/B0CNVFCWQR

### Cases
There is some room for creativity here depending on whether additional hats on top of the M.2/PoE hat are desired. The choice will come down to personal preference.

* 52Pi makes a first party ABS case which fits their hat with some room to spare: https://52pi.com/collections/cases/products/case-for-raspberry-pi-5?variant=43067599749272<br>

However, a metal case offers protection against RFI, which may be desirable in a radio-oriented environment. Geekworm makes some which fit their NVMe hats, which have the same footprint as full length M.2/PoE hats:

* Geekworm P579: https://geekworm.com/products/p579

### Supporting Hardware
The script setup workflow involves creating the base Raspbian OS x64 image using the Pi imager utility. To do this efficiently, it should be imaged directly to an M.2 drive over a USB 3.0 or faster connection using an enclosure or adapter.

This is what I've used:<br>
* Sabrent USB 3.2 Type-C Tool-Free Enclosure for M.2 PCIe NVMe: https://www.amazon.com/dp/B08RVC6F9Y

But, any similar device will work.

## WIP - Onboard GPS
Including GPS directly on the board frees up a USB port and provides access to much more precise PPS timing. I haven't had a chance to test this on top of the M.2/PoE boards, so it's not included in the script yet.

* Waveshare LC29H Series Dual-band GPS Module for Raspberry Pi³: https://www.waveshare.com/lc29h-gps-hat.htm?sku=25278

³Requires an ML1220 rechargeable cell which is not included.

## Future Hardware
The ideal Pi hat would combine a UPS, PCIe 3.0 NVMe adapter, full 40 pin GPIO passthrough, and 24V *passive* PoE support (most AREDN hardware runs on 24V PoE). I recently found such a part from Pi Modules Technologies in Greece, and will create a branch for it if the hardware does what it says on the tin.

* M.2 – UPS and Power Management HAT Advanced/PPoE: https://pimodules.com/product/m-2-ups-and-power-management-hat-advanced-ppoe
