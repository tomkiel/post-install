#!/bin/bash

### This is my personal setup script for Fedora Silverblue/Kinoite

echo "1: Update the system packages:"
sudo rpm-ostree upgrade

echo "2: Install default packages:"
sudo rpm-ostree install neovim fish git curl wget make powerline-fonts

echo "3: Install Visual Studio Code:"
sudo rpm-ostree install https://packages.microsoft.com/yumrepos/vscode/code-*.rpm

echo "4: Install NVM tool:"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash

echo "5: Install Pyenv tool:"
rm -rf $HOME/.pyenv
curl https://pyenv.run | bash

echo "6: Install SdkMan tool:"
curl -s "https://get.sdkman.io" | bash

echo "7: Install Docker(Podman) engine:"
sudo rpm-ostree install podman

echo "8: Setting up git default profile:"
git config --global user.email ""
git config --global user.name ""
git config --global init.defaultBranch main

echo "9: Setting up the default fish settings:"
mkdir -p $HOME/.config/fish
cp -r resources/fish/config/* $HOME/.config/fish/

echo "10: Configure the environment:"
### webp thumbnail
sudo cp -r resources/thumbnail/* /usr/share/thumbnailers

### dir colors
wget -O $HOME/.dir_colors https://raw.github.com/seebi/dircolors-solarized/master/dircolors.ansi-dark 

### vs-code settings and extensions
mkdir -p $HOME/.config/Code/User
cp resources/code/settings.json $HOME/.config/Code/User/

### vs-code extensions
EXTENSIONS_FROM_FILE=$(cat "./resources/code/extensions.txt")
for EXT in $EXTENSIONS_FROM_FILE; do
    code --install-extension $EXT
done

### RPM fusion
sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### Codecs
rpm-ostree install gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi
rpm-ostree override remove libavcodec-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free --install ffmpeg

### NVIDIA
sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda
sudo rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
sudo rpm-ostree install libva-nvidia-driver

### configure fish shell
chsh -s /usr/bin/fish
fish resources/fish/setup.fish

echo "Reboot is required to apply changes due to rpm-ostree"
