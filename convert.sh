#!/bin/bash

# first you'll want to download a soundFont, here's a good one:
# http://www.midi2mp3.com/sf2/merlin_vienna.sfArk
# then you'll need to unpack it:
# mkdir sfark
# cd sfark
# wget http://falcony.googlecode.com/files/sfarkxtc_lx86.tar.gz
# tar -xzf sfarkxtc_lx86.tar.gz
# sudo apt-get install libstdc++5 timidity
# # cd into the directory where you downloaded the sfArk file and...
# for i in *.sf[Aa]rk ; do sfark/sfarkxtc "$i" && rm "$i" ; done
# move the new sf2 file into some place like:
# sudo mv merlin_vienna.sf2 /usr/share/midi/
# and edit /etc/timidity/timidity.cfg
# comment out the source line and add the following:
# soundfont /usr/share/midi/merlin_vienna.sf2
# then you can run this handy dandy script to convert your midis to wavs
# followed by mp3s

for f in *.mid; do
  echo $f
  base=`basename "$f" .mid`
  timidity -Ow "$f"
  lame "$base.wav" "$base.mp3"
done
