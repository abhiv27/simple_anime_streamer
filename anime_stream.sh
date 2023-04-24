#!/bin/bash

echo "Simple anime streamer."
echo "Enter name of anime followed by episode number (if episode number is between 0-9 do type in double digit, ie 00,01..)"
read name

while [ -z "name" ]

do
	echo "Kindly enter name of the anime followed by episode number"
	read name
done

name=${name// /+}


#default anime site - tokyotosho.info - nyaa.si is blocked in many places
#default resolution - 720p

magnet=$(curl -s "https://www.tokyotosho.info/search.php?terms=$name+720&type=1&searchName=true&searchComment=true&size_min=&size_max=&username=" | grep -Po "magnet:\?xt=urn:btih:[a-zA-Z0-9]*" | head -n 1)

echo -e "Select your media player.\npress 1 for vlc\npress 2 for mpv"
choice=
while true; do
    read choice
    case $choice in
        1)
            echo "You selected VLC."
            choice="-v"
            break
            ;;
        2)
            echo "You selected MPV."
            choice="-k"
            break
            ;;
        *)
            echo "Invalid choice. Please select either 1 or 2."
            ;;
    esac
done

peerflix $magnet $choice
