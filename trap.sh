#!/bin/bash

# Util para debug em bash script

error_track() {
        echo
        echo "## Erro encontrado durante execução do Script ##"
        echo
        echo "Numero da linha no script: $1"
        echo "Exit code do comando:  $2"
        echo "Comando no script: $3"
        echo "Comando expandido: $(eval echo $3)"
}

trap 'error_track $LINENO $? "$BASH_COMMAND"' ERR

# Inicio do programa

# comando qualquer para gerar um erro
VAR="valor"
ls "$VAR"

