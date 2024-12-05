#!/bin/bash

### This is my personal setup script for Ubuntu based distros

echo "1: Update the system packages:"
sudo apt -y update && sudo apt upgrade -y

echo "2: Install default packages:"
sudo apt -y install neovim fish git curl wget make fonts-powerline

echo "3: Install Visual Studio Code:"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt -y update
sudo apt -y install code

echo "4: Install NVM tool:"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash

echo "5: Install Pyenv tool:"
rm -rf $HOME/.pyenv
curl https://pyenv.run | bash

echo "6: Install SdkMan tool:"
curl -s "https://get.sdkman.io" | bash

echo "7: Install Docker(Podman) engine:"
sudo apt -y install podman

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

### configure fish shell
chsh -s /usr/bin/fish
fish resources/fish/setup.fish


