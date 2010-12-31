#!/bin/bash
todofile=/home/explorer/Desktop/todo.txt
filedate=$(date -r /home/explorer/Desktop/todo.txt +%F)
curdate=$(date +%F)
if [ ! -f $todofile ] || [ $filedate != $curdate ]
then
    conkyGoogleCalendar -u USERNAME -p PASSWORD --daysahead=1 --limit=10 -r "Routines" --template=/home/explorer/scripts/conkyRoutines.template > $todofile
fi
cat $todofile
