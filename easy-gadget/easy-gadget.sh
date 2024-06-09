#!/bin/bash

echo "Welcome to easy-gadget.sh!"

if [ `id -u` -ne 0 ] then 
  echo "You must run me as root or with sudo!"
  exit
fi

echo "Please make sure you have added 'dtoverlay=dwc2' in /boot/firmware/config.txt and 'modules-load=dwc2' in the end of '/boot/firmwate/cmdline.txt'. You can cancel with Ctrl+C waiting 5 seconds..."

sleep 5s

echo "Enabling libcomposite..."
modprobe libcomposite

echo "Creating gadget directory..."
cd /sys/kernel/config/usb_gadget/
mkdir -p gadget/
cd gadget/

echo "Setting device id..."
echo 0x1d6b > idVendor
echo 0x0104 > idProduct
echo 0x0100 > bcdDevice
echo 0x0200 > bcdUSB

echo "Setting the device identifiers..."
mkdir -p strings/0x409
echo "64abd81f984219523" > strings/0x409/serialnumber
echo "Stavros" > strings/0x409/manufacturer
echo "Raspberry Pi 5" > strings/0x409/product

echo "Creating RNDIS config..."
mkdir -p configs/c.1/strings/0x409
echo "Config 1: RNDIS Device" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

echo "Configuring RNDIS..."
mkdir -p functions/rndis.usb0

echo "12:22:33:44:55:66" > functions/rndis.usb0/dev_addr
echo "16:22:33:44:55:66" > functions/rndis.usb0/host_addr

echo "Enabling it..."
ln -s functions/rndis.usb0 configs/c.1
ls /sys/class/udc > UDC

echo "Enabling the usb0 interface and creating network manager connection..."
ifconfig usb0 up
nmcli con add type ethernet con-name usb-gadget con.interface-name usb0
nmcli con up usb-gadget

echo "All done! Have a nice day!"
