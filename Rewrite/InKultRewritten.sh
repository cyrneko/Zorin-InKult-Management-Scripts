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

zlite() {
   echo -e "${red}${bold}$(figlet Zorin Lite)${reset}"
   basic-programs
   if [ "$PLANK" == "1" ]; then
      sudo apt install plank
   fi
   exit
}

zcore() {
   echo -e "${red}${bold}$(figlet Zorin Core)"
   basic-programs
   echo -e "${green}# Installing the Zorin-Dash extension...${reset}"
   echo -e "${red} Don't panic if the screen flickers for a second, it's normal ;)${reset}"
   sleep 5s
   sudo apt-fast install gnome-shell-extension-zorin-dash -y
   busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
   echo "${red}sleeping for 10 seconds...${reset}"
   sleep 10s
   gnome-extensions disable zorin-menu@zorinos.com -q
   gnome-extensions disable zorin-taskbar@zorinos.com -q
   dconf load /org/gnome/shell/extensions/zorin-dash/ <./zorin-dash-conf
   gnome-extensions enable zorin-dash@zorinos.com -q
   exit
}

help() {
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
   echo -e "${blue}PLANK=1 can be used to install plank-dock.${reset}"
   echo "------------"
   exit
}

basic-programs() {
   sudo add-apt-repository ppa:apt-fast/stable
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast
   sudo echo debconf apt-fast/maxdownloads string "20" | debconf-set-selections
   sudo echo debconf apt-fast/dlflag boolean "true" | debconf-set-selections
   sudo echo debconf apt-fast/aptmanager string "apt" | debconf-set-selections
   sudo dpkg --add-architecture i386
   echo "${green}${bold}# Installing WINE keys...${reset}"
   wget -nc https://dl.winehq.org/wine-builds/winehq.key
   sudo apt-key add winehq.key
   sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
   echo -e "${green}${bold}# Installing Wine${reset}"
   echo -e "${red} This might take a while depending on internet speeds!${reset}"
   sudo apt-fast install --install-recommends winehq-devel
}

# Options
# shellcheck disable=SC1089
if [ -n "$1" ]; then
   # shellcheck disable=SC2220
   case $1 in
   -h) # display Help
      help
      ;;
   -l) # Specify Zorin-Lite for Setup | shit doesn't work at the moment, man, why
      zlite
      ;;
   -c)
      zcore
      ;;
   -o)
      basic-programs
      ;;
   *) # Invalid option
      echo "Error: Invalid option"
      exit
      ;;
   esac
   shift
else
   help
fi

exit 0
# Basic Programs are installed accross all types of installation

exit 0
