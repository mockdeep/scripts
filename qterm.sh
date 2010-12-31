#!/bin/sh

touchTerm()
{
        wmctrl -r 'Quake Terminal' -e '0,0,0,1279,500'
        wmctrl -r 'Quake Terminal' -b add,shaded
        wmctrl -r 'Quake Terminal' -b add,below
        touch /tmp/.quake.shaded
}

S1=`wmctrl -l|grep 'Quake Terminal'|wc -l`

if [ $S1 -eq '0' ]; then
    gnome-terminal --window-with-profile='Quake Terminal' --title='Quake Terminal'
    wmctrl -r 'Quake Terminal' -e '0,0,0,1279,500'
#    echo `wmctrl -l|grep 'Quake Terminal'|wc -l`
fi
# Unshade and bring to front
if [ -f /tmp/.quake.shaded ]; then
    wmctrl -r 'Quake Terminal' -b remove,below
    wmctrl -r 'Quake Terminal' -b remove,shaded
    wmctrl -a 'Quake Terminal'
    rm /tmp/.quake.shaded
# Shade and send to back
else
        touchTerm
fi
