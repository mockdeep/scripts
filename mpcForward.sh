#!/bin/bash

# a short script to move the currently playing song
# in mpd to to a folder for fast paced music

# the path of the existing file as mpc knows it
deadFile=`mpc --format %file% | head -n 1`
# appending the full path to the existing file
fullDead=$HOME/Music/$deadFile
# the new path for the file
fullLive=$HOME/Music-Rockin/$deadFile
# make the directory for the new location, recursively
mkdir -p "${fullLive%/*}"
# delete the file from the playlist, advancing the track
mpc del 0
# move the file to the new location
mv -f "$fullDead" "$fullLive"
