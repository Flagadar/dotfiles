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
sudo python3 setup.py install
cd ..

# - Alacritty
sudo apt install cmake curl libfontconfig1-dev cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
git clone https://github.com/alacritty/alacritty
cd alacritty
cargo build --release --no-default-features --features=x11
infocmp alacritty
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
mkdir -p ~/.bash_completion
cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
echo "source ~/.bash_completion/alacritty" >> ~/.bashrc
cd ..

# - Helix
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term
cd ..

# - Copy config files
sudo mkdir ~/.config
sudo cp -r ./config/* ~/.config/
sudo chmod +x ~/.config/qtile/autostart.sh
# Copy .desktop to Xsessions
sudo mkdir /usr/share/xsessions
sudo cp ./qtile.desktop /usr/share/xsessions
