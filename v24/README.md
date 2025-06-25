# Voron 2.4 300mm build

Changed firmware from Klipper to DangerKlipper
 
- [DangerKlipper](https://github.com/DangerKlippers/danger-klipper/)
- [docs](https://dangerklipper.io/)

[Board](https://github.com/FYSETC/FYSETC-SPIDER)

* Carbon filter: Nevermore - yes - configure needs to be done and also needs reprinting as the cover has warped and is no longer air tight.
* GE5C bearing mod - yes - https://github.com/hartk1213/MISC/tree/main/Voron%20Mods/Voron%202/2.4/Voron2.4_GE5C
* Pins mod for MGN12 -  yes
* Stealthburner and CW2
* Phaetus Dragon with Zodiac Coated nozzle
* SB2040 CanBus v1 from Mellow
* Mellow Fly-UtoC-1 - Does not require a R120 jumper. Yellow is H and White is L. 
* Voron Tap - for z nozzle probe
* RGB Chamber Lights from oc_geek
* Bed Wagos from deepfriedhero.in https://github.com/VoronDesign/VoronUsers/tree/master/printer_mods/deepfriedheroin/v2_bed_wagos
* https://www.thingiverse.com/thing:4817974 or https://www.thingiverse.com/thing:4828117 or https://github.com/Ramalama2/Voron-2-Mods/tree/main/Wagomount_221
* Ramalama2 [front-idlers](https://github.com/Ramalama2/Voron-2-Mods/tree/main/Front_Idlers)
  G28 Z
  G28 Z
* https://www.printables.com/model/201999-nozzle-scrubber-with-a-little-bucket-for-voron-24
* https://github.com/nevermore3d/Nevermore_Micro
* https://github.com/tanaes/whopping_Voron_mods/tree/main/extrusion_backers
* 3010 fan mod for electronics cover for SB204 on CW2 - to be added
* Added a (TP-LINK T3U)[https://www.amazon.de/dp/B0859M539M] usb wifi adapter and disabled the on-board wifi
* Added shaketune [macros][shaketune] from Frix-x
* Added nozzle [wiper](https://github.com/scheffield/nozzle-cleaner)

Interesting research projects

* https://github.com/alchemyEngine/measure_thermal_behavior/blob/main/process_frame_expansion.py
* [Adaptive meshing](https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging) with Exclude Object enabled, which I have
* [Probe Accuracy](https://github.com/sporkus/probe_accuracy_tests) for z corner pulley tension adjustment 

CW2:
* DELTA BFB0524HH BLOWER FAN - 5015 blower for part cooling
* NMB 4010 SS-24N-AT-00 

Wiring: https://cdn.discordapp.com/attachments/624317225540780055/928014037734801408/20220104_191958.jpg

https://github.com/AndrewEllis93/Ellis-PIF-Profile
https://github.com/AndrewEllis93/Print-Tuning-Guide

Coverted to CANBus when installing StealthBurner and Voron Tap

- configure and flash [canboot](https://github.com/Arksine/CanBoot) to the SB2040 - [instructions](https://github.com/cruiten/Voron-Related/blob/main/CANbus/Documentation/SB2040_CAN/install_configure_canboot.md)
- now we need a 16kb offset in klipper for the SB2040 - to allow flashing via klipper in the future
- then flash klipper to the SB2040

i.e. the SB2040 - needs CanBoot to allow klipper to flash remotely. Then we install klipper in the program space of the device.

Jumpers for sensorless homing installed on the X and Y drivers. -  trigger positions to be tested and set

https://www.klipper3d.org/CANBUS.html
https://github.com/cruiten/Voron-Related/blob/main/CANbus/Documentation

Added [Klippercreen][ks]

## Commissioning

* Hotend thermistor wires don't like staying in their crimps on the toolhead board. Maybe the SB board with the Molex connector will be better?
* Add jumpers to M3-2 to disable to dual-Z and to enable `STEPPER_BUZZ stepper=stepper_z` to actually work.
* Move the X and Y endstop from (-) to (+)
* Hall Effect sensor board - Y works, X LED stays lit and goes off when triggered - seems inverted logic. Will swap out board and retest once the cables are moved.
* Bed temp thermistor wires might have broken off - not getting any readings and MCU shutdown error. Disabled config.
* Homing X caused the gantry to move down - need to verify what this is - very confusing - used the kill switch on the LCD (checked before issuing the homing command). 
* Terrible metal on metal squeak was the Z accent covers that were running on the pulleys - added little plastic spacers and longer screws
* The SSR was not coming on and heating the bed. You need to supply 24v to the BED_IN terminals on the board. Created jumper wires from the 24V in wires to brodge to the BED_IN and that sorted it out.

### sb2040 and tap commissioning

- [x] Extruder
  - [x] direction is good
  - [x] calibrate steps
  - [x] pid calibrate
- [ ] Fans
  - [x] Part Cooling
  - [x] Hotend Cooling
  - [ ] Extruder 3010/3070 fan not working - ripped pads?
- [x] Sensorless
  - [x] x direction and sensitivity
  - [x] y direction and sensitivity
- [x] Hotend
  - [x] temp sensor
  - [x] heater
- [x] Leds
  - [x] stealthburner leds showing
  - [ ] add led colours to menu
  - [ ] add led colour statuses to print macros
- [x] Tap Probe
  - [x] endstop working
  - [x] tap speed 6mm/s - using probe_accuracy_test --speedtest parameter from 3 to 10
- [x] homing override
  - [x] x does not z hop - can hit bed if not qgl
  - [x] y does not z hop - can hit bed if not qgl
  - [x] z does not centre toolhead at x150 and y150
- [x] bed
  - [x] removed kinematic mount
  - [x] installed servo nozzle brush from [tronfu](https://github.com/tronfu/Voron-Mods/blob/main/Servo_Nozzle_Brush)
  - [x] added clean_nozzle to print_start
  - [x] added earth wire
- [x] gantry bed corner [measurements](https://klipper.discourse.group/t/qgl-behaviour-on-a-voron350/6516/8)
 

### tap probe speed validation

```console
cd ~/probe_accuracy_tests

pi@v24:~/probe_accuracy_tests $ python3 $HOME/probe_accuracy_tests/probe_accuracy_test_suite.py --speedtest
Warning: gcode_macro _User_Variables.safe_z is not configured
Safe z has not been set in klicky-variables
Enter safe z height to avoid crash:20

Test a range of z-probe speed

Minimum speed?  3
Maximum speed?  10
Steps between speeds?  1
3.0mm/s...4.0mm/s...5.0mm/s...6.0mm/s...7.0mm/s...8.0mm/s...9.0mm/s...10.0mm/s...Done
           min       max     first      last      mean       std  count     range     drift
test
3.0   0.621250  0.633125  0.633125  0.622500  0.623875  0.003357     10  0.011875 -0.010625
4.0   0.622500  0.624375  0.622500  0.623750  0.623188  0.000622     10  0.001875  0.001250
5.0   0.625000  0.626250  0.625000  0.626250  0.625625  0.000417     10  0.001250  0.001250
6.0   0.627500  0.628125  0.628125  0.628125  0.627875  0.000323     10  0.000625  0.000000
7.0   0.628750  0.629375  0.629375  0.629375  0.629125  0.000323     10  0.000625  0.000000
8.0   0.628125  0.628750  0.628125  0.628750  0.628500  0.000323     10  0.000625  0.000625
9.0   0.631250  0.632500  0.631875  0.631250  0.631812  0.000461     10  0.001250 -0.000625
10.0  0.628125  0.629375  0.628750  0.628750  0.628500  0.000437     10  0.001250  0.000000
--------------------------------------------------------------------------------
```

### first corner test

```console
pi@v24:~/probe_accuracy_tests $ python3 $HOME/probe_accuracy_tests/probe_accuracy_test_suite.py --corner
Leveling
Warning: gcode_macro _User_Variables.safe_z is not configured
Safe z has not been set in klicky-variables
Enter safe z height to avoid crash:20

Test probe around the bed to see if there are issues with individual drives
Leveling
4...3...2...1...Done
                                   min       max     first     last      mean       std  count     range     drift
test
1:corner 30samples (40, 260)   0.73125  0.753125  0.753125  0.73500  0.735854  0.003937     30  0.021875 -0.018125
2:corner 30samples (260, 260)  0.73500  0.741250  0.735000  0.74125  0.739375  0.001228     30  0.006250  0.006250
3:corner 30samples (40, 40)    0.76000  0.769375  0.761250  0.76625  0.765688  0.002078     30  0.009375  0.005000
4:corner 30samples (260, 40)   0.77250  0.790625  0.772500  0.78750  0.783625  0.004828     30  0.018125  0.015000
--------------------------------------------------------------------------------
```



### Gantry Corner Measurements

As per the checklist - measure you z-belt centre to the inside belt from the (0,0) coordinate to enable the QGL algorithm to converge.

Here is the result after change the corner positions to match the physical printer.

```console
// Retries: 1/3 Probed points range: 0.003125 tolerance: 0.008000
```

Previously 2 or 3 attmepts were required to reach the required tolerance.


### PID Calibrate

Set fan to 40% and calibrate the heater for the hot end.

```gcode
M106 S102
PID_CALIBRATE heater=extruder TARGET=240
SAVE_CONFIG
```
Extruder settings:
```shell
pid_Kp=24.058 pid_Ki=1.471 pid_Kd=98.339
```
Why is the hotend fan not running.... I had the wires swapped - easy fix.

### raspberry pi

* enable SPI
* enable Serial 

Edit `/boot/config.txt` and disable the BT stack to run the GPIO between the spider and the pi.
See the [rpi config](config.txt) for details - just replace the file and reboot.
 
#### change locale

Set en_GB.UTF-8 in localisation `sudo raspi-config` and then update the locale defaults file too.

```shell
cat /etc/defaults/locale
#  File generated by update-locale
LANG=en_GB.UTF-8
LANGUAGE=en_GB.UTF-8
LC_ALL=en_GB.UTF-8
```

#### aliases

Copy the .bash_aliases

#### compile and update klipper

Initial setup. Configure the klipper.config file with the correct parameters.

```shell
mkdir ~/bin
cd ~/bin
ln -sf ~/klipper_config/update-mcu
```

Updating the firmware

```shell
update-mcu
```

The following error is expected - as the rpi is connected internally via uart and the USB port is not used for connection. Need to manually copy the out/klipper.bin to FIRMWARE.BIN on an SDCard.

```shell
SPIFlashError: Failed to Initialize SD Card. Is it inserted?
```


Upload the FIRMWARE.BIN to an SDCARD and insert into the board. Press the Reset button once, maybe twice. Check the status lights - fast blinking, then slow blinking and then off.

Remove the SDCARD and confirm the filename has changed to OLD.BIN

Do a FIRMWARE_RESTART in the browser and the board should now be recognised and the thermistors should be active.


###

Good tips for the Voron from Kapman's Basement Workshop on (YT){https://www.youtube.com/watch?v=-DcdVez_v5Q}

### Input Shaper

`SHAPER_CALIBRATE` is a short-cut for X and Y TEST_RESONANCE and can SAVE_CONFIG the calculated values.

```console
0:12:25 
// Calculating the best input shaper parameters for x axis
20:12:28 
// Fitted shaper 'zv' frequency = 49.6 Hz (vibrations = 5.2%, smoothing ~= 0.069)
20:12:28 
// To avoid too much smoothing with 'zv', suggested max_accel <= 9600 mm/sec^2
20:12:32 
// Fitted shaper 'mzv' frequency = 48.4 Hz (vibrations = 1.3%, smoothing ~= 0.087)
20:12:32 
// To avoid too much smoothing with 'mzv', suggested max_accel <= 6900 mm/sec^2
20:12:35 
// Fitted shaper 'ei' frequency = 54.4 Hz (vibrations = 0.0%, smoothing ~= 0.109)
20:12:35 
// To avoid too much smoothing with 'ei', suggested max_accel <= 5500 mm/sec^2
20:12:38 
// Fitted shaper '2hump_ei' frequency = 59.0 Hz (vibrations = 0.0%, smoothing ~= 0.155)
20:12:38 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 3900 mm/sec^2
20:12:42 
// Fitted shaper '3hump_ei' frequency = 86.6 Hz (vibrations = 0.0%, smoothing ~= 0.109)
20:12:42 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 5500 mm/sec^2
20:12:42 
// Recommended shaper_type_x = mzv, shaper_freq_x = 48.4 Hz
20:12:42 
// Shaper calibration data written to /tmp/calibration_data_x_20220611_200739.csv file
20:12:42 
// Calculating the best input shaper parameters for y axis
20:12:45 
// Fitted shaper 'zv' frequency = 59.8 Hz (vibrations = 31.2%, smoothing ~= 0.050)
20:12:45 
// To avoid too much smoothing with 'zv', suggested max_accel <= 13900 mm/sec^2
20:12:48 
// Fitted shaper 'mzv' frequency = 37.2 Hz (vibrations = 5.8%, smoothing ~= 0.147)
20:12:49 
// To avoid too much smoothing with 'mzv', suggested max_accel <= 4100 mm/sec^2
20:12:52 
// Fitted shaper 'ei' frequency = 50.6 Hz (vibrations = 8.3%, smoothing ~= 0.126)
20:12:52 
// To avoid too much smoothing with 'ei', suggested max_accel <= 4800 mm/sec^2
20:12:55 
// Fitted shaper '2hump_ei' frequency = 46.8 Hz (vibrations = 0.8%, smoothing ~= 0.246)
20:12:55 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 2400 mm/sec^2
20:12:59 
// Fitted shaper '3hump_ei' frequency = 51.8 Hz (vibrations = 0.0%, smoothing ~= 0.305)
20:12:59 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 1800 mm/sec^2
20:12:59 
// Recommended shaper_type_y = 2hump_ei, shaper_freq_y = 46.8 Hz
20:12:59 
// Shaper calibration data written to /tmp/calibration_data_y_20220611_200739.csv file
20:12:59 
// The SAVE_CONFIG command will update the printer config file
// with these parameters and restart the printer.
```

Saved values.

```console
[input_shaper]
shaper_type_x = mzv
shaper_freq_x = 48.4
shaper_type_y = 2hump_ei
shaper_freq_y = 46.8
```

[x axis](shaper_calibration_x_20220611_200739.png)
[y axis](shaper_calibration_y_20220611_200739.png)

### sb2040 Input Shaper after umbilical and tap

```console
22:59:25 
// Fitted shaper 'ei' frequency = 64.8 Hz (vibrations = 0.0%, smoothing ~= 0.077)
22:59:25 
// To avoid too much smoothing with 'ei', suggested max_accel <= 7800 mm/sec^2
22:59:28 
// Fitted shaper '2hump_ei' frequency = 80.6 Hz (vibrations = 0.0%, smoothing ~= 0.083)
22:59:28 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 7200 mm/sec^2
22:59:32 
// Fitted shaper '3hump_ei' frequency = 96.2 Hz (vibrations = 0.0%, smoothing ~= 0.089)
22:59:32 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 6800 mm/sec^2
22:59:32 
// Recommended shaper_type_x = zv, shaper_freq_x = 52.6 Hz
22:59:32 
// Shaper calibration data written to /tmp/calibration_data_x_20230306_225431.csv file
22:59:32 
// Calculating the best input shaper parameters for y axis
22:59:35 
// Fitted shaper 'zv' frequency = 44.0 Hz (vibrations = 2.3%, smoothing ~= 0.085)
22:59:35 
// To avoid too much smoothing with 'zv', suggested max_accel <= 7500 mm/sec^2
22:59:38 
// Fitted shaper 'mzv' frequency = 43.4 Hz (vibrations = 0.0%, smoothing ~= 0.108)
22:59:38 
// To avoid too much smoothing with 'mzv', suggested max_accel <= 5500 mm/sec^2
22:59:42 
// Fitted shaper 'ei' frequency = 51.8 Hz (vibrations = 0.0%, smoothing ~= 0.120)
22:59:42 
// To avoid too much smoothing with 'ei', suggested max_accel <= 5000 mm/sec^2
22:59:45 
// Fitted shaper '2hump_ei' frequency = 64.4 Hz (vibrations = 0.0%, smoothing ~= 0.130)
22:59:45 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 4600 mm/sec^2
22:59:49 
// Fitted shaper '3hump_ei' frequency = 77.0 Hz (vibrations = 0.0%, smoothing ~= 0.138)
22:59:49 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 4300 mm/sec^2
22:59:49 
// Recommended shaper_type_y = mzv, shaper_freq_y = 43.4 Hz
22:59:49 
// Shaper calibration data written to /tmp/calibration_data_y_20230306_225431.csv file
22:59:49 
// The SAVE_CONFIG command will update the printer config file
// with these parameters and restart the printer.
```
 
See the resonance testing at [docs](https://www.klipper3d.org/Measuring_Resonances.html) site.

Use raw_data OUTPUT to be able to create graphs

```console
SET_INPUT_SHAPER SHAPER_FREQ_X=0 SHAPER_FREQ_Y=0
TEST_RESONANCES AXIS=X OUTPUT=raw_data
TEST_RESONANCES AXIS=Y OUTPUT=raw_data

# then in the console of the machine
~/klipper/scripts/graph_accelerometer.py /tmp/raw_data_x_*.csv -o /tmp/resonances_x.png -c -a z
```


### input shaper on lak table

```console
21:42:46 
// Calculating the best input shaper parameters for x axis
21:42:49 
// Fitted shaper 'zv' frequency = 57.6 Hz (vibrations = 9.2%, smoothing ~= 0.053)
21:42:49 
// To avoid too much smoothing with 'zv', suggested max_accel <= 12900 mm/sec^2
21:42:53 
// Fitted shaper 'mzv' frequency = 55.8 Hz (vibrations = 1.3%, smoothing ~= 0.065)
21:42:53 
// To avoid too much smoothing with 'mzv', suggested max_accel <= 9200 mm/sec^2
21:42:56 
// Fitted shaper 'ei' frequency = 51.0 Hz (vibrations = 0.2%, smoothing ~= 0.124)
21:42:56 
// To avoid too much smoothing with 'ei', suggested max_accel <= 4800 mm/sec^2
21:43:00 
// Fitted shaper '2hump_ei' frequency = 81.0 Hz (vibrations = 0.0%, smoothing ~= 0.082)
21:43:00 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 7300 mm/sec^2
21:43:03 
// Fitted shaper '3hump_ei' frequency = 97.6 Hz (vibrations = 0.0%, smoothing ~= 0.086)
21:43:03 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 7000 mm/sec^2
21:43:03 
// Recommended shaper_type_x = mzv, shaper_freq_x = 55.8 Hz
21:43:03 
// Shaper calibration data written to /tmp/calibration_data_x_20230406_213801.csv file
21:43:03 
// Calculating the best input shaper parameters for y axis
21:43:06 
// Fitted shaper 'zv' frequency = 43.4 Hz (vibrations = 3.6%, smoothing ~= 0.087)
21:43:06 
// To avoid too much smoothing with 'zv', suggested max_accel <= 7300 mm/sec^2
21:43:10 
// Fitted shaper 'mzv' frequency = 41.8 Hz (vibrations = 0.0%, smoothing ~= 0.117)
21:43:10 
// To avoid too much smoothing with 'mzv', suggested max_accel <= 5100 mm/sec^2
21:43:14 
// Fitted shaper 'ei' frequency = 50.0 Hz (vibrations = 0.0%, smoothing ~= 0.129)
21:43:14 
// To avoid too much smoothing with 'ei', suggested max_accel <= 4700 mm/sec^2
21:43:17 
// Fitted shaper '2hump_ei' frequency = 62.2 Hz (vibrations = 0.0%, smoothing ~= 0.139)
21:43:17 
// To avoid too much smoothing with '2hump_ei', suggested max_accel <= 4300 mm/sec^2
21:43:21 
// Fitted shaper '3hump_ei' frequency = 75.0 Hz (vibrations = 0.0%, smoothing ~= 0.146)
21:43:21 
// To avoid too much smoothing with '3hump_ei', suggested max_accel <= 4100 mm/sec^2
21:43:21 
// Recommended shaper_type_y = mzv, shaper_freq_y = 41.8 Hz
21:43:21 
// Shaper calibration data written to /tmp/calibration_data_y_20230406_213801.csv file
21:43:21 
// The SAVE_CONFIG command will update the printer config file
```


### disable on-board wifi

Takes about 5 minutes to compile the module....

```console
sudo su - root
apt-get install dkms raspberrypi-kernel-headers
git clone "https://github.com/RinCat/RTL88x2BU-Linux-Driver.git" /usr/src/rtl88x2bu-git
sed -i 's/PACKAGE_VERSION="@PKGVER@"/PACKAGE_VERSION="git"/g' /usr/src/rtl88x2bu-git/dkms.conf
dkms add -m rtl88x2bu -v git
dkms autoinstall

modprobe 88x2bu 
echo -e  "blacklist brcmfmac\nblacklist brcmutil\n" > /etc/modprobe.d/raspi-blacklist.conf
# check the new IP address on the router to connect after reboot
reboot
```

### klipperscreen network error

When installing [KlipperScreen][ks], the default networking is changed to NetworkManager and it knocked out my wifi and I was unable to connect to the pi.

Fortunately, a LAN cable saved the day and after a reboot, the IP address was displayed on the screen.

I used (this article)[https://wiki.ubuntuusers.de/NetworkManager/NetworkManager_ohne_GUI/] with `nmcli` to list the wifi devices and configure the wifi adapter.

I also had to re-run the KlipperScreen install script, as the initial installation killed the network part way through.

On the second script install, KlipperScreen installed successfully.

###

Install [shaketune]

```console
wget -O - https://raw.githubusercontent.com/Frix-x/klippain-shaketune/main/install.sh | bash
```

Take measurements - always reset magents whn emoving TAP or you get a 125MHz frequency spike :( 

After setting IS values  - test a voron cube with these settings to verify print quality.

voron cube: 3 perimeters, 0 infill, 0 top, 3-4 bottoms

```console
CREATE_VIBRATIONS_PROFILE

/ Machine estimated vibration symmetry: 99.9%
00:01:24 // Vibrations peaks detected: 5 @ 42.3, 52.6, 80.3, 83.6, 105.8 mm/s (avoid setting a speed near these values in your slicer print profile)
00:01:24 // Lowest vibrations speeds (4 ranges sorted from best to worse):
00:01:24 // 1: 2.0 to 37.4 mm/s
00:01:24 // 2: 57.5 to 73.4 mm/s
00:01:24 // 3: 89.3 to 103.8 mm/s
00:01:24 // 4: 107.8 to 200.0 mm/s
00:01:24 // Lowest vibrations angles (4 ranges sorted from best to worse):
00:01:24 // 1: 125.2° to 145.2° (mean vibrations energy: 48.35% of max)
00:01:24 // 2: 304.9° to 325.5° (mean vibrations energy: 49.13% of max)
00:01:24 // 3: 215.3° to 235.3° (mean vibrations energy: 57.04% of max)
00:01:24 // 4: 35.0° to 55.1° (mean vibrations energy: 57.04% of max)
00:01:27 // Motors have a main resonant frequency at 269.1Hz with an estimated damping ratio of 0.043
00:02:06 // vibrations profile graphs created successfully!
00:02:06 // Cleaned up the output folder (only the last 5 results were kept)!
```

### autotune

Install the tmc-autotune

```console
 wget -O - https://raw.githubusercontent.com/andrewmcgr/klipper_tmc_autotune/main/install.sh | bash
```

The autotune.cfg is set and the results are..

```
[autotune_tmc stepper_x]
[autotune_tmc stepper_y]
[autotune_tmc stepper_z]
[autotune_tmc stepper_z1]
[autotune_tmc stepper_z2]
[autotune_tmc stepper_z3]
[autotune_tmc extruder]
autotune_tmc set stepper_x hstrt=7
autotune_tmc set stepper_x hend=4
autotune_tmc set stepper_x pwm_freq=2
autotune_tmc set stepper_x sgthrs=147
autotune_tmc using max PWM speed 502.929620
autotune_tmc set stepper_x pwm_autoscale=True
autotune_tmc set stepper_x pwm_autograd=True
autotune_tmc set stepper_x pwm_grad=5
autotune_tmc set stepper_x pwm_ofs=18
autotune_tmc set stepper_x pwm_reg=15
autotune_tmc set stepper_x pwm_lim=4
autotune_tmc set stepper_x tpwmthrs=1048575
autotune_tmc set stepper_x en_spreadcycle=True
autotune_tmc set stepper_x tbl=1
autotune_tmc set stepper_x toff=3
autotune_tmc set stepper_x tcoolthrs=146(32.0)
autotune_tmc set stepper_x semin=8
autotune_tmc set stepper_x semax=4
autotune_tmc set stepper_x seup=3
autotune_tmc set stepper_x sedn=0
autotune_tmc set stepper_x seimin=0
autotune_tmc set stepper_x iholddelay=12
autotune_tmc set stepper_x multistep_filt=True
autotune_tmc set stepper_y hstrt=7
autotune_tmc set stepper_y hend=4
autotune_tmc set stepper_y pwm_freq=2
autotune_tmc set stepper_y sgthrs=158
autotune_tmc using max PWM speed 502.929620
autotune_tmc set stepper_y pwm_autoscale=True
autotune_tmc set stepper_y pwm_autograd=True
autotune_tmc set stepper_y pwm_grad=5
autotune_tmc set stepper_y pwm_ofs=18
autotune_tmc set stepper_y pwm_reg=15
autotune_tmc set stepper_y pwm_lim=4
autotune_tmc set stepper_y tpwmthrs=1048575
autotune_tmc set stepper_y en_spreadcycle=True
autotune_tmc set stepper_y tbl=1
autotune_tmc set stepper_y toff=3
autotune_tmc set stepper_y tcoolthrs=146(32.0)
autotune_tmc set stepper_y semin=8
autotune_tmc set stepper_y semax=4
autotune_tmc set stepper_y seup=3
autotune_tmc set stepper_y sedn=0
autotune_tmc set stepper_y seimin=0
autotune_tmc set stepper_y iholddelay=12
autotune_tmc set stepper_y multistep_filt=True
autotune_tmc set stepper_z hstrt=3
autotune_tmc set stepper_z hend=3
autotune_tmc set stepper_z pwm_freq=2
autotune_tmc set stepper_z sgthrs=10
autotune_tmc using max PWM speed 213.722352
autotune_tmc set stepper_z pwm_autoscale=True
autotune_tmc set stepper_z pwm_autograd=True
autotune_tmc set stepper_z pwm_grad=14
autotune_tmc set stepper_z pwm_ofs=20
autotune_tmc set stepper_z pwm_reg=15
autotune_tmc set stepper_z pwm_lim=4
autotune_tmc set stepper_z tpwmthrs=0
autotune_tmc set stepper_z en_spreadcycle=False
autotune_tmc set stepper_z tbl=1
autotune_tmc set stepper_z toff=3
autotune_tmc set stepper_z tcoolthrs=59(32.0)
autotune_tmc set stepper_z semin=8
autotune_tmc set stepper_z semax=4
autotune_tmc set stepper_z seup=3
autotune_tmc set stepper_z sedn=0
autotune_tmc set stepper_z seimin=0
autotune_tmc set stepper_z iholddelay=12
autotune_tmc set stepper_z multistep_filt=True
autotune_tmc set stepper_z1 hstrt=3
autotune_tmc set stepper_z1 hend=3
autotune_tmc set stepper_z1 pwm_freq=2
autotune_tmc set stepper_z1 sgthrs=10
autotune_tmc using max PWM speed 213.722352
autotune_tmc set stepper_z1 pwm_autoscale=True
autotune_tmc set stepper_z1 pwm_autograd=True
autotune_tmc set stepper_z1 pwm_grad=14
autotune_tmc set stepper_z1 pwm_ofs=20
autotune_tmc set stepper_z1 pwm_reg=15
autotune_tmc set stepper_z1 pwm_lim=4
autotune_tmc set stepper_z1 tpwmthrs=0
autotune_tmc set stepper_z1 en_spreadcycle=False
autotune_tmc set stepper_z1 tbl=1
autotune_tmc set stepper_z1 toff=3
autotune_tmc set stepper_z1 tcoolthrs=59(32.0)
autotune_tmc set stepper_z1 semin=8
autotune_tmc set stepper_z1 semax=4
autotune_tmc set stepper_z1 seup=3
autotune_tmc set stepper_z1 sedn=0
autotune_tmc set stepper_z1 seimin=0
autotune_tmc set stepper_z1 iholddelay=12
autotune_tmc set stepper_z1 multistep_filt=True
autotune_tmc set stepper_z2 hstrt=3
autotune_tmc set stepper_z2 hend=3
autotune_tmc set stepper_z2 pwm_freq=2
autotune_tmc set stepper_z2 sgthrs=10
autotune_tmc using max PWM speed 213.722352
autotune_tmc set stepper_z2 pwm_autoscale=True
autotune_tmc set stepper_z2 pwm_autograd=True
autotune_tmc set stepper_z2 pwm_grad=14
autotune_tmc set stepper_z2 pwm_ofs=20
autotune_tmc set stepper_z2 pwm_reg=15
autotune_tmc set stepper_z2 pwm_lim=4
autotune_tmc set stepper_z2 tpwmthrs=0
autotune_tmc set stepper_z2 en_spreadcycle=False
autotune_tmc set stepper_z2 tbl=1
autotune_tmc set stepper_z2 toff=3
autotune_tmc set stepper_z2 tcoolthrs=59(32.0)
autotune_tmc set stepper_z2 semin=8
autotune_tmc set stepper_z2 semax=4
autotune_tmc set stepper_z2 seup=3
autotune_tmc set stepper_z2 sedn=0
autotune_tmc set stepper_z2 seimin=0
autotune_tmc set stepper_z2 iholddelay=12
autotune_tmc set stepper_z2 multistep_filt=True
autotune_tmc set stepper_z3 hstrt=3
autotune_tmc set stepper_z3 hend=3
autotune_tmc set stepper_z3 pwm_freq=2
autotune_tmc set stepper_z3 sgthrs=10
autotune_tmc using max PWM speed 213.722352
autotune_tmc set stepper_z3 pwm_autoscale=True
autotune_tmc set stepper_z3 pwm_autograd=True
autotune_tmc set stepper_z3 pwm_grad=14
autotune_tmc set stepper_z3 pwm_ofs=20
autotune_tmc set stepper_z3 pwm_reg=15
autotune_tmc set stepper_z3 pwm_lim=4
autotune_tmc set stepper_z3 tpwmthrs=0
autotune_tmc set stepper_z3 en_spreadcycle=False
autotune_tmc set stepper_z3 tbl=1
autotune_tmc set stepper_z3 toff=3
autotune_tmc set stepper_z3 tcoolthrs=59(32.0)
autotune_tmc set stepper_z3 semin=8
autotune_tmc set stepper_z3 semax=4
autotune_tmc set stepper_z3 seup=3
autotune_tmc set stepper_z3 sedn=0
autotune_tmc set stepper_z3 seimin=0
autotune_tmc set stepper_z3 iholddelay=12
autotune_tmc set stepper_z3 multistep_filt=True
autotune_tmc set extruder hstrt=7
autotune_tmc set extruder hend=9
autotune_tmc set extruder pwm_freq=2
autotune_tmc set extruder sgthrs=10
autotune_tmc using max PWM speed 351.724019
autotune_tmc set extruder pwm_autoscale=True
autotune_tmc set extruder pwm_autograd=True
autotune_tmc set extruder pwm_grad=5
autotune_tmc set extruder pwm_ofs=11
autotune_tmc set extruder pwm_reg=15
autotune_tmc set extruder pwm_lim=4
autotune_tmc set extruder tpwmthrs=1048575
autotune_tmc set extruder en_spreadcycle=True
autotune_tmc set extruder tbl=1
autotune_tmc set extruder toff=3
autotune_tmc set extruder tcoolthrs=59(18.114321192000002)
autotune_tmc set extruder semin=8
autotune_tmc set extruder semax=4
autotune_tmc set extruder seup=3
autotune_tmc set extruder sedn=0
autotune_tmc set extruder seimin=0
autotune_tmc set extruder iholddelay=12
autotune_tmc set extruder multistep_filt=True
```

## provok3d nozzle adxl acceleromoter

See firmware upgrade [docs](https://provok3d.com/wp-content/uploads/2024/02/update-nozzle-adxl-1.3.pdf?v=0a10a0b3e53b)

```console
# jumper the module for dfu mode
lsusb
cd ~
git clone https://github.com/mattthebaker/ampon_anchor.git
cd ampon_anchor && git checkout ampon_f042 && cd
./ampon_anchor/update.sh
# remove usb cable
# remove jumper
# configure the nozzle-adxl.cfg include
```

## add bed fan macro

Added the wiring from 2 central fans using WAGOs from the E0 port of the board.

[Bed fan Macro](https://github.com/3DPrintDemon/Demon-Smart-Bed-Fans-Monitor-System-For-Voron-2.4-Chamber-Circulation/blob/main/demon_bed_fans_monitor_v1.1.cfg)

Very effective, but does add quite a bit of load onto the bed to keep the heater going. Machine would need some thermal insulation to improve this.

## added beacon probe 



```text
BEACON_QUERY
G0 X150 Y150 Z20 F7200

PROBE_ACCURACY
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.617635
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.617635
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.616955
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.616955
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.616610
23:49:38 
// probe at 150.000,150.000,2.000 is z=2.616610
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616302
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616302
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616290
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616290
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616048
23:49:39 
// probe at 150.000,150.000,2.000 is z=2.616048
23:49:40 
// probe at 150.000,150.000,2.000 is z=2.615655
23:49:40 
// probe at 150.000,150.000,2.000 is z=2.615653
23:49:40 
// probe accuracy results: maximum 1.384347, minimum 1.375330, range 0.009018, average 1.382518, median 1.383544, standard deviation 0.000154
23:50:43 
$ BEACON_ESTIMATE_BACKLASH
23:50:45 
// probe at 150.000,150.000,1.347 is z=1.965952
23:50:45 
// Target kinematic Z is 1.382
23:51:01 
// Median distance moving up 1.97075, down 1.98018, delta 0.00943 over 20 samples
```

## xol2 toolhead

[EBB CAN V1.2](https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20and%20V1.2%20%28STM32G0B1%29/EBB36%20CAN%20V1.1%20and%20V1.2/Hardware/EBB36%20CAN%20V1.1%26V1.2-PIN.png)
[Beacon probe](https://docs.beacon3d.com/contact/)


[x] hotend fan
[x] part fan
[x] leds
[x] x-endstop
[ ] extruder direction and rotation distance calibration
[ ]
[x] beacon initial config and z calibration
[x] pid calibration
[ ] shake&tune using beacon accel
[ ] xy belts
[ ] vibrations, homing and slicer speed ranges
[ ] pid values into print_start macro


### extruder pid calibration

```text
PID_CALIBRATE HEATER=extruder TARGET=195.0
PID parameters for 195.00°C: pid_Kp=25.710 pid_Ki=1.911 pid_Kd=86.453
PID_PROFILE SAVE=195 HEATER=extruder
PID_CALIBRATE HEATER=extruder TARGET=210.0
PID parameters for 210.00°C: pid_Kp=26.604 pid_Ki=2.023 pid_Kd=87.462
PID_PROFILE SAVE=210 HEATER=extruder
PID_CALIBRATE HEATER=extruder TARGET=225.0
PID parameters for 225.00°C: pid_Kp=27.321 pid_Ki=2.118 pid_Kd=88.112
PID_PROFILE SAVE=225 HEATER=extruder
PID_CALIBRATE HEATER=extruder TARGET=240.0
PID parameters for 240.00°C: pid_Kp=27.209 pid_Ki=2.085 pid_Kd=88.771
PID_PROFILE SAVE=240 HEATER=extruder
PID_CALIBRATE HEATER=extruder TARGET=255.0
PID parameters for 255.00°C: pid_Kp=27.039 pid_Ki=2.068 pid_Kd=88.385
PID_PROFILE SAVE=255 HEATER=extruder
PID_CALIBRATE HEATER=extruder TARGET=270.0
PID parameters for 270.00°C: pid_Kp=27.478 pid_Ki=2.043 pid_Kd=92.395
PID_PROFILE SAVE=270 HEATER=extruder
```
### new heater due to glue smell

Link to heater bed:
UHU Entferntner
Sonax Klebstoff Entfertner

NTC 3950 100K Thermistor

```text
PID_CALIBRATE HEATER=heater_bed TARGET=55.0
PID parameters for 55.00°C: pid_Kp=15.876 pid_Ki=0.206 pid_Kd=305.815
PID_PROFILE SAVE=55 HEATER=heater_bed
PID_CALIBRATE HEATER=heater_bed TARGET=80.0
PID parameters for 80.00°C: pid_Kp=25.047 pid_Ki=0.491 pid_Kd=319.198
PID_PROFILE SAVE=80 HEATER=heater_bed
PID_CALIBRATE HEATER=heater_bed TARGET=100.0
PID parameters for 100.00°C: pid_Kp=41.787 pid_Ki=1.235 pid_Kd=353.363
PID_PROFILE SAVE=100 HEATER=heater_bed
```

### dialing in the wristwatch2 rotation_distance

No need to RESTART - change the value via gcode command and test again

[Use a calculator](https://www.service-uplink.de/esteps_cal/calculator.php)


```text
SET_EXTRUDER_ROTATION_DISTANCE EXTRUDER=extruder DISTANCE=47.318708
```

## references

[ks]: <https://github.com/KlipperScreen/KlipperScreen> "KlipperScreen"
[is_theory]: <https://klipper.discourse.group/t/interpreting-the-input-shaper-graphs/9879> "Input Shaper Theory"
[shaketune]: <https://github.com/Frix-x/klippain-shaketune> "Klippain Shaketune Repo"

