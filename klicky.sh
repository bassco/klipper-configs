#!/usr/bin/bash

mkdir -p "${HOME}"/klipper_config/klicky
cd "${HOME}"/klipper_config || exit
echo "Adding or updating klicky macros"
curl -sSL -o klicky/bed-mesh-calibrate.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-bed-mesh-calibrate.cfg
curl -sSL -o klicky/macros.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-macros.cfg
curl -sSL -o klicky/quad-gantry-level.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-quad-gantry-level.cfg
curl -sSL -o klicky/screws-tilt-calculate.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-screws-tilt-calculate.cfg
curl -sSL -o klicky/specific.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-specific.cfg
curl -sSL -o klicky/z-tilt-adjust.cfg https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-z-tilt-adjust.cfg
VAR_SUFFIX=""
[ -f klicky/variables.cfg ] || { VAR_SUFFIX=".new"; }
curl -sSL -o "klicky/variables.cfg${VAR_SUFFIX}" https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-variables.cfg
VAR_PROBE=""
[ -f klicky-probe.cfg ] || { VAR_PROBE=".new"; }
curl -sSL -o "klicky-probe.cfg${VAR_PROBE}" https://raw.githubusercontent.com/jlas1/Klicky-Probe/main/Klipper_macros/klicky-probe.cfg

# shellcheck disable=SC2016
sed -i -E 's/(klicky)(-)/\1\//g;t;d' "klicky-probe.cfg${VAR_PEOBE}"

echo "Done - setup the variables and include klick-probe.cfg"
