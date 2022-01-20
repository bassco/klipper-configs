#!/usr/bin/env bash

PRINTER="$1:?'Please provide a printer to install'"
KLIPPER_CONFIGS=~/dev/klipper-configs
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
git config --global push.gpgsign false # Per Linus Torvalds
git config --global user.signingKey 1F373F5E34F9AD64DA773061EE3C12CD162C7F66!
git config --global alias.logs "log --show-signature"


sudo systemctl stop klipper
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
ln -sf $KLIPPER_CONFIGS/update-mcu
cd ~/
ln -sf $KLIPPER_CONFIGS/.bash_aliases
PRINTER_SRC="$HOME/dev/klipper-configs/$PRINTER"
if [ -d "$PRINTER_SRC" ]; then
  mv klipper_config .klipper_config
  ln -sf "$PRINTER_SRC" klipper_config
  ln -sf "$PRINTER_SRC/.bash_aliases_extras" || true
  ~/bin/update-mcu
  echo "ready...."
else 
  echo "Printer($PRINTER) setup not found"
  echo "Leaving defaults and klipper stopped"
fi
cd ~
