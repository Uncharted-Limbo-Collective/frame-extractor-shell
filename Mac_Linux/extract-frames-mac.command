#!/bin/bash

# Clean screen
osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'

# turn echo off
stty -echoctl

# ------------------------------------ INTRO
# First Line of dashes
for i in {0..50}
do
	echo -n "-"
	sleep 0.01
done

# New line
echo ""

# 5 dashes
for i in {0..5}
do
	echo -n "-"
	sleep 0.01
done

# My name
echo -n " "
grep -o . <<< "Frame_Extractor_By_George_Adamopoulos" | while read letter;  do echo -n "$letter" ; sleep 0.02; done
echo -n " "

# 5 dashes
for i in {0..5}
do
	echo -n "-"
	sleep 0.01
done

# New line
echo ""

# Last Line of dashes
for i in {0..50}
do
	echo -n "-"
	sleep 0.01
done

# Empty Line
echo ""
echo ""

# Greet user
sleep 1
echo "Hello friend."
sleep 1
# ------------------------------------ END OF INTRO


# go to vlc install location
cd /Applications/VLC.app/Contents/MacOS/

# Repeat until the user gives a valid file
while :
do
	echo "Please drag the video file you want to extract frames from, and press Enter..."
	read _filePath

    if [ ! -f "$_filePath" ];
    then
	    echo ""
	    echo "You did not give me a file, but something else, that I don't want at all."
    else
    	break
    fi
done

# Congratulate user
echo ""
echo "Good!"
echo ""
sleep 0.8

# Rpeat until the user gives a valid directory
while :
do
	echo "Please drag the folder that you want the images to be saved in, and press Enter..."
	read _framesPath

    if [ ! -d "$_framesPath" ];
    then
	    echo ""
	    echo "You did not give me a folder, but something else, that I don't want at all."
    else
    	break
    fi
done

# Congratulate user
echo ""
echo "Good!"
echo ""
sleep 0.5

# Rpeat until the user gives an integer number
while :
do
	echo "We will capture 1 frame every [...] frames (5 is a good number)..."
	read _frameInterval

    if [[ -n ${_frameInterval//[0-9]/} ]];
    then
	    echo ""
	    echo "You did not give me a number, but something else, that I don't want at all."
    else
    	break
    fi
done

# Congratulate user
echo ""
echo "All good! We will start in:"
sleep 0.5
echo "...3..."
sleep 1
echo "...2..."
sleep 1
echo "...1..."
sleep 1
echo "Extracting ! Ignore the black message below."
echo ""
sleep 1

./VLC -V any -I macosx "$_filePath" --quiet --video-filter=scene --scene-format=jpg --scene-ratio=$_frameInterval --scene-path="$_framesPath" VLC://quit

echo ""
echo "Finished extracting. This window will safely self-destruct in:"
sleep 1
echo "...3..."
sleep 1
echo "...2..."
sleep 1
echo "...1..."
sleep 1
echo "Bye!"
echo ""
sleep 1

osascript -e 'tell application "Terminal" to close first window' & exit
