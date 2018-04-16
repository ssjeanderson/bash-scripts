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

# Calcula o tamanho do array, desconsiderando as ultimas 8 linhas (informação nao util)
TAMANHO_UTIL=$((${#RESPOSTA_LDAP[@]} - 8))

# Percorre o Array, incrementado em 4
for i in $(seq 0 3 $TAMANHO_UTIL); do

        if [[ "${RESPOSTA_LDAP[$i]}" =~ ^dn:: ]]; then
                DN="$(echo ${RESPOSTA_LDAP[$i]#* } | base64 -d)"
                CN="${DN//*(CN=|,*)}"
        else
                DN="${RESPOSTA_LDAP[$i]#* }"
                CN="${DN//*(CN=|,*)}"
        fi

        if [ "$CN" != "${RESPOSTA_LDAP[$i+1]//*(sAMAccountName: |\$)}" ]; then
                LDIF+="dn: $DN\nchangetype: modrdn\nnewrdn: CN=${RESPOSTA_LDAP[$i+1]//*(sAMAccountName: |$)}\ndeleteoldrdn: 1\n\n"
        fi
done

if [[ ! "$LDIF" ]]; then
        echo "Nothing to change."
        exit 0
fi

echo -en "$LDIF"
