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
cp $PWD/auto-epp.service /etc/systemd/system/
cp $PWD/auto-epp /home/$USERNAME/.local/bin

# Replace user directory in systemd service file
sed -i "s#ExecStart=/home/user/.local/bin/auto-epp#ExecStart=/home/$USERNAME/.local/bin/auto-epp#g" /etc/systemd/system/auto-epp.service
# Enable systemd service
systemctl enable --now auto-epp.service