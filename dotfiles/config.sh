#!/bin/bash

echo "Copying configuration files..."
sudo mkdir ~/.config
sudo cp -r ./dotfiles/config/* ~/.config/
sudo chmod +x ~/.config/qtile/scripts/autostart.sh

# Copy .desktop to Xsessions
sudo mkdir /usr/share/xsessions
sudo cp ./qtile.desktop /usr/share/xsessions