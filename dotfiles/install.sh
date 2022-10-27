#!/bin/bash

echo "Upgrading apt:"
sudo apt-get update -y && sudo apt-get upgrade -y

echo "Installing login manager:"
sudo apt-get install lightdm -y

echo "Installing display manager:"
sudo apt-get install xorg -y

echo "Installing Git:"
sudo apt-get install git -y

echo "Installing Zsh..."
sudo apt-get install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Custom theme "Headline"
(
  cd ~/.oh-my-zsh/themes/
  wget https://raw.githubusercontent.com/moarram/headline/main/headline.zsh-theme
)

echo "Installing Picom:"
#Installing dependencies
sudo apt-get install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
#Build from source
git clone https://github.com/yshui/picom
(
  cd picom
  git submodule update --init --recursive
  sudo meson --buildtype=release . build
  sudo ninja -C build
  sudo ninja -C build install
)

echo "Installing fff:"
git clone https://github.com/dylanaraps/fff
(
  cd fff
  sudo make install
)

echo "Installing Qtile:"
sudo apt-get install python3 libpangocairo-1.0-0 python3-pip python3-xcffib python3-cairocffi -y
sudo pip install qtile

echo "Installing Alacritty:"
sudo apt-get install cmake curl libfontconfig1-dev cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev desktop-file-utils -y
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
git clone https://github.com/alacritty/alacritty
(
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
  mkdir -p "${ZDOTDIR:-~}/.zsh_functions"
  echo "fpath+=${ZDOTDIR:-~}/.zsh_functions" >> "${ZDOTDIR:-~}/.zshrc"
  cp extra/completions/_alacritty "${ZDOTDIR:-~}/.zsh_functions/_alacritty"
  echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
  mkdir -p ~/.bash_completion
  cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
  echo "source ~/.bash_completion/alacritty" >> ~/.bashrc
)

echo "Installing Helix:"
git clone https://github.com/helix-editor/helix
(
  cd helix
  cargo install --path helix-term
)

echo "Installing Eww:"
sudo apt-get install libglib2.0-dev libpango1.0-dev libgtk-3-dev -y
git clone https://github.com/elkowar/eww
(
  cd eww
  cargo build --release
  sudo chmod +x ./eww
  sudo cp ./target/release/eww /usr/local/bin/
)

echo "Installing Nerd Font:"
sudo apt-get install unzip -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/ProFont.zip
unzip ProFont.zip -d ProFont
sudo cp -r ./ProFont ~/.local/share/fonts/
fc-cache -fv
