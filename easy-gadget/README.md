## Easy Gadget Script

This script is a small and easy tool for making your raspberry pi appear as a USB RNDIS device in your windows/linux/mac system so you can connect to it without internet. The insturctions are very simple and modifies the least amount of files in your raspberry pi.

### Enable the `dwc2` module

For the gadget to work you need to add `dtoverlay=dwc2` in your `/boot/firmware/config.txt` and you also need to add `modules_load=dwc2` in `/boot/firmware/config.txt`. Make sure to reboot after editing these files.

### Run the script

Now if you have a display like me you can just connect the pi to your laptop run the easy gadget script with this command:

```bash
chmod +x easy-gadget.sh
sudo ./easy-gadget.sh
```

And you are ready to go! The pi will appear as a RNDIS device.

### Running the script on boot

If you don't have a screen and you want your pi to be an ethernet gadget every time it boots up you can use crontab. To configure crontab use these command:

```bash
sudo crontab -e
```

Your prefered editor will pop up and you need to add in the end of this file:

```bash
@reboot /bin/bash /some/location/easy-gadget.sh
```

After that save and exit and now the pi will configure the gadget automatically every time it boots up.
