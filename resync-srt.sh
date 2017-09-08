#!/bin/bash
filename="$1"
timeshift="$2"
while read -r line
do
    if [[ $line =~ ^[0-9][0-9]\: ]]; then
        start_hour=${line:0:2}
        stop_hour=${line:17:2}
        start_min=${line:3:2}
        stop_min=${line:20:2}
        start_sec=${line:6:2}
        stop_sec=${line:23:2}
        

        #echo "$start_hour:$start_min:$start_sec $stop_hour:$stop_min:$stop_sec"
    fi
done < "$filename"
