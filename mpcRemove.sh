#!/bin/bash

# a short script to move the currently playing song
# in mpd to the Trash

# get the file path from mpc using command line options
deadFile=`mpc --format %file% | head -n 1`

# add the home directory to the path
fullDead=$HOME/Music/$deadFile

# delete the song from mpc's playlist
mpc del 0

# move the file to the trash bin
gvfs-trash "$fullDead"

# formerly for moving to the next track, now unnecessary
# mpc next
