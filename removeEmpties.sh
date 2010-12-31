#!/bin/bash
##----------------
##Script Name: 
##Description of Script:
##Date:
#-----------------

## USER-SET VARIABLES -----------

# ****** startdir - Set Starting Directory

startdir='/home/explorer/Music'

# ****** maxjpgs - Set Maximum Number of JPGs to Delete - USER NEEDS TO SET THIS VARIABLE
# This allows for deletion of more than one JPG (front cover, back cover, liner notes, etc.)
# while maintaining a margin of safety (i.e., the script can't accidentally delete hundreds of image files
# in a single folder at a time). If you know you only will have one JPG file in a directory, set value to 1. 
# For testing , this was set to 2 to test that the dummy folder with three JPGs + no music files would not be targeted.

maxjpgs=6

## END USER_SET VARIABLES -------


cd $startdir

find -type d -print | while read dir; do
	dircut=$(echo $dir | cut -c3-)
	fulldir=$startdir/$dircut
	numfiles=$(ls -l "$fulldir" | grep "^-" | wc -l)
	jpgfiles=$(ls -l "$fulldir" | grep ".jpg$" | wc -l)

	if [ "$numfiles" = "$jpgfiles" ] && [ "$jpgfiles" != "0" ] && [ "$jpgfiles" -le "$maxjpgs" ] ; then
		filemask=*.jpg
# *** THIS CODE DELETES THE STRAY JPG FILES
		find "$fulldir" -maxdepth 1 -type f -print0 | xargs -0 rm -f $filemask
	fi
done

# *** ORIGINAL CODE THAT DELETES EMPTY DIRECTORIES 
find "$startdir" -type d -print0 | xargs -0 rmdir --ignore-fail-on-non-empty --parents

#---
exit
