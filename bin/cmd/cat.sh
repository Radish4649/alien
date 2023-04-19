#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
cat

Description:
    Display the code of a created function.

Usage:
    alien cat <function>

ACTIONS
    function    name of function to display
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

if [[ ! -f "$FUNCTION_DIRECTORY/$FUNCTION" ]]; then
    echo "Function does not exist. Aborting."
    exit 1
fi

cat "$FUNCTION_DIRECTORY/$FUNCTION"