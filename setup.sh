#!/usr/bin/env bash

PRINTER="$1:?'Please provide a printer to install'"
cd ~/
echo "[Enter] to fix the sudo access for the pi user"
read -r foo
sudo visudo /etc/sudoers.d/010_pi-nopasswd
echo "[Enter] to fix the annoying bell"
read -r foo
sudo vi /etc/inputrc
echo "Setup ssh"
mkdir ~/.ssh || true
sudo mv /boot/authourized_hosts.txt .ssh/authorized_hosts
chmod 700 ~/.ssh
chmod 0600 .ssh/authourized_hosts
echo "[Enter] to set hostname, timezone and update the tool"
sudo raspi-config
sudo apt update
sudo apt get upgrade
~/klippy-env/bin/pip install -v numpy
sudo apt install -y vim python-numpy python-matplotlib

mkdir ~/dev
cd ~/dev
git clone git@github.com:bassco/klipper-configs.git
git config --global user.name "Andrew Basson"
git config --global user.email "andrew.basson@gmail.com"
git config --global commit.gpgsign false # Per Linus Torvalds
git config --global push.gpgsign true # Per Linus Torvalds
git config --global user.signingKey 1F373F5E34F9AD64DA773061EE3C12CD162C7F66!
git config --global alias.logs "log --show-signature"

cd ~/
mv klipper_config .klipper_config

sudo systemctl stop klipper
ln -sf "$HOME/dev/klipper-configs/$PRINTER" klipper_config
# copy the gcode shell command
curl -sSL -o ~/klipper/klippy/extras/gcode_shell_command.py  https://raw.githubusercontent.com/th33xitus/kiauh/master/resources/gcode_shell_command.py
chmod +x ~/klipper/klippy/extras/gcode_shell_command.py
# copy the github backup script
# would be nice to add the github commit to the "save" button in the UI
#sudo systemctl start klipper
cd ~/klipper
git pull
mkdir ~/bin
cd ~/bin
ln -sf ~/dev/klipper_configs/update-mcu
./update-mcu
echo "ready...."
cd ~