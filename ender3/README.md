# Ender 3 - Micro-Swiss DDE and Triangle Labs 3:1 extruder motor


Standard Ender 3 with the following changes:
- BTT Ender Mini E3 Turbo board
- BLTouch for Z endstop
- 3 point bed level plate
- Micro-Swiss DDE
- TriangleLab 3:1 Extruder Geared Stepper Motor
- Energetic Spring Steel Smooth PEI printing plate

## Mechanical Alignment

Used this video for (https://www.youtube.com/watch?v=4bFYH0X3qjk)[X-Gantry]

## Klipper firmware

The BTT Ender Mini 3 v1.0 board has an STMF103 72MHz chipset.

Attached `.config` has requires some special config which is attached here.

Copy the `.config` file and `make` to create the firmware.

The `make flash /dev/....` does not work for this chipset/board.

Copy `out/klipper.bin` to the SDcard as `firmware.bin` and start the machine.

## Klipper printer.cfg

Upload the printer.cfg file to the Pi.

Restart the klipper software in the fluidd UI.

## Commissioning

### PID Tuning

* PID_CALIBRATE HEATER=extruder TARGET=170
* SAVE_CONFIG
* PID_CALIBRATE HEATER=heater_bed TARGET=60
* SAVE_CONFIG

### Bed Levelling

Start at the centre right wheel - as this installation has a 3-point bed

```gcode
BED_MESH_CLEAR
G28
G1 Z10
G1 X220 Y120.5 F6000
PROBE_ACCURACY
; Determine the z-height to adjust the wheels of the opposite two corners to aim for as an initial levelling
G1 X55 Y23 F6000
PROBE_ACCURACY
; Adjust the dial and repeat the PROBE_ACCURACY until the avg. is near the first probe point
G1 X55 Y218 F6000
PROBE_ACCURACY
SAVE_CONFIG
```

Repeat a final test and then run the BED_MESH_CALIBRATE

### Input Shaper

* Enable SPI in `sudo raspi-config`
* Remove the serial prefix with `vim /boot/comdline.txt`

Add the mcu and resonance_tester sections to printer.cfg

```
[mcu rpi]
serial: /tmp/klipper_host_mcu

[adxl345]
cs_pin: rpi:None

[resonance_tester]
accel_chip: adxl345
probe_points:
    100,100,20  # an example
```

* ~/klippy-env/bin/pip install -v numpy
* sudo apt install python-numpy python-matplotlib

* G28
* ACCELEROMETER_QUERY
* MEASURE_AXES_NOISE

Set the accel values high

```
[printer]
max_accel: 7000
max_accel_to_decel: 7000
```
Disable input shaper and run the test
* SET_INPUT_SHAPER SHAPER_FREQ_X=0 SHAPER_FREQ_Y=0
* The above is ok to fail if you do not have a `[input_shaper]` section
* TEST_RESONANCES AXIS=X
* TEST_RESONANCES AXIS=Y

Generate the output
Change the timestamp as appropriate

```
~/klipper/scripts/calibrate_shaper.py /tmp/resonances_x_20210130_213818.csv -o /tmp/shaper_calibrate_x.png
Fitted shaper 'zv' frequency = 46.8 Hz (vibrations = 29.8%, smoothing ~= 0.076)
Fitted shaper 'mzv' frequency = 40.4 Hz (vibrations = 13.5%, smoothing ~= 0.125)
Fitted shaper 'ei' frequency = 48.4 Hz (vibrations = 12.0%, smoothing ~= 0.138)
Fitted shaper '2hump_ei' frequency = 52.4 Hz (vibrations = 7.3%, smoothing ~= 0.197)
Fitted shaper '3hump_ei' frequency = 50.0 Hz (vibrations = 4.6%, smoothing ~= 0.328)
Recommended shaper is 2hump_ei @ 52.4 Hz
```
[X](shaper_calibrate_x.png)[X Shaper Result]

```
~/klipper/scripts/calibrate_shaper.py /tmp/resonances_y_20210130_221343.csv -o /tmp/shaper_calibrate_y.png
Fitted shaper 'zv' frequency = 46.4 Hz (vibrations = 37.0%, smoothing ~= 0.077)
Fitted shaper 'mzv' frequency = 31.4 Hz (vibrations = 15.9%, smoothing ~= 0.207)
Fitted shaper 'ei' frequency = 41.6 Hz (vibrations = 15.2%, smoothing ~= 0.186)
Fitted shaper '2hump_ei' frequency = 44.2 Hz (vibrations = 8.2%, smoothing ~= 0.276)
Fitted shaper '3hump_ei' frequency = 50.0 Hz (vibrations = 6.3%, smoothing ~= 0.328)
Recommended shaper is 3hump_ei @ 50.0 Hz
```

[Y](shaper_calibrate_y.png)[Y Shaper Result]

Set the `[input_shaper]` from the above outputs

```
[input_shaper]
shaper_freq_x: 52.4
shaper_type_x: 2hump_ei
shaper_freq_y: 50.0
shaper_type_y: 3hump_ei

```

Print the ringing_tower.stl to confirm that you have good settings.

Vase mode 6 base layers bottom 0.25mm height at 100 mm/s on all perimeters. 0.95 flow with the set rotation_distance is on point wit 0.4mm


SET_PRESSURE_ADVANCE ADVANCE=0
; disable t
SET_INPUT_SHAPER SHAPER_FREQ_X=0 SHAPER_FREQ_Y=0
TUNING_TOWER COMMAND=SET_VELOCITY_LIMIT PARAMETER=ACCEL START=1250 FACTOR=100 BAND=5
RESTART
; Print with input_shaper set
TUNING_TOWER COMMAND=SET_VELOCITY_LIMIT PARAMETER=ACCEL START=1250 FACTOR=100 BAND=5

The difference between resonance disabled and enabled is mind boggling. The quality is at another level. Rigning is all but banished. Lovely square corners too.



### Pressure Advance

Read the [docs](https://www.klipper3d.org/Pressure_Advance.html) on github.

```
SET_PRESSURE_ADVANCE ADVANCE=0
SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500
TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005
```

#### Print the test file
calibration/CE3_square_tower.gcode

pressure_advance: 0.07500