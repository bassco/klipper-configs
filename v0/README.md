# v0.1006

## The specs:

Voron v0.1 v0.1006 from chsh:
- LDO Frame
- ZODIAC x Phaetus BMO Hotend
- SKR Mini E3 V2.0 Board
- MGN9C Rail on X (2x MGN7H spare rails are available, so you could change it back if you want)
- Sharkfin Extruder [repo](https://github.com/KayosMaker/Sailfin-Extruder/tree/main/Usermods/KayosMaker)
- Fermio Heatbed
- GraviFlex Magnetic Sheet
- Raspberry Pi Zero 2 W
- OLED Screen
- Rear Klicky Sensor
- Normal Z Endstop is mounted, so you use that as well
- Utility Belt
- Umbilical PCB Upgrade
- 2x Spring Steel Platte with Smooth PEI
- 2x Spare Smooth PEI
- 1x Double Sided Textured PEI Sheet

## config

Original config was provided by Christoph

Converted home and probe to use upstream klicky-macros.

## macros

[TEST_SPEED.cfg](https://raw.githubusercontent.com/AndrewEllis93/Print-Tuning-Guide/main/macros/TEST_SPEED.cfg) from Andrew Ellis, see the instructions, [here](https://github.com/AndrewEllis93/Print-Tuning-Guide/blob/main/articles/determining_max_speeds_accels.md#usage-of-the-test_speed-macro=).

* [AndrewEllis](https://github.com/AndrewEllis93/v2.247_backup_klipper_config/blob/master/macros.cfg)
* https://github.com/zellneralex/klipper_config

### PIF slicer profiles to learn from

[Stephan - landofschnitzel](https://github.com/Stephan3/Schnitzelslicerrepo)
[Andrew Ellis](https://github.com/AndrewEllis93/Ellis-PIF-Profile)

### things I found that could be useful

[thermal tape for heat sinks](https://www.amazon.de/dp/B07CSR6NJC)https://www.amazon.de/

### resonance testing

Results:

[X shaper](docs/shaper_x.png)
[Y shaper](docs/shaper_y.png)

```python
[resonance_tester]: 
accel_chip: adxl345
probe_points:
    60,60,40
shaper_freq_x: 123.6
shaper_type_x: mzv
shaper_freq_y: 82.6
shaper_type_y: mzv

```

## ebb36 using USB and not CAN

Flash katapult onto the skr mini e3 v2.0

https://klipper.discourse.group/t/flashing-klipper-friendly-bootloader-on-btt-skr-mini-e3-v2/10977

Flash ebb36 into USB

[Mount for the Pi Zero](https://github.com/VoronDesign/Voron-0/blob/Voron0.1/STLs/Raspberry_Pi_0_Mount_x1.stl)

## ebb36 gen2 v1.0 via usb

Follow https://usb.esoterical.online/initial_stm32.html for firmware initial katapult flash.


```shell
echo "katapult initial dfu mode install
cd ~/katapult
make clean
make menuconfig KCONFIG_CONFIG=~/config/config.katapult.ebb-gen2
make -j4 KCONFIG_CONFIG=~/config/config.katapult.ebb-gen2
sudo dfu-util -R -a 0 -s 0x08000000:mass-erase:force:leave -D ~/katapult/out/katapult.bin -d 0483:df11
echo "kalico install"
cd ~/klipper
make clean
make menuconfig KCONFIG_CONFIG=~/config/config.kalico.ebb-gen2
make -j4 KCONFIG_CONFIG=~/config/config.kalico.ebb-gen2
make flash FLASH_DEVICE=0483:df11 KCONFIG_CONFIG=~/config/config.kalico.ebb-gen2
```

## kalico on usb mini E3 v2.0

```shell
cd ~/klipper
make clean
make menuconfig KCONFIG_CONFIG=~/config/config.btt-skr-mini-e3-v2
make -j4 KCONFIG_CONFIG=~/config/config.btt-skr-mini-e3-v2
make flash FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32f103xe_30FFDA05344E393729680957-if00 KCONFIG_CONFIG=~/config/config.btt-skr-mini-e3-v2
```
