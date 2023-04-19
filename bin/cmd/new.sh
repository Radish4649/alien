#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
new

Description:
    Create a new function.

Usage:
    alien new <function>

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

FUNCTION_IS_COMMAND=$(command -v $FUNCTION)
FUNCTION_IS_ALIAS=$(alias $FUNCTION)

if [[ -n $FUNCTION_IS_COMMAND || -n $FUNCTION_IS_ALIAS ]];then
    echo "Function name is a file in PATH or is an alias. Aborting."
    exit 1
fi

FUNCTION_PATH="$FUNCTION_DIRECTORY/$FUNCTION"
if [[ -f $FUNCTION_PATH ]]; then
    echo "A file with that name already exists in Alien's function directory. Aborting."
    exit 1
fi

touch $FUNCTION_PATH
echo -e '#!/usr/bin/zsh' >> $FUNCTION_PATH
echo -e "function $FUNCTION() {" >> $FUNCTION_PATH
echo -e "   " >> $FUNCTION_PATH
echo -e "}" >> $FUNCTION_PATH
vim +3 $FUNCTION_PATH

echo "Function $FUNCTION created! type [[ alien-source ]] to enable."