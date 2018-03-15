#!/bin/bash

# Util para debug em bash script

trap 'echo -e "
# Erro encontrado durante execução do Script #

Numero da linha no script: $LINENO
Exit code do commando: $?
Comando no script: $BASH_COMMAND
Comando expandido: $(eval echo $BASH_COMMAND)"' ERR

# Inicio do programa

# comando qualquer para gerar um erro
AAA="aaa"
ls "$AAA"
