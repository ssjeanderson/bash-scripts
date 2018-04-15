#!/bin/bash

shopt -s extglob

ARRAY[0]="dn:: ZG46IENOPW5vbWUxLERDPXTDqXN0ZSxEQz1jb20K"
ARRAY[1]="sam: nome1\$"
ARRAY[2]=""
ARRAY[3]="dn: CN=nome2,DC=teste,DC=com"
ARRAY[4]="sam: nome2\$"
ARRAY[5]=""
ARRAY[6]="dn: CN=computador,DC=teste,DC=com"
ARRAY[7]="sam: nome3\$"
ARRAY[8]=""

I_FINAL="$(( ${#ARRAY[@]} - 1 ))"

for i in $(seq 0 3 $I_FINAL); do

        if [[ "${ARRAY[$i]}" =~ ^dn:: ]]; then
                DN="$(echo ${ARRAY[$i]#* } | base64 -d)"
                CN="${DN//*(*CN=|,*)}"
        else
                DN="${ARRAY[$i]}"
                CN="${DN//*(*CN=|,*)}"
        fi


        if [ ! "$CN" == "${ARRAY[$i+1]//*(sam: |$)}" ]; then
                LDIF+="alterar DN: $DN\nnovo RDN: CN=${ARRAY[$i+1]//*(sam: |$)}\n\n"
        fi
done

echo -ne "$LDIF"
                                                                                        33,9          Fi
