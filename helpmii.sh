#!/bin/bash

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "HelpMii Support Program                                                   v1.0" \
    --title "Main Menu" \
    --clear \
    --cancel-label "Cancel" \
    --menu "Select an option:" $HEIGHT $WIDTH 4 \
    "1" "Join the Wii Linux Discord" \
    "2" "Upload logs" \
    "3" "Initiate Reverse Shell (!!!)" \
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
      printf "Uploading logs, please wait...\n"
      # curl bashupload.com -s -T veryreal.log
      printf "Show the text above to whoever is helping you in the Wii Discord server\n"
      read -n 1 -s -r -p "Press any key to continue...";printf "\n"
      ;;
    3 )
      dialog --title "WARNING-WARNING-WARNING!" --yesno "You are about to give the admins of Wii Linux complete\nand total control over your Wii.\nNobody here will look through your files or the like\nbut, the shell will be running as root, so in theory, they could (but again, they shouldn't).\n\nAre you sure you want to do this?" 12 60
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
