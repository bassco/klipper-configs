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


[TEST_SPEED.cfg](https://raw.githubusercontent.com/AndrewEllis93/Print-Tuning-Guide/main/macros/TEST_SPEED.cfg) from Andrew Ellis, see the instructions, [here](https://github.com/AndrewEllis93/Print-Tuning-Guide/blob/main/articles/determining_max_speeds_accels.md#usage-of-the-test_speed-macro=).

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

