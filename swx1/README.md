# Artillery Sidewinder - SWX1

## Flashing klipper

Flash the firmware without any changes to the hardware, since I have already removed the stock TFT screen.

Use the the following to flash klipper 

```shell
cd ~/klipper
sudo systemctl stop klipper
make
make flash FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0
sudo systemctl start klipper
```

## Fysect Mini12864 LCD Screen

I have installed the v2.1 version of the screen. See the config for details.

The pin layouts and diagrams make no sense, but it works.