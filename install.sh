#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

DIR="/home/$USERNAME/.local/bin"

if [ ! -d "$DIR" ]; then
  echo "$DIRECTORY does not exist..."
  echo "Creating $DIR"
fi

# Copy files
cp $PWD/pp-to-amd-epp.service /etc/systemd/system/
cp $PWD/pp-to-amd-epp /home/$USERNAME/.local/bin

# Replace user directory in systemd service file
sed -i "s#ExecStart=/home/user/.local/bin/pp-to-amd-epp#ExecStart=/home/$USERNAME/.local/bin/pp-to-amd-epp#g" /etc/systemd/system/pp-to-amd-epp.service
# Enable systemd service
systemctl enable --now pp-to-amd-epp.service