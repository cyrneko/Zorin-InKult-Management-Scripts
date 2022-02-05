#!/bin/bash

ask=$(zenity --list --title="Wähle eine option" --column="0" "InKult-Management" "InKult-Setup" --hide-header)

if [ "$ask" == "InKult-Management" ]; then
    x-terminal-emulator -e ./InKultManagement.sh
else
    exit 0;
fi

if [ "$ask" == "InKult-Setup" ]; then
    x-terminal-emulator -e ./InKultRewritten.sh
else
    exit 0;
fi