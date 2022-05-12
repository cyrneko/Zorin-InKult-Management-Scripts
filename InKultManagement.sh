#!/bin/bash

# Ansi color code variables
# shellcheck disable=SC2034
red="\e[0;91m"
# shellcheck disable=SC2034
blue="\e[0;94m"
# shellcheck disable=SC2034
green="\e[0;92m"
# shellcheck disable=SC2034
white="\e[0;97m"
# shellcheck disable=SC2034
bold="\e[1m"
# shellcheck disable=SC2034
uline="\e[4m"
# shellcheck disable=SC2034
reset="\e[0m"

popupdate() {
	read -r -p "${red}Are you sure you want to run pop-system-upgrade?${reset}" yn
	case $yn in
		[yY] )
			echo -e "${green}Performing full release upgrade...${reset}"
			pop-upgrade release upgrade
			echo -e "${red}Rebooting in 5 seconds...${reset}"
			sleep 5s; systemctl -i reboot
			;;
		[nN] )
			echo "${red}Aborting system update!${reset}"
			exit 1
			;;
	esac
}

bigtext() {
   if [ "$(which figlet)" == "/usr/bin/figlet" ] && [ "$(lsb_release -sr)" != "22.04" ]; then
      figlet "InKultManagement"
   else
      echo -e "${bold}${uline}InKultManagement${reset}"
   fi
}

restartpulseaudio() {
   systemctl --user restart pulseaudio
   echo -e "${green}PulseAudio restarted!${reset}"
}

restartpipewire() {
   systemctl --user restart pipewire pipewire-pulse || echo -e "${red}Restarting Failed!${reset}"
}

bottles() {
   echo -e "${green}Installing Bottles through Flatpak..."
   flatpak install com.usebottles.bottles
   echo -e "${green}Bottles Installed! Launch it from the Menu or the Search"
}

lutris() {
   echo -e "${green}Installing Lutris..."
   sudo add-apt-repository ppa:lutris-team/lutris
   sudo apt update
   sudo apt install lutris
   echo -e "${green}Lutris Installed! Launch it from the Menu or the Search"
}

help() {
   clear
   echo -e "${red}bigtext${reset}"
   # echo -e "${red}$(figlet "InKult Management")"  ← this thing is old
   echo "This script sets up Zorin installations at the InKult Youth Center in Germany."
   echo -e "${reset}------------"
   echo -e "${blue}${bold}${uline}Syntax${reset}: $0 [Options]"
   echo ""
   echo -e "${red}No Options = GUI${reset}"
   echo ""
   echo -e "${blue}${bold}${uline}Available options:${reset}"
   echo -e "$0 -h             ${green}shows a help page for this script${reset}"
   echo -e "$0 -g             ${green}shows a GUI to do different actions${reset}"
   echo -e "$0 -a             ${green}runs apt-fast for accelerated system updates${reset}"
   echo -e "$0 -pw            ${green}restarts PipeWire (Audio Server)${reset}"
   echo -e "$0 -pa            ${green}restarts PulseAudio (Audio Server, default, but older)${reset}"
   echo -e "$0 -b             ${green}installs bottles from Flathub${reset}"
   echo -e "$0 -l             ${green}installs the Lutris game manager${reset}"
   echo -e "$0 -pu            ${green}runs Pop!_OS updates"
   echo "------------"
   exit
}

apt-fast-upgrade () {
   echo -e "${red}starting...${reset}"
   pkexec apt-fast upgrade -y
   echo -e "${green}Finished!${reset}"
}

gui() {
   printf ""
   echo "The UI has been deprecated for various reasons, it might return in the future in a more managable form from a development standpoint."
}

# gui() {
#   ask=$(zenity --list --title="Management Options" --column="0" --width=300 --height=300 --hide-header "Restart-Pipewire" "Restart-PulseAudio" "Do-accelerated-updates" "Install-Bottles" "Install-Lutris")
#   case $ask in
#      Restart-Pipewire)
#         pipewire | zenity --progress --auto-close --pulsate --title="Restarting Pipewire..." --text="Make sure audio devices are plugged in BEFORE running this, otherwise it may not work."
#         ;;
#      Restart-PulseAudio)
#         pulseaudio zenity --progress --auto-close --pulsate --title="Restarting PulseAudio..." --text="Make sure audio devices are plugged in BEFORE running this, otherwise it may not work."
#         ;;
#      Do-accelerated-updates)
#         apt-fast-upgrade
#         ;;
#      Install-Bottles)
#         bottles
#         ;;
#      Install-Lutris)
#          lutris
#          ;;
#    esac
# }

# hello today we're going to talk about goofy ahh uncle productions.
# goofy ahh uncle productions is a internet phenomenon

