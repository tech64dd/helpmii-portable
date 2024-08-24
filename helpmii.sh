#!/bin/bash

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

display_result() {
  dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
}

while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "HelpMii Script v0.01" \
    --title "Main Menu" \
    --clear \
    --cancel-label "Cancel" \
    --menu "Select an option:" $HEIGHT $WIDTH 4 \
    "1" "Join the Wii Linux Discord" \
    "2" "Upload logs" \
    "3" "Initiate Reverse Shell (!!)" \
    "4" "Quit" \
    2>&1 1>&3)
  exit_status=$?
  exec 3>&-
  case $exit_status in
    $DIALOG_CANCEL)
      clear
      exit
      ;;
    $DIALOG_ESC)
      clear
      exit 1
      ;;
  esac
  case $selection in
    1 )
      dialog --title "Join the Discord" --msgbox "To join the Wii Linux Discord server navigate to \nhttps://example.com/discord\non a modern device" 7 52
      ;;
    2 )
      clear
      printf "Uploading logs, please wait..."
      # curl bashupload.com -s -T veryreal.log
      printf "Show the text above to whoever is helping you in the Wii Discord server\n"
      read -n 1 -s -r -p "Press any key to continue...";printf "\n"
      ;;
    3 )

      dialog --title "WARNING-WARNING-WARNING!" --yesno "This will initiate a reverse shell connection to (insert person here) and have full control over your Wii. Other disclaimer stuff bla bla bla" 7 60
      response=$?
      case $response in
        0) exec ./reverseshell.sh;;
        1) clear;;
      esac
      ;;
    4 )
      clear
      exit
      ;;
  esac
done
