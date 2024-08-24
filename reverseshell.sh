#!/bin/bash

dialog --title "WARNING-WARNING-WARNING!" --yesno "This will initiate a reverse shell connection to (insert person here) and have full control over your Wii. Other disclaimer stuff bla bla bla" 7 60
response=$?
case $response in
   0) clear;read -n 1 -s -r -p "Insert code for reverse shell here :P";printf "\n";; # replace this line with actual code
   1) echo "File not deleted.";;
   255) echo "[ESC] key pressed.";;
esac
