#!/bin/bash

### This is my personal setup script for Fedora-based distros

echo "1: Update the system packages:"
sudo dnf -y update

echo "2: Install default packages:"
sudo dnf -y install neovim fish git curl wget make powerline-fonts

echo "3: Install Visual Studio Code:"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y update
sudo dnf -y install code

echo "4: Install NVM tool:"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash

echo "5: Install Pyenv tool:"
rm -rf $HOME/.pyenv
curl https://pyenv.run | bash

echo "6: Install SdkMan tool:"
curl -s "https://get.sdkman.io" | bash

echo "7: Install Docker(Podman) engine:"
sudo dnf -y install podman

echo "8: Setting up git default profile:"
git config --global user.email ""
git config --global user.name ""
git config --global init.defaultBranch main

echo "9: Setting up the default fish settings:"
cp -r resources/fish/config $HOME/.config/fish

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

### NVIDIA
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda
sudo dnf install xorg-x11-drv-nvidia-power
sudo systemctl enable nvidia-{suspend,resume,hibernate}
sudo dnf install vulkan
sudo dnf install xorg-x11-drv-nvidia-cuda-libs
sudo dnf install nvidia-vaapi-driver libva-utils vdpauinfo

### configure fish shell
chsh -s /usr/bin/fish
fish resources/fish/setup.fish
