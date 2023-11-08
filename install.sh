#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

DIR="/usr/local/bin"

if [ ! -d "$DIR" ]; then
  echo "$DIRECTORY does not exist..."
  echo "Creating $DIR"
  mkdir -p $DIR
fi

# Copy files
cp $PWD/pp-to-amd-epp.service /etc/systemd/system/
cp $PWD/pp-to-amd-epp /usr/local/bin

# Set permissions
chown root:root /usr/local/bin/pp-to-amd-epp /etc/systemd/system/pp-to-amd-epp.service
chmod 655 /usr/local/bin/pp-to-amd-epp /etc/systemd/system/pp-to-amd-epp.service
chmod +x /usr/local/bin/pp-to-amd-epp

# Enable systemd service
systemctl enable --now pp-to-amd-epp.service