# gui () {
#    echo -e "${green}Starting GUI...${reset}"
#    ask=$(zenity --list --title="Management Options" --column="0" "Restart Pipewire" "Restart PulseAudio (old Audio Server)" "do Accelerated Updates" "Show Help" "Install Bottles" "Install Lutris" --width=300 --height=300 --hide-header)
#    if [ "$ask" == "Restart Pipewire" ]; then
#       echo "Restarting Pipewire (Audio Server)..."
#       (pipewire >> /dev/tty ; echo "100" ) | zenity --progress --auto-close --pulsate --title="Restarting Pipewire..." --text="Make sure audio devices are plugged in BEFORE running this, otherwise it may not work."
#    elif [ "$ask" == "Restart PulseAudio (old Audio Server)" ]; then
#       echo "Restarting PulseAudio..."
#       (pulseaudio >> /dev/tty ; echo "100" ) | zenity --progress --auto-close --pulsate --title="restarting PulseAudio..." --text="Make sure audio devices are plugged in BEFORE running this, otherwie it may not work."
#    elif [ "$ask" == "do Accelerated Updates" ]; then
#       echo "Running apt-fast for accelerated updates...."
#       (apt-fast-upgrade >> /dev/tty ; echo "100") | zenity --progress --auto-close --pulsate --title="updating..." --text="please be patient, this might take a while..."
#    elif [ "$ask" == "Show Help" ]; then
#       help
#    elif [ "$ask" == "Install Bottles" ]; then
#       (bottles >> /dev/tty ; echo "100") | zenity --progress --auto-close --pulsate --title="Installing Bottles..." --text="please be patient, this might take a while..."
#    elif [ "$ask" == "Install Lutris" ]; then> --pulsate --title="running pop-system-upgrade..." --text="please be patient, this might take a while..." 
#    fi
# }

backupfunc() {
   askbackupdconf=$(zenity --list --title="Backup" --column="0" --width=150 --height=300 --hide-header "all-settings" "only-Desktop-Extensions" "only-.config-folder" "everything")
   case $askbackupdconf in
      all-settings)
         mkdir -p ~/Backups/Dconf/
         echo -e "${green}(re-)created backups folder${reset}"
         dconf dump / > ~/Backups/Dconf/backup.dconf
         echo -e "${green}Backed up dconf settings${reset}"
         ;;
      only-Desktop-Extensions)
         mkdir -p ~/Backups/Dconf/
         echo -e "${green}(re-)created backups folder${reset}"
         dconf dump /org/gnome/shell/extensions/ > ~/Backups/Dconf/extensions.dconf
         echo -e "${green}Backed up /org/gnome/shell/extensions/ to ~/Backups${reset}"
         ;;
      only-.config-folder)
         mkdir -p ~/Backups/Dconf/
         echo -e "${green}(re-)created backups folder${reset}"
         cp -R ~/.config ~/Backups/
         echo -e "${green}Backed up .config to ~/Backup/.config/${reset}"
         ;;
      everything)
         mkdir -p ~/Backups/Dconf/
         echo -e "${green}(re-)created backups folder${reset}"
         dconf dump / > ~/Backups/Dconf/backup.dconf
         echo -e "${green}Backed up dconf settings${reset}"
         cp -R ~/.config ~/Backups/
         echo -e "${green}Backed up .config to ~/Backup/.config/${reset}"
         ;;
   esac
}

backupload() {
   askloaddconf=$(zenity --list --title="Load Backup" --column="0" --width=150 --height=300 --hide-header "Load-All-Settings" "Only-desktop-extensions" "only-.config-folder" "everything")
      backupreboot() {
         echo -e "${green}Backup loaded, you might want to ${bold}reboot.${reset}"
      }
         case $askloaddconf in
            Load-All-Settings)
               dconf load / < ~/Backups/Dconf/backup.dconf
               backupreboot
               ;;
            Only-desktop-extensions)
               dconf-load / < ~/Backups/Dconf/extensions.dconf
               backupreboot
               ;;
            only-.config-folder)
               cp -R ~/Backups/.config ~/
               backupreboot
               ;;
            everything)
               dconf load / < ~/Backups/Dconf/backup.dconf
               cp -R ~/Backups/.config ~/
               backupreboot
               ;;
         esac
}

if [ -n "$1" ]; then
   case "$1" in
   -h)
      help 
      ;;
   -pw)
      echo "Restarting PipeWire..."
      pipewire
      ;;
   -pa)
      echo "Restarting PulseAudio..."
      pulseaudio
      ;;
   -g)
      gui
      ;;
   -a)
      echo "Running apt-fast for accelerated updates...."
      apt-fast-upgrade
      ;;
   --backup) # backup settings through dconf
      backupfunc
      ;;
   --loadbackup)
      backupload
      ;;
   -l)
      lutris
      ;;
   -b)
      bottles
      ;;
   -pu)
      popupdate
      ;;
   *)
      echo "$1 is not an option"
      ;;
   esac
# else
#    gui
fi
