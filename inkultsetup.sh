#!/bin/bash

export SUDO_ASKPASS=./zenitypass.sh

if [ "$CLI" == "0" ]
then

(
echo "# InKult Linux Setup"

echo "# erneure update/programm daten..."
pkexec apt update

echo "# installiere apt-fast (für schnellere downloads von programmen)"
pkexec sudo add-apt-repository -y ppa:apt-fast/stable
pkexec sudo apt install -y apt-fast

echo "# WINE setup"

echo "# bereite WINE (Windows app-support) vor..."
pkexec dpkg --add-architecture i386

echo "# installiere WINE schlüssel..."
wget -nc https://dl.winehq.org/wine-builds/winehq.key
pkexec apt-key add winehq.key
pkexec add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
echo "# installiere wine... (dies kann eine LANGE weile dauern dank unserem schnellem internet)"
pkexec apt-fast install --install-recommends winehq-devel
echo "Fertig!"

echo "# installiere git..."
pkexec apt-fast install git -y
echo "Fertig!"

if [ "$LITE" == "1" ]
then
echo "Dash To Dock Deaktiviert auf Lite"
echo "benutze stadtdessen 'Plank' als Dock"
else
echo "# installiere die Zorin-Dash erweiterung"
pkexec apt-fast install gnome-shell-extension-zorin-dash -y
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
gnome-extensions disable zorin-menu@zorinos.com -q
gnome-extensions disable zorin-taskbar@zorinos.com -q
dconf load /org/gnome/shell/extensions/zorin-dash/ < ./zorin-dash-conf
gnome-extensions enable zorin-dash@zorinos.com -q
fi

echo "*********************************************************"
echo "# installiere grapejuice (Roblox management und support)..."
echo "*********************************************************"
echo "# installiere abhängigkeiten..."
pkexec apt-fast install -y python3-pip python3-setuptools python3-wheel python3-dev pkg-config libcairo2-dev gtk-update-icon-cache desktop-file-utils xdg-utils libgirepository1.0-dev gir1.2-gtk-3.0
echo "# lade grapejuice herunter..."
wget -O- https://gitlab.com/brinkervii/grapejuice/-/raw/master/ci_scripts/signing_keys/public_key.gpg | gpg --dearmor > /tmp/grapejuice-archive-keyring.gpg
pkexec cp /tmp/grapejuice-archive-keyring.gpg /usr/share/keyrings/
rm /tmp/grapejuice-archive-keyring.gpg
pkexec tee /etc/apt/sources.list.d/grapejuice.list <<< 'deb [signed-by=/usr/share/keyrings/grapejuice-archive-keyring.gpg] https://brinkervii.gitlab.io/grapejuice/repositories/debian/ universal main' > /dev/null


echo "*******************************************"
echo "# installiere Minecraft (bedrock edition)...."
echo "*******************************************"
flatpak install io.mrarm.mcpelauncher -y
## echo "************************************"
## echo "# installiere Minecraft (Java edition)"
## echo "************************************"
## flatpak install com.mojang.minecraft -y
echo "**************************************************************"
echo "# installiere updates... (könnte was dauern, danke internet lol)"
echo "**************************************************************"
pkexec apt-fast dist-upgrade -y
) |
zenity --progress --pulsate --auto-close\
  --title="Setup" \
  --text="warten..." \
  --percentage=0

elif [ "$CLI" == "1" ]
then echo "# InKult Linux Setup"

echo "# erneure update/programm daten..."
sudo apt update

echo "# installiere apt-fast (für schnellere downloads von programmen)"
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt install -y apt-fast

echo "# WINE setup"

echo "# bereite WINE (Windows app-support) vor..."
sudo dpkg --add-architecture i386

echo "# installiere WINE schlüssel..."
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
echo "# installiere wine... (dies kann eine LANGE weile dauern dank unserem schnellem internet)"
sudo apt-fast install --install-recommends winehq-devel
echo "Fertig!"

echo "# installiere git..."
sudo apt-fast install git -y
echo "Fertig!"

echo "Dash To Dock Deaktiviert auf Lite"
echo "benutze stadtdessen 'Plank' als Dock"

if [ "$LITE" == "1" ]
then
echo "Dash To Dock Deaktiviert auf Lite"
echo "benutze stadtdessen 'Plank' als Dock"
else
echo "# installiere die Zorin-Dash erweiterung"
sudo apt-fast install gnome-shell-extension-zorin-dash -y
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
gnome-extensions disable zorin-menu@zorinos.com -q
gnome-extensions disable zorin-taskbar@zorinos.com -q
dconf load /org/gnome/shell/extensions/zorin-dash/ < ./zorin-dash-conf
gnome-extensions enable zorin-dash@zorinos.com -q
fi

echo "*********************************************************"
echo "# installiere grapejuice (Roblox management und support)..."
echo "*********************************************************"
echo "# installiere abhängigkeiten..."
sudo apt-fast install -y python3-pip python3-setuptools python3-wheel python3-dev pkg-config libcairo2-dev gtk-update-icon-cache desktop-file-utils xdg-utils libgirepository1.0-dev gir1.2-gtk-3.0
echo "# lade grapejuice herunter..."
wget -O- https://gitlab.com/brinkervii/grapejuice/-/raw/master/ci_scripts/signing_keys/public_key.gpg | gpg --dearmor > /tmp/grapejuice-archive-keyring.gpg
sudo cp /tmp/grapejuice-archive-keyring.gpg /usr/share/keyrings/
rm /tmp/grapejuice-archive-keyring.gpg
sudo tee /etc/apt/sources.list.d/grapejuice.list <<< 'deb [signed-by=/usr/share/keyrings/grapejuice-archive-keyring.gpg] https://brinkervii.gitlab.io/grapejuice/repositories/debian/ universal main' > /dev/null


echo "*******************************************"
echo "# installiere Minecraft (bedrock edition)...."
echo "*******************************************"
flatpak install io.mrarm.mcpelauncher -y
## echo "************************************"
## echo "# installiere Minecraft (Java edition)"
## echo "************************************"
## flatpak install com.mojang.minecraft -y
echo "**************************************************************"
echo "# installiere updates... (könnte was dauern, danke internet lol)"
echo "**************************************************************"
sudo apt-fast dist-upgrade -y

fi
