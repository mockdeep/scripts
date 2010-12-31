#!/bin/bash

# a short script to move the currently playing song
# in mpd to a folder for low key music

# the current path to the file, from the root music directory
deadFile=`mpc --format %file% | head -n 1`
# appending the full path to the music directory
fullDead=$HOME/Music/$deadFile
# the new path for the track to be relocated to
fullLive=$HOME/Music-Placid/$deadFile
# make the directory recursively
mkdir -p "${fullLive%/*}"
# remove the song from the playlist, advancing the track
mpc del 0
# move the file to its new home
mv -f "$fullDead" "$fullLive"
