# udev rule for klipper

When the printer is switch off and thenon again - the firmware config may not load due to the connection being lost by the klipper service. This hack ensures that the `printer.cfg` is loaded when the USB reattaches to the pi or linux device.

## Create a udev rule to auto-start the firmware

Use `lsusb` to determine the _vendor_ and _product_ ids required to make this work.


cat /etc/udev/rules.d/98-klipper.rules


```code
## rule to restart klipper when the printer is connected via usb
SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="614e", ACTION=="add", RUN+="/usr/bin/sudo -u pi /bin/sh -c '/bin/echo RESTART > /tmp/printer'"
```
