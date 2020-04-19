#!/bin/bash
# A script to open my setup for working on Escape from the Cosmic Abyss
# it accepts one optional argument to select if it should be dual monitors (true) or not (false), 
# dual monitors is the default if nothing is passed
# Dependencies:
# - i3wm
# - Path to Project
# - Monitor Adresses (Names?)
# - Godot 2.1.x
# - Workflowy
# - Thunar
# - wmctrl
# - Firefox

#i3 workspace names! Get them from your i3/congfig
W1=1:1:Firefox
W2=2:2:Consoles
W3=3:3:Godot
W4=4:
W5=5:
W6=6:6:TabWork
W7=7:7:TabOther
W8=8:8:TabMedia

SETUP_NAME="Escape From the Cosmic Abyss"
DUAL_MONITORS=true
if [ ! -z "$1" ]
then
    if [ $1 = "false" ]
    then
        DUAL_MONITORS=false
        echo "Single Monitor Setup for $SETUP_NAME"
    elif [ $1 != "true" ]
    then
        echo "$SETUP_NAME || unrecognized option: $1 | Going with default (Dual Monitor)"
    else
        echo "Dual Monitor Setup for $SETUP_NAME"
    fi
else
    echo "Dual Monitor Setup for $SETUP_NAME"
fi

# PATHS
WORKFLOWY=/opt/WorkFlowy-x86_64.AppImage
WORK_FOLDER=/mnt/24847D5F847D3500/Daniel/ProjetosGames/CursoUdemy/EscapeFromTheCosmicAbyss/
GODOT2=/mnt/24847D5F847D3500/Daniel/00_Resources/_softwares/Godot/Godot_v2.1.6-stable_x11.64
MONITOR_LEFT=eDP-1-1
MONITOR_RIGHT=HDMI-0
CURRENT_WORKSPACE="$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true)' | jq .name)"

# Script Body
i3-msg move container to workspace RESET_WORKSPACE
i3-msg workspace RESET_WORKSPACE
sleep 1
i3-msg move container to workspace $W2
i3-msg workspace $W2
cd $WORK_FOLDER/Game
terminal
cd ~
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
sleep 3

i3-msg workspace $W6
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
i3-msg layout tabbed
$WORKFLOWY &
thunar $WORK_FOLDER &
while ! [[ "$(wmctrl -l)" =~ "WorkFlowy" ]] 
do
    sleep 2
done


i3-msg workspace $W1
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_LEFT
fi
i3-msg layout tabbed
firefox --new-window https://pomodoro-tracker.com/
sleep 3
firefox --new-tab https://docs.google.com/spreadsheets/d/1b26XumCT5TaKcx10XgyiDCsc19nzX6zUqJckSEz3QH0/edit#gid=0
sleep 1

i3-msg workspace $W3
if [ $DUAL_MONITORS = "true" ]
then
    i3-msg move workspace to output $MONITOR_RIGHT
fi
$GODOT2
