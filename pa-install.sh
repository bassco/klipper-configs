#!/usr/bin/bash

cd ~/dev
git clone https://github.com/ksanislo/klipper-pa_cal.git pa_cal
cd klipper-pa_cal
./install-pa_cal.sh

MR_CONFIG=~/klipper_config/moonraker.conf
sed -i -E 's/klipper-pa_cal/\/dev/pa_cal/g' "${MR_CONFIG}"
sed -i -E '/is_system_service/d' "${MR_CONFIG}"
sudo systemctl restart moonraker
