#!/bin/bash

sleep 60
conky -c ~/Dropbox/dotfiles/conkyrc &
#alltray -st -na -g 300x400+1620 "prism" -override "/home/explorer/.webapps/gtasks@prism.app/override.ini" -webapp gtasks@prism.app &
sleep 10
conky -c ~/Dropbox/dotfiles/conkyrc2 &
sleep 10
conky -c ~/Dropbox/dotfiles/conkyrc3 &
