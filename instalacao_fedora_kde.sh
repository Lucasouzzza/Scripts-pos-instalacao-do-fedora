#!/bin/bash

# Para versao com KDE plasma
# Use no terminal: bash instalacao_fedora_kde.sh

# Atualizando o sistema
sudo dnf upgrade -y

# Instalando pacotes essenciais
sudo dnf install -y timeshift podman-docker plymouth-theme-breeze gwenview rclone-browser transmission-qt vlc okular ksystemlog kamoso korganizer kcalc appimagelauncher gimp

# Removendo pacotes desnecessarios
sudo dnf remove plasma-thunderbolt gnome-disk-utility  gnome-abrt

# Cockpit
sudo dnf install cockpit

# virtualizacao
sudo dnf install qemu libvirt virt-manager
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent

# setar o theme plymouth do kde plasma
sudo plymouth-set-default-theme breeze -R

# Corrigindo fontes embacadas
sudo mkdir -p /etc/environment.d/  
echo 'QT_NO_SYNTHESIZED_BOLD=1' | sudo tee -a /etc/environment.d/QT_FLAGS.conf

# Liberar porta kde connect no firewall
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --reload 

# Esconder menu grub
sudo grub2-editenv - set menu_auto_hide=1 

# Corrigir logs (corrige bug no kde plasma referente ao aviso de erros)
getfacl /var/log/boot.log

# Configurando idioma para Portugues
sudo dnf install -y system-config-language

# Adicionando repositorios RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

# Adicionando repositorio flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalando codecs multimidia
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install -y amrnb amrwb faad2 flac gpac-libs lame libde265 libfc14audiodecoder mencoder x264 x265

# Ativando a aceleracao por hardware (opcional)
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686

# Suporte para arquivos compactados
sudo dnf install -y cabextract lzip p7zip p7zip-plugins unrar

# Instalando fontes da Microsoft
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo dnf install -y https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Instalando pacotes Flatpak
flatpak install -y flathub org.onlyoffice.desktopeditors org.inkscape.Inkscape org.kde.kolourpaint com.vscodium.codium com.rtosta.zapzap org.mozilla.Thunderbird

# Instalando Anki
wget https://github.com/ankitects/anki/releases/download/25.02.7/anki-25.02.7-linux-qt6.tar.zst
# Descompactando o arquivo .zst
unzstd anki-25.02.7-linux-qt6.tar.zst  # Descompacta o arquivo .zst para .tar
# Extraindo o arquivo .tar
tar -xf anki-25.02.7-linux-qt6.tar
cd anki-25.02.7-linux-qt6
chmod +x install.sh  # Garante permissao de execucao ao instalador
sudo ./install.sh || echo "A instalacao do Anki falhou."
cd ..
rm -rf anki-25.02.7-linux-qt6 anki-25.02.7-linux-qt6.tar.zst  # Remove a pasta e o arquivo apos a instalacao

# Reiniciando o sistema
sudo reboot
