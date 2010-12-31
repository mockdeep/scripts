#!/bin/bash
# Get the PID for existing Rhythmbox process.
PID=$(pgrep -u $LOGNAME -o -x rhythmbox)

# If Rhythmbox is not running. Get PID of other DBUS process.
if [ -n $PID ] ; then
    PID=$(pgrep -u $LOGNAME -o -x notification-da)
fi
    
# Find DBUS session bus for this session and export it.
DBUS_SESSION_BUS_ADDRESS=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ 2>/dev/null`
export $DBUS_SESSION_BUS_ADDRESS

# paths to rhythmbox and alsamixer executables
Rbox='/usr/bin/rhythmbox-client'
Amix='/usr/bin/amixer'

$Rbox --no-present
# set the initial volume to 0
$Amix -c 0 set Master 0% > /dev/null
# start Rhythmbox playing
$Rbox --play
$Rbox --hide
# every 3 seconds raise the volume by 1% until we reach 70%
for ((x=0; x<70; x++))
do
    $Amix -c 0 set Master $x% > /dev/null
    sleep 3
done
