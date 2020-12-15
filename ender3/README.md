# Ender 3 - Micro-Swiss DDE and Triangle Labs 3:1 extruder motor


Standard Ender 3 with the following changes:
- BTT Ender Mini E3 v1.0 board
- BLTouch for Z endstop
- 3 point bed level plate
- Micro-Swiss DDE 
- TriangleLab 3:2 Extruder Geared Stepper Motor
- Energetic Spring Steel Smooth PEI printing plate

## Mecahnical Alignment

Used this video for X-Gantry

## Klipper firmware

The BTT Ender Mini 3 v1.0 board has an STMF103 72MHz chipset.

Attached `.config` has requires some special config which is attached here.

Copy the `.config` file and `make` to create the firmware.

The `make flash /dev/....` does not work for this chipset/board.

Copy `out/klipper.bin` to the SDcard as `firmware.bin` and start the machine.

## Klipper printer.cfg 

Upload the printer.cfg file to the Pi.

Restart the klipper software in the fluidd UI.


