# Artillery Sidewinder - SWX1

Makerbase RAMPS [Gen_L V2.1](https://github.com/makerbase-mks/MKS-GEN_L) board

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

The RAMPS side of things.

![RAMPS wiring](ramps-lcd-wiring.png)

The Fysetc Mini 12864 side. Both wires are connected. One removed to see the edge of the connector.

![LCD Screen wiring](lcd-wiring.png)

The LCD is alive with a nice BLUE hue from the below config!

![LCD is alive](lcd-is-alive.png)

```python
[board_pins]
aliases:
    # Common EXP1 header found on many "all-in-one" ramps clones
    EXP1_1=ar37, EXP1_3=ar17, EXP1_5=ar23, EXP1_7=ar27, EXP1_9=<GND>,
    EXP1_2=ar35, EXP1_4=ar16, EXP1_6=ar25, EXP1_8=ar29, EXP1_10=<5V>,
    # EXP2 header
    EXP2_1=ar50, EXP2_3=ar31, EXP2_5=ar33, EXP2_7=ar49, EXP2_9=<GND>,
    EXP2_2=ar52, EXP2_4=ar53, EXP2_6=ar51, EXP2_8=<RST>, EXP2_10=ar41

######################################################################
# Fysetc Mini 12864Panel v2.1 (with neopixel backlight leds)
######################################################################

[display]
lcd_type: uc1701
cs_pin: EXP1_3
a0_pin: EXP1_4
rst_pin: EXP1_5
contrast: 63
encoder_pins: ^EXP2_5, ^EXP2_3
click_pin: ^!EXP1_2

[output_pin beeper]
pin: EXP1_1

[neopixel fysetc_mini12864]
pin: EXP1_6
chain_count: 3
color_order: RGB
initial_RED: 0.4
initial_GREEN: 0.4
initial_BLUE: 0.4
```