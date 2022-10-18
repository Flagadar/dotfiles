#!/bin/bash/

# - Debian Post Installation Script
sudo apt update -y
sudo apt upgrade -y

# - Display Server & Display Manager
sudo apt install xorg lightdm -y

# - Picom (to build, apt version too old)
# Install dependencies
sudo apt install git libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
# Build / Install
sudo git clone https://github.com/yshui/picom
cd picom
sudo git submodule update --init --recursive
sudo meson --buildtype=release . build
sudo ninja -C build install
cd ..

# - Qtile
sudo apt install python3 -y
sudo apt install libpangocairo-1.0-0 -y
sudo apt install python3-pip python3-xcffib python3-cairocffi -y
sudo pip install qtile
# Qtile extras
sudo git clone https://github.com/elParaguayo/qtile-extras
cd qtile-extras
sudo python3 ./setup.py
cd ..
