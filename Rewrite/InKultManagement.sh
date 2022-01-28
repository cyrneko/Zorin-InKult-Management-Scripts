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

pulseaudio() {
   systemctl --user restart pulseaudio
   echo -e "${green}PulseAudio restarted!${reset}"
}

pipewire() {
   systemctl --user restart pipewire pipewire-pulse || echo -e "${red}Restarting Failed!${reset}" || echo -e "${green}pipewire restarted${reset}"
}

help() {
   echo -e "${red}$(figlet "InKult Management")"
   echo "This script sets up Zorin installations at the InKult Youth Center in Germany."
   echo -e "${reset}------------"
   echo -e "${blue}${bold}${uline}Syntax${reset}: $0 [Options]"
   echo ""
   echo -e "${red}No Options = GUI${reset}"
   echo ""
   echo -e "${blue}${bold}${uline}Example options:${reset}"
   echo -e "$0 -h   |   ${green}shows a help page for this script${reset}"
   echo -e "$0 -g   |   ${green}shows a GUI to do different actions${reset}"
   echo -e "$0 -a   |   ${green}runs apt-fast for accelerated system updates${reset}"
   echo -e "$0 -pw  |   ${green}restarts PipeWire (Audio Server)${reset}"
   echo -e "$0 -pa  |   ${green}restarts PulseAudio (Audio Server, default, but older)${reset}"
   echo "------------"
   exit
}

apt-fast-upgrade () {
   echo -e "${red}starting...${reset}"
   pkexec apt-fast upgrade -y
   echo -e "${green}Finished!${reset}"
}


gui () {
   echo -e "${green}Starting GUI...${reset}"
   ask=$(zenity --list --title="Management Options" --column="0" "Restart Pipewire" "Restart PulseAudio (old Audio Server)" "do Accelerated Updates" "Show Help" --width=150 --height=300 --hide-header)
   if [ "$ask" == "Restart Pipewire" ]; then
      echo "Restarting Pipewire (Audio Server)..."
      (pipewire >> /dev/tty
      echo "100" ) | zenity --progress --auto-close --pulsate --title="Restarting Pipewire..." --text="Make sure audio devices are plugged in BEFORE running this, otherwise it may not work."
   elif [ "$ask" == "Restart PulseAudio (old Audio Server)" ]; then
      echo "Restarting PulseAudio..."
      (pulseaudio >> /dev/tty
      echo "100" ) | zenity --progress --auto-close --pulsate --title="restarting PulseAudio..." --text="Make sure audio devices are plugged in BEFORE running this, otherwie it may not work."
   elif [ "$ask" == "do Accelerated Updates" ]; then
      echo "Running apt-fast for accelerated updates...."
      (apt-fast-upgrade >> /dev/tty
      echo "100") | zenity --progress --auto-close --pulsate --title="updating..." --text="please be patient, this might take a while..."
   elif [ "$ask" == "Show Help" ]; then
      help
   fi
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
   *)
      echo "$1 is not an option"
      ;;
   esac
   shift
else
   gui
fi