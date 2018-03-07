#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No color

trap 'echo -e "${RED}FAILED: command \""$BASH_COMMAND"\", line $LINENO, exit code $?${NC}"' ERR

# your commands here
# ...
