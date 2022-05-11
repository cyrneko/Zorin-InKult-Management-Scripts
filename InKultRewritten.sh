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

basic-programs() {
   sudo add-apt-repository ppa:apt-fast/stable -y
   sudo apt update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast
   echo debconf "apt-fast/maxdownloads string \"20\"" | sudo debconf-set-selections
   echo debconf "apt-fast/dlflag boolean \"true\"" | sudo debconf-set-selections
   echo debconf "apt-fast/aptmanager string \"apt\"" | sudo debconf-set-selections
   sudo dpkg --add-architecture i386
   echo "${green}${bold}# Installing WINE keys...${reset}"
   wget -nc https://dl.winehq.org/wine-builds/winehq.key
   sudo apt-key add winehq.key
   sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -sc) main" -y
   echo -e "${green}${bold}# Installing Wine${reset}"
   echo -e "${red}This might take a while depending on internet speeds!${reset}"
   sudo apt-fast install --install-recommends winehq-devel
}

plankinstall() {
   echo -e "${green}Installing plank-dock${reset}"
   sudo apt install -y plank
   echo -e "${green}Plank installed!${reset}"
   exit 0;
}

pop() {
   echo -e "${green}${bold}$(figlet Pop\!_OS)${reset}"
   basic-programs
   read -r -p "${green}do you want to perform a pop-system-upgrade?${reset}" yn
   case $yn in
      [yY] ) 
        echo -e "${green}Performing full release upgrade...${reset}"
        pop-upgrade release upgrade
        exit 0
        ;;
      [nN] )
        echo "skipping release upgrade..."
        exit 0
        ;;
        * )
        echo -e "${red}That is not a valid option!${reset}"
        exit 1
   esac
}

zlite() {
   echo -e "${red}${bold}$(figlet Zorin Lite)${reset}"
   basic-programs
   if [ "$DISABLE_PLANK" != "true" ]; then
   read -r -p "Do you want to install Plank-dock? [y/N]: " plankinput
      case $plankinput in
         [yY] )
            plankinstall
            ;;
         *)
            echo "skipping plank install."
            exit 0;
            ;;
      esac
   else
      echo "skipping plank due to DISABLE_PLANK=true!"
   exit 0;
   fi
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
   echo -e "$0 -h             ${green}shows a help page for this script${reset}"
   echo -e "$0 -c             ${green}starts installation and setup for Zorin 16 Core.${reset}"
   echo -e "$0 -l             ${green}starts installation and setup for Zorin 16 Lite.${reset}"
   echo -e "$0 -o             ${green}attempts to install on other debian-based distributions.${reset}"
   echo -e "$0 -tui           ${green}starts a Terminal-based UI/Selection screen${reset}"
   echo -e "$0 -t             ${green}same as --tui${reset}"
   echo "------------"
   exit
}

tui () {
   echo -e "${green}Select an option!${reset}"
   echo -e "${green}1     Install on Pop!_OS"
   echo "2     Install on Zorin 16.x Core"
   echo "3     Install on Zorin 16.x Lite"
   echo "4     Attempt installing on another debian-based distro (advanced)"
   echo -e "0     Exit.${reset}"
   read -r -p "Your selection: " tuiinput
      case $tuiinput in
         0)
            echo "${green}Exiting!${reset}"
            exit 0;
            ;;
         1)
            pop
            ;;
         2)
            zcore
            ;;
         3)
            zlite
            ;;
         4)
            basic-programs
            ;;
         5)
            plankinstall
            ;;
         *)
            echo "$tuiinput is not a valid option!"
            exit 1;
            ;;
      esac
}

# Options
# shellcheck disable=SC1089
if [ -n "$1" ]; then
   # shellcheck disable=SC2220
   case "$1" in
   -h)
      help
      ;;
   -l)
      zlite
      ;;
   -c)
      zcore
      ;;
   -o)
      basic-programs
      ;;
   --pop-upgrade) # run pop!_OS's upgrading tool for release upgrades
      pop
      ;;
   --tui)
      tui
      ;;
   -t)
      tui
      ;;
   --plank)
      plankinstall
      ;;
   *) 
      echo "Error: Invalid option"
      exit
      ;;
   esac
   shift
fi

exit 0
