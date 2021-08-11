#!/bin/bash

# Determine git user and email address
GIT_USERNAME="tomkiel"
GIT_EMAIL="regis@doseextra.com"

echo "####################"
echo "-> Configure git globally"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"
git config --global init.defaultBranch main

echo "####################"
echo "-> Generate ssh keys"
ssh-keygen -t ed25519 -C "$GIT_EMAIL"

echo "#####################"
echo "The scripts for configuring the GNU/Linux based operating system"

echo "#####################"
echo "-> Update Ubuntu packages"
sudo apt -y update

echo "#####################"
echo "-> Install packages for Ubuntu"
sudo apt -y install vim neovim fish powerline fonts-powerline libwebp-dev gtk2-engines-murrine python3-pip apt-transport-https neofetch
pip3 install pynvim
pip install --user powerline-status
pip install --user git+git://github.com/powerline/powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P /tmp/
mkdir -p $HOME/.local/share/fonts/
mv /tmp/PowerlineSymbols.otf $HOME/.local/share/fonts/
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P /tmp/
mkdir -p $HOME/.config/fontconfig/conf.d/
mv /tmp/10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/

echo "#####################"
echo "-> Install nvm (NPM/Node Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "#####################"
echo "-> Copy fish config"
mkdir -p $HOME/.config/fish/functions
cp fish/fedora_config.fish $HOME/.config/fish/config.fish
cp fish/functions/nvm.fish $HOME/.config/fish/functions/nvm.fish

echo "#####################"
echo "-> Configure neovim editor"
mkdir -p $HOME/.config/nvim/
cp nvim/init.vim $HOME/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "####################"
echo "-> Install JetBrains Toolbox"
wget https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.20.8352.tar.gz -P /tmp/
tar -zxvf /tmp/jetbrains-toolbox-1.20.8352.tar.gz --directory /tmp/
sudo mv /tmp/jetbrains-toolbox-1.20.8352 /opt/jetbrains-toolbox
sudo ln -s /opt/jetbrains-toolbox/jetbrains-toolbox /usr/bin/jetbrains-toolbox

echo "####################"
echo "-> Install Visual Studio Code"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt -y update
sudo apt -y install code

echo "####################"
echo "-> Configure Visual Studio Code"
git clone https://gist.github.com/81b9df6183d85b65cbc2e572df6e4e13.git /tmp/vscode-settings/
mkdir -p $HOME/.config/Code/User/
mv /tmp/vscode-settings/~/VSCode\ Settings $HOME/.config/Code/User/settings.json
git clone https://gist.github.com/b191d5341839aa9b63d48f9514d09d45.git /tmp/vscode-extensions/
echo "-> Install Visual Studio Extensions"

EXTENSIONS_FILE="/tmp/vscode-extensions/vscode-extensions"
EXTENSIONS_LINES=`cat $EXTENSIONS_FILE`
for extension in $EXTENSIONS_LINES; do
    echo " * Install $extension"
    code --install-extension $extension
    echo "done..."
    echo ""
done

echo "####################"
echo "-> Install Telegram Desktop"
wget https://updates.tdesktop.com/tlinux/tsetup.2.7.4.tar.xz -P /tmp/
tar -xvf /tmp/tsetup.2.7.4.tar.xz --directory /tmp/
sudo mv /tmp/Telegram /opt/

echo "#####################"
echo "-> Install and configure Gradle (Java)"
wget https://services.gradle.org/distributions/gradle-6.8.3-bin.zip -P /tmp/
unzip /tmp/gradle-6.8.3-bin.zip  -d /tmp/
sudo mv /tmp/gradle-6.8.3 /opt/gradle

echo "####################"
echo "-> Install Android Studio"
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.2.1.0/android-studio-ide-202.7351085-linux.tar.gz -P /tmp/
tar -zxvf /tmp/android-studio-ide-202.7351085-linux.tar.gz --directory /tmp/
sudo mv /tmp/android-studio /opt/

echo "####################"
echo "-> Install v4l2loopback"
sudo apt -y install v4l2loopback-dkms

echo "####################"
echo "-> Install and configure Iriun Webcam"
sudo apt -y install qt5-default
wget https://iriun.gitlab.io/iriunwebcam-2.4.1.deb -P /tmp/
sudo dpkg -i /tmp/iriunwebcam-2.4.1.deb
sudo modprobe v4l2loopback exclusive_caps=1

echo "####################"
echo "-> Install Docker Engine and Docker Composer"
sudo apt -y apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt -y update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo usermod -G docker -a $USER

echo "####################"
echo "-> Install and configure OBS Studio"
sudo apt -y install obs-studio
mkdir -p $HOME/.config/obs-studio/plugins
wget https://github.com/bazukas/obs-linuxbrowser/releases/download/0.6.1/linuxbrowser0.6.1-obs23.0.2-64bit.tgz -P /tmp/
tar -zxvf /tmp/linuxbrowser0.6.1-obs23.0.2-64bit.tgz -C $HOME/.config/obs-studio/plugins/

echo "####################"
echo "-> Install Microsoft Teams"
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.13653_amd64.deb -P /tmp/
sudo dpkg -i /tmp/teams_1.4.00.13653_amd64.deb

echo "####################"
echo "-> Configure user ambient"
echo " * Create Project path"
mkdir $HOME/Projects
echo " * Configure face (User image)"
cp user/face.jpg $HOME/.face
cp user/face.jpg $HOME/Pictures/me.jpg
echo " * Copy Tela icon theme"
cp -r user/icons $HOME/.icons
echo " * Copy gtk themes"
cp -r user/themes $HOME/.themes
echo " * Copy Wallpappers"
cp -r user/Wallpapers $HOME/Pictures/Wallpapers
echo " * Copy users fonts"
cp -r user/fonts $HOME/.fonts
echo " * Copy OBS overlays"
cp -r user/obs $HOME/Pictures/obs
echo " * Copy GTK3 settings"
cp -r user/gtk3/* $HOME/.config/gtk-3.0/
echo " * Copy Gnome-shell extensions"
cp -r user/gnome-shell/extensions/* $HOME/.local/share/gnome-shell/extensions/*
echo " * Set window controls to the left (the correct location ;) )"
gsettings set  org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
echo " * Set default theme"
gsettings set org.gnome.desktop.interface gtk-theme "Ant"
echo " * Set default window theme"
gsettings set org.gnome.desktop.wm.preferences theme "Ant"
echo " * Set default icon theme"
gsettings set org.gnome.desktop.interface icon-theme "Tela"
echo " * Set background"
gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/Pictures/Wallpapers/alex-robert-sbwuDopIUPI-unsplash.jpg"

echo "####################"
echo "-> Configure .webp files"
sudo cp -r thumbnail/* /usr/share/thumbnailers
rm -rf $HOME/.cache/thumbnails/*


echo "####################"
echo "-> Install desktop apps"
sudo apt -y install gnome-tweaks gimp audacity inkscape


echo "#####################"
echo "All done!"
echo "Run ./fish_config.sh in the fish shell"
fish source $HOME/.config/fish/config.fish
