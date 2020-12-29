# klipper-configs

klipper 3d printer configs for the machines that I run

- [Ender3](ender3/README.md)
- [Kossel](kossel/LPC.md)

## Start GCODE
 ### ideaMaker template
```code
G21        ;metric values
G90        ;absolute positioning
M107       ;start with the fan off
M82

G28   ;move to endstops
M140 S{temperature_heatbed}
M104 S170 T0
M190 S{temperature_heatbed}
G29 ; measure the mesh
G1 Z75 F2000
M109 S{temperature_extruder1}

G92 E0
;G1 Z0.2 F400
;G1 X60 Y-2 F800
;G1 X140 Y-2 E12 F200
;G1 Z5 E15 F200
;G92 E0
G1 F{travel_xy_speed}
M117 Printing...
```

## End GCODE

### ideaMaker template

```code
M400      ;Free buffer
G91      ;relative positioning
G1 E-1 F300      ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 F{speed_travel} Z+1 E-5        ;move Z up a bit and retract filament even more
G90      ;absolute positioning
M104 S0      ;extruder heater off
M140 S0      ;heated bed heater off
M107      ;fan off

G28      ;move to endstop
M84      ;steppers off
```