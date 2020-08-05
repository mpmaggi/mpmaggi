# mpmaggi's setup config on Fedora
# last update on August 4, 2020

# Java JDK 11 must be downloaded from Oracle Website
# https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
# sudo tar -cxzf jdk.tar.gz -C /usr/local/bin
# cd /usr/local/bin/jdk-11.0.8/
# sudo alternatives --install /usr/bin/java java /usr/local/bin/jdk-11-0-8/bin/java 2
# sudo alternatives --config java
# java -version

# Gnome Settings
# Backup with dconf dump /org/gnome > dconf-settings.ini
dnf install dump -y
dconf load /org/gnome/ < dconf-settings.ini

# Google Chrome
dnf install fedora-workstation-repositories -y
dnf config-manager --set-enabled google-chrome
dnf install google-chrome-stable -y

# Notepadqq
dnf install notepadqq -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf check-update
sudo dnf install code

# Terminator
dnf install terminator -y

# NodeJs
dnf install -y nodejs npm
./nvm-install.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Docker (Fedora 32)
sudo dnf -y install dnf-plugins-core
sudo tee /etc/yum.repos.d/docker-ce.repo<<EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/31/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF

sudo dnf makecache
sudo dnf install docker-ce docker-ce-cli containerd.io -y
sudo systemctl enable --now docker

sudo usermod -aG docker $(whoami)
newgrp docker
