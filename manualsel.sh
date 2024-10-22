#!/bin/bash

VERSION="             v1.0"
DIALOG_COMMON="--no-mouse"
DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

left_text="Wii Linux User Guides"
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
    "1" "Getting Started" \
    "2" "How to make Placeholders Vol. 1" \
    "3" "How to make Placeholders Vol. 2" \
    "4" "Back to HelpMii" \
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
      less getstarted.txt
      ;;
    2 )
      less placeholder.txt
      ;;
    3 )
      less placeholder.txt
      ;;
    4 )
      exec ./helpmii.sh
      ;;
  esac
done
