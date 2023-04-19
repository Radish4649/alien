#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
list

Description:
    List all created functions.

Usage:
    alien list
"
}

if [[ $1 == "help" ]];then
    help && exit 0
fi

# -------------------
#   FUNCTION
# -------------------

ls -1A $FUNCTION_DIRECTORY