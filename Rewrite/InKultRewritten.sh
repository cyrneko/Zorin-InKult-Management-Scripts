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

# Options
# shellcheck disable=SC1089
while getopts ":hl:" option; do
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
         echo "------------"
         exit;;
      l) # Specify Zorin-Lite for Setup
         echo -e "${red}$(figlet Zorin Lite)${reset}" 
         sudo -S ${basic-programs}
         exit;;
      \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

# Basic Programs are installed accross all types of installation
# Work In Progress
basic-programs () {
   sudo add-apt-repository ppa:apt-fast/stable
   sudo apt-get update
   DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast
   echo debconf apt-fast/maxdownloads string 20 | debconf-set-selections
   echo debconf apt-fast/dlflag boolean true | debconf-set-selections
   echo debconf apt-fast/aptmanager string apt | debconf-set-selections
   sudo dpkg --add-architecture i386

}

exit 0