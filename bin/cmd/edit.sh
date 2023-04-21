#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
edit

Description:
    Edit a created function.

Usage:
    alien edit <function>

ACTIONS
    function    name of function to edit
"
}

if [[ $1 == "help" ]];then
    help && exit 0
fi

# -------------------
#   FUNCTION
# -------------------

FUNCTION=$1
shift

FUNCTION_PATH="$FUNCTION_DIRECTORY/$FUNCTION"
if [[ ! -f $FUNCTION_PATH ]]; then
    echo "Shortcut does not exist. Aborting."
    exit 1
fi

vim $FUNCTION_PATH