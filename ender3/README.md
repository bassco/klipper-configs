# Ender 3 - Micro-Swiss DDE and Triangle Labs 3:1 extruder motor


Standard Ender 3 with the following changes:
- BTT Ender Mini E3 v1.0 board
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

## Commisioning

### PID Tuning

*
*

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
