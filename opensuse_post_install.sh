#!/bin/bash

# Determine git user and email address
GIT_USERNAME=""
GIT_EMAIL=""

echo "#####################"
echo "The scripts for configuring the GNU/Linux based operating system"
sudo zypper -n update

echo "#####################"
echo "-> Install packages for openSUSE"
sudo zypper install -n vim neovim fish powerline powerline-fonts java-11-openjdk maven alien neofetch
pip3 install pynvim
pip install --user powerline-status
pip install --user git+git://github.com/powerline/powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P /tmp/
mv /tmp/PowerlineSymbols.otf $HOME/.local/share/fonts/
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P /tmp/
mkdir $HOME/.config/fontconfig/conf.d/
mv /tmp/10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/

echo "#####################"
echo "-> Install nvm (NPM/Node Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "#####################"
echo "-> Copy fish config"
cp fish/config.fish $HOME/.config/fish/config.fish
cp fish/functions/nvm.fish $HOME/.config/fish/functions/nvm.fish
fish source $HOME/.config/fish/config.fish

echo "#####################"
echo "-> Install Oh My Fish Shell"
curl -L https://get.oh-my.fish | fish

echo "#####################"
echo "-> Configure fish shell"
omf update
omf install agnoster
omf install bass

echo "#####################"
echo "-> Configure neovim editor"
cp nvim/init.vim $HOME/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "#####################"
echo "-> Install and configure Gradle (Java)"
GRADLE_VERSION=6.8.3
wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -P /tmp/
unzip /tmp/gradle-$GRADLE_VERSION-bin.zip  -d /tmp/
sudo mv /tmp/gradle-$GRADLE_VERSION-bin /opt/gradle


echo "####################"
echo "-> Configure git globally"
GIT_USERNAME=""
GIT_EMAIL=""
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"
git config --global init.defaultBranch main

echo "####################"
echo "-> Generate ssh keys"
ssh-keygen -t ed25519 -C "$GIT_EMAIL"

echo "####################"
echo "-> Install JetBrains Toolbox"
wget https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.20.8352.tar.gz -P /tmp/
tar -zxvf /tmp/jetbrains-toolbox-1.20.8352.tar.gz --directory /tmp/
sudo mv /tmp/jetbrains-toolbox-1.20.8352 /opt/jetbrains-toolbox
sudo ln -s /opt/jetbrains-toolbox/jetbrains-toolbox /usr/bin/jetbrains-toolbox

echo "####################"
echo "-> Install Visual Studio Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\\nname=Visual Studio Code\\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\\nenabled=1\\ntype=rpm-md\\ngpgcheck=1\\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
sudo zypper -n refresh
sudo zypper install -n code

echo "####################"
echo "-> Configure Visual Studio Code"
git clone https://gist.github.com/81b9df6183d85b65cbc2e572df6e4e13.git /tmp/vscode-settings/
mv /tmp/vscode-settings/VSCode\ Settings $HOME/.config/Code/User/settings.json
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
echo "-> Install Android Studio"
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.2.1.0/android-studio-ide-202.7351085-linux.tar.gz -P /tmp/
tar -zxvf /tmp/android-studio-ide-202.7351085-linux.tar.gz --directory /tmp/
sudo mv /tmp/android-studio /opt/

echo "####################"
echo "-> Install Telegram Desktop"
wget https://updates.tdesktop.com/tlinux/tsetup.2.7.4.tar.xz -P /tmp/
tar -zxvf /tmp/tsetup.2.7.4.tar.xz --directory /tmp/
sudo mv tsetup.2.7.4/Telegram /opt/

echo "####################"
echo "-> Install and configure Iriun Webcam"
sudo zypper install -n v4l2loopback-kmp-default
wget http://iriun.gitlab.io/iriunwebcam-2.3.1.deb -P /tmp/
sudo alien -r /tmp/iriunwebcam-2.3.1.deb --target=x86_64
sudo zypper in -n /tmp/iriunwebcam-2.2-2.x86_64.rpm
sudo modprobe v4l2loopback exclusive_caps=1

echo "####################"
echo "-> Install Docker Engine and Docker Composer"
sudo dnf -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose
sudo systemctl enable docker
sudo usermod -G docker -a $USER

echo "####################"
echo "-> Install and configure OBS Studio"
echo " * Enable RPM Fusion"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install obs-studio
sudo dnf -y install xorg-x11-drv-nvidia-cuda
mkdir -p $HOME/.config/obs-studio/plugins
wget https://github.com/bazukas/obs-linuxbrowser/releases/download/0.6.1/linuxbrowser0.6.1-obs23.0.2-64bit.tgz -P /tmp/
tar -zxvf /tmp/linuxbrowser0.6.1-obs23.0.2-64bit.tgz -C $HOME/.config/obs-studio/plugins/

echo "####################"
echo "-> Install Microsoft Teams"
wget https://packages.microsoft.com/yumrepos/ms-teams/teams-1.4.00.7556-1.x86_64.rpm /tmp/
sudo dnf -y localinstall /tmp/teams-1.4.00.7556-1.x86_64.rpm

echo "####################"
echo "-> Configure user informations"
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
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-light"
echo " * Set default window theme"
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-light"
echo " * Set default icon theme"
gsettings set org.gnome.desktop.interface icon-theme "Tela"
echo " * Set background"
gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/Pictures/Wallpapers/alex-robert-sbwuDopIUPI-unsplash.jpg"


echo "####################"
echo "-> Install desktop apps"
echo " * Evolution Email Client"
sudo zypper in -n evolution
echo " * GIMP, Audacity and Inkscape"
sudo zypper in -n install gimp audacity inkscape


