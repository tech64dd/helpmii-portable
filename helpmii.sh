#!/bin/bash

VERSION="v1.0"
DIALOG_COMMON="--no-mouse"
DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

left_text="HelpMii Wii Linux Support Program"
right_text="$VERSION"

text_len=$((${#left_text} + ${#right_text}))
# dialog has 2 blank chars on the left and right
padding_length=$((COLUMNS - text_len - 2))
padding=$(printf "%${padding_length}s")

BACKTITLE="$left_text$padding$right_text"
unset text_len padding_length padding left_text right_text



while true; do
  exec 3>&1
  selection=$(dialog $DIALOG_COMMON \
    --backtitle "$BACKTITLE" \
    --title "Main Menu" \
    --clear \
    --cancel-label "Cancel" \
    --menu "Select an option:" $HEIGHT $WIDTH 4 \
    "1" "Join the Wii Linux Discord" \
    "2" "Get Started guide" \
    "3" "Upload logs" \
    "4" "Initiate Reverse Shell (!!!)" \
    "0" "Quit" \
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
      clear
      cat discord_qr.txt
      read -n 1 -s -r -p "Press any key to continue...";printf "\n"
      ;;
    2 )
      clear
      less ./getstarted.txt
      ;;
    3 )
      clear
      dmesg > ./dmesg.log
      tar cvzf ./logs.tar.gz ./dmesg.log
      clear
      printf "Uploading logs, please wait...\n"
      curl bashupload.com -s -T ./logs.tar.gz
      rm ./logs.tar.gz
      rm ./dmesg.log
      printf "Show the text above to whoever is helping you in the Wii Discord server\n"
      read -n 1 -s -r -p "Press any key to continue...";printf "\n"
      ;;
    4 )
      dialog $DIALOG_COMMON --title "WARNING-WARNING-WARNING!" --yesno "You are about to give the admins of Wii Linux complete\nand total control over your Wii.\nNobody here will look through your files or the like\nbut, the shell will be running as root, so in theory, they could (but again, they shouldn't).\n\nAre you sure you want to do this?" 12 60
      response=$?
      case $response in
        0) exec ./reverseshell.sh;;
        1) clear;;
      esac
      ;;
    0 )
      clear
      exit
      ;;
  esac
done
