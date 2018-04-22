#!/bin/bash

var1=one
var2=two
var3=three

var4='$var1 texto $va-r2 ${var3} $(some_command) $_var2 $0A $#$'

var5="$(echo "$var4" | egrep -o '\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])' | tr -d '$')"
var6="$(echo "$var4" | sed -E 's/\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])/___FILL___/g')"

echo BEGIN FOR
for i in $var5; do
    echo --- Turno $i ---
    if [[ ${!i} =~ / ]]; then
        var6="$(echo "$var6" | sed "s'___FILL___'${!i}'")"
    else
        var6="$(echo "$var6" | sed "s/___FILL___/${!i}/")"
    fi
done

echo END FOR

echo
echo "$var4"

echo ----------------------------------------

echo "$var6"
