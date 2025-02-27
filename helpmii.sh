#!/bin/bash

export VERSION="v1.1"

export left_text="HelpMii Wii Linux Support Program"
export right_text="$VERSION"

if [ -f ../util-dialog.sh ]; then
	. ../util-dialog.sh
elif [ -f ../common-util-scripts/util-dialog.sh ]; then
	. ../common-util-scripts/util-dialog.sh
else
	echo "failed to load util-dialog.sh"
	exit 1
fi

while true; do
	menu "Main Menu" \
	"OK" "Cancel" \
	"Select an option:" \
	"1" "Join the Wii Linux Discord" \
	"2" "Read the getting started guide" \
	"3" "Upload logs to Wii Linux support" \
	"9" "About HelpMii" \
	"0" "Quit"
	case $? in
		1)
			clear
			cat discord_qr.txt
			read -n 1 -s -r -p "Press any key to continue..."; echo ;;
		2)
			clear
			less ./getstarted.txt ;;
		3)
			clear
			./dumplogs.sh 2>&1 | gzip > /tmp/logs.txt.gz
			echo "Uploading logs, please wait..."
			curl bashupload.com -s -T /tmp/logs.txt.gz
			rm -f /tmp/logs.txt.gz
			echo "Show the above texe to whoever is helping you in the Wii Linux Discord server"
			read -n 1 -s -r -p "Press any key to continue..."; echo ;;
		9) info "About" "HelpMii - The Wii Linux Support Program.\n\nHelpMii Version $VERSION\nUsing $UTIL_VER_STR\n\nHelpMii was made by Techflash, Tech64, and other contributors.\nThis program is licensed under the terms of the GNU General Public License, version 2.\nYou may find these terms under the HelpMii install directory, under the LICENSE file." 15 70 ;;
		0|255)
			clear
			exit 0;;
	esac
done
