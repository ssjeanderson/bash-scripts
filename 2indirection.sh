#!/bin/bash

var1=one
var2=two
var3=three

var4='aaaa$var1\n texto $va-r2 ${var3} $(some_command) $_var2 $0A $#$'

var5="$(echo "$var4" | sed 's/\\n/\\\\n/g')"

var6="$(echo "$var5" | egrep -o '\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])' | tr -d '$')"
var7="$(echo "$var5" | sed -E 's/\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])/\\n/g')"
var7="$(echo -e "$var7")"

mapfile -t var6x <<< "$var6"
mapfile -t var7x <<< "$var7"

for i in ${!var6x[@]}; do
	echo "var6x[$i]=${var6x[$i]}"
done

echo --------------------

for i in ${!var7x[@]}; do
	echo "var6x[$i]=${var7x[$i]}"
done

echo -------------------

for i in ${!var7x[@]}; do
	echo Loop $i:
	notvar="${var7x[$i]}"
	var="${var6x[$i]}"
	result+="$notvar"
	result+="${!var}"
	#result+="${var7x[$i]}"
	#result+="${var6x[$i]}"
done

#echo "${var6x[@]}"
#echo --
#echo "${var7x[@]}"

echo ------

echo "$var4"
echo "$result"
