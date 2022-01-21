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
    systemctl --user restart pipewire pipewire-pulse
    echo -e "${green}pipewire restarted${reset}"
}

while getopts ":hg" option; do
   # shellcheck disable=SC2220
   case $option in
   h) # display Help
      echo -e "${red}$(figlet "InKult Setup")"
      echo "This script sets up Zorin installations at the InKult Youth Center in Germany."
      echo -e "${reset}------------"
      echo -e "${blue}${bold}${uline}Syntax${reset}: $0 [Options]"
      echo ""
      echo -e "${blue}${bold}${uline}Example options:${reset}"
      echo -e "$0 -h   |   ${green}shows a help page for this script${reset}"
      echo -e "$0 -c   |   ${green}starts installation and setup for Zorin 16 Core.${reset}"
      echo -e "$0 -l   |   ${green}starts installation and setup for Zorin 16 Lite.${reset}"
      echo -e "$0 -o   |   ${green}attempts to install on other debian-based distributions.${reset}"
      echo -e "$0 -p   |   ${green}preperation for running the script, not mandatory.${reset}"
      echo -e "${blue}PLANK=1 can be used to install plank.${reset}"
      echo "------------"
      exit
      ;;
   g)
      echo "test"
      ;;
   *) # Invalid option
      echo "Error: Invalid option"
      exit
      ;;
   esac
done
