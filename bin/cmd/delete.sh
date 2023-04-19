#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
delete

Description:
    Deleted a created function

Usage:
    alien delete <function>

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

rm -f "$FUNCTION_DIRECTORY/$FUNCTION"
echo "$FUNCTION deleted"