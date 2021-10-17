# Switchwire

SKR1.3 board with TMC2209 drivers
Raspberry Pi 3B
fluiddpi image and interface
klipper 0.10.x
24v 50W TL heater
Dragon SF Hotend
LDO motor and bed kit
Robotdigg Rails
Fiberlogy ABS+ parts printed on the Prusa Mini
Rexroth Frame
Meanwell LRS 200 and 25 PSUs
FYSECT Mini 12864 display

## TODO

* rack the gantry to the bed
* tighten X and Z belts
* check y belt tension
* check X endstop - going in the correct direction now 
* check Z probe - stays TRIGGERED - even when a magnet is brought close to it
* PID tune heater and bed
* Check fan connections - Part vs Hotend Cooling

## To fix

[fysetc mini 12864 display](https://wiki.fysetc.com/Manual_for_Mini_panel_on_SKR/) needs to be fixed.

To get the display to work you need to reverse one side of the connectors. Easiest option is to lift both black plastic ribbon cable holders with the keyed slot on the rear side of the display with a small screwdriver upwards by wiggling and lifting slowly at both sides. Once the holder is off turn it 180 degrees and relocate by carefully pressing downwards. Do this for Exp1 and Exp2. Enjoy the new display and functions.

## DONE

* STEPPER_BUZZ for x, y and z - successful
* Fixed direction pins for x, y and z motors
* Tested X and Y endstops
* G28 Y is successful

## Fixed

Bad firmware flash by not selecting `Use SMOOTHIEWARE BOOTLOADER` caused the USB port to be disabled. Need to reset the board button twice for the new FIRMWARE.BIN to be written to flash. Also formatted the SDCARD to FAT32 for good measure.
