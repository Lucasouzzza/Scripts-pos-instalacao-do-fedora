#!/bin/bash

# Para versao com gnome
# Use no terminal: bash instalacao_fedora.sh

# Instalando pacotes essenciais
sudo dnf install -y btrfs-assistant gnome-tweaks adw-gtk3-theme podman-docker

# Para extencoes
sudo dnf install -y libgda libgda-sqlite openssl nautilus-python nautilus-extensions evolution-data-server

# Removendo pacotes indesejados
sudo dnf remove -y rhythmbox

# Atualizando o sistema
sudo dnf upgrade -y

# Configurando idioma para Portugues
sudo dnf install -y system-config-language

# Adicionando repositorios RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

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
sudo dnf install cabextract lzip p7zip p7zip-plugins unrar

# Instalando fontes da Microsoft
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo dnf install -y https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Instalando pacotes Flatpak
flatpak install -y flathub com.github.marhkb.Pods de.haeckerfelix.Fragments org.gnome.DejaDup org.gimp.GIMP com.mattjakeman.ExtensionManager org.gnome.Geary org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

# Instalando tema para o Firefox
git clone https://github.com/rafaelmardojai/firefox-gnome-theme.git
cd firefox-gnome-theme
chmod +x ./scripts/auto-install.sh
./scripts/auto-install.sh || echo "A instalacao automatica do tema do Firefox falhou."
cd ..
rm -rf firefox-gnome-theme  # Remove a pasta apos a instalacao

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
