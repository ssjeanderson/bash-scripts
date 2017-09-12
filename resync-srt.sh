#!/bin/bash

timeshift="$1"
filename="$2"
newfile="$3"

operation="${timeshift:0:1}"
adjust_sec="${timeshift:1}"

while read -r line
do
    if [[ "$line" =~ ^[0-9][0-9]\: ]]; then
        start_hour=${line:0:2}
        start_min=${line:3:2}
        start_sec=${line:6:2}
        stop_hour=${line:17:2}
        stop_min=${line:20:2}     
        stop_sec=${line:23:2}

        start_millisec=${line:9:3}
        stop_millisec=${line:26:3}

        new_start_hour=$start_hour
        new_start_min=$start_min
        new_stop_hour=$stop_hour
        new_stop_min=$stop_min

        new_start_sec=$(( $start_sec $operation $adjust_sec ))
        if [[ $new_start_sec -gt 59 ]]; then
            new_start_sec=$(( $start_sec + $adjust_sec - 60 ))
            new_start_min=$(( $start_min + 1))
            if [[ $new_start_min -gt 59 ]]; then
                new_start_min=0
                new_start_hour=$(( $start_hour + 1 ))
            fi
        fi

        if [[ $new_start_sec -lt 0 ]]; then
            new_start_sec=$(( 60 + $start_sec - $adjust_sec ))
            new_start_min=$(($start_min - 1))
            if [[ $new_start_min -lt 0 ]]; then
                new_start_min=59
                new_start_hour=$(( $start_hour - 1 ))
                if [[ $new_start_hour -lt 0 ]]; then
                    new_start_hour=0
                    new_start_min=0
                    new_start_sec=0
                fi
            fi
        fi

        new_stop_sec=$(( $stop_sec $operation $adjust_sec ))
        if [[ $new_stop_sec -gt 59 ]]; then
            new_stop_sec=$(( $stop_sec + $adjust_sec - 60 ))
            new_stop_min=$(( $stop_min + 1))
            if [[ $new_stop_min -gt 59 ]]; then
                new_stop_min=0
                new_stop_hour=$(( $stop_hour + 1 ))
            fi
        fi

        if [[ $new_stop_sec -lt 0 ]]; then
            new_stop_sec=$(( 60 + $stop_sec - $adjust_sec ))
            new_stop_min=$(($stop_min - 1))
            if [[ $new_stop_min -lt 0 ]]; then
                new_stop_min=59
                new_stop_hour=$(( $stop_hour - 1 ))
                if [[ $new_stop_hour -lt 0 ]]; then
                    new_stop_hour=0
                    new_stop_min=0
                    new_stop_sec=0
                fi
            fi
        fi

        echo "$new_start_hour:$new_start_min:$new_start_sec,$start_millisec --> $new_stop_hour:$new_stop_min:$new_stop_sec,$stop_millisec" >> $newfile
    else
        echo "$line" >> $newfile
    fi
done < "$filename"
