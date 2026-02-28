#!/usr/bin/env bash
action=$(echo -e "  Shut Down\n  Reboot\n  Lock Session"|rofi -dmenu -i -p "Session Menu: ")

case $action in
	*"Shut Down") 
		systemctl poweroff
		;;
	*"Reboot") 
		systemctl reboot
		;;
	*"Lock Session")
		exec hyprlock > /dev/null
		;;
	* )
		exit 0
		;;
esac
