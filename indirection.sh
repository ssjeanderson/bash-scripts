#!/bin/bash

var1=one
var2=two
var3=three

var4='$var1 texto $va-r2 ${var3} $(some_command) $_var2 $0A $#$'

var5="$(echo "$var4" | sed 's/\n/\\n/g')"

variables="$(echo "$var5" | egrep -o '\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])' | cut -b 2-)"
not_variables="$(echo "$var5" | sed -E 's/\$([a-zA-Z_][a-zA-Z0-9_]*|[0-9\!\@\#\$\*\-\_\?])/\n/g')"

readarray -t array_variables <<< "$variables"
readarray -t array_not_variables <<< "$not_variables"

for i in ${!array_variables[@]}; do
	echo "array_variables[$i]=${array_variables[$i]}"
done

echo --------------------

for i in ${!array_not_variables[@]}; do
	echo "array_not_variables[$i]=${array_not_variables[$i]}"
done

#echo -------------------

for i in ${!array_not_variables[@]}; do
	#echo Loop $i:
	notvar="${array_not_variables[$i]}"
	var="${array_variables[$i]:-NONE}"
	result+="$notvar"
	result+="${!var}"
done

echo ------

echo "$var4"
echo "$result"
