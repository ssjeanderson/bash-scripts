#!/bin/bash
filename="$1"
timeshift="$2"

operation="${timeshift:0:1}"
adjust_sec="${timeshift:1}"

while read -r line
do
    if [[ "$line" =~ ^[0-9][0-9]\: ]]; then
        start_hour=${line:0:2}
        stop_hour=${line:17:2}
        start_min=${line:3:2}
        stop_min=${line:20:2}
        start_sec=${line:6:2}
        stop_sec=${line:23:2}

        new_start_sec=$(( $start_sec $operation $adjust_sec ))
        if [[ $new_start_sec > 59 ]]; then

        fi

    fi
done < "$filename"
