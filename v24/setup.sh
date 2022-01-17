cd ~/ || exit
mkdir ~/.ssh
echo "[Enter] to fix the sudo access for the pi user"
read -r foo
sudo visudo /etc/sudoers.d/010_pi-nopasswd
echo "[Enter] to fix the annoying bell"
read -r foo
sudo vi /etc/inputrc
echo "Setup ssh"
sudo mv /boot/authorized_hosts .ssh/
chmod 700 ~/.ssh
chmod 0600 .ssh/authorized_hosts
mkdir ~/dev
cd ~/dev
echo "[Enter] to set hostname, timezone and update the tool"
sudo raspi-config
sudo apt update
sudo apt-get install -y vim
git clone git@github.com:bassco/klipper-configs.git
git config --global user.name "Andrew Basson"
git config --global user.email "andrew.basson@gmail.com"
cd ~/
sudo systemctl stop klipper
mv klipper_config klipper_config_orig
ln -sf dev/klipper-configs/v24 klipper_config
# copy the gcode shell command 
curl -sSL -o ~/klipper/klippy/extras/gcode_shell_command.py  https://raw.githubusercontent.com/th33xitus
/kiauh/master/resources/gcode_shell_command.py
chmod +x ~/klipper/klippy/extras/gcode_shell_command.py
# copy the github backup script
# would be nice to add the github commit to the "save" button in the UI
sudo systemctl start klipper
echo "ready...."
echo "sudo systemctl start klipper"
echo "at your convenience"
