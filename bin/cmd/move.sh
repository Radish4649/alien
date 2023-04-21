#!/usr/bin/zsh

# -------------------
#   HELP
# -------------------
help() {
    echo "
move

Description:
    Move an existing function to a new alias.

Usage:
    alien move <function> <new_name>

ACTIONS
    function    name of function to move
    new_name    new alias of function
"
}

# -------------------
#   ARGUMENTS & PRECHECK
# -------------------

FUNCTION=$1
NEW_NAME=$2
shift
shift

FUNCTION_PATH="$FUNCTION_DIRECTORY/$FUNCTION"
if [[ ! -f $FUNCTION_PATH ]]; then
    echo "No such function exists. Check existing functions using [[ alien list ]]. Aborting."
    exit 1
fi

NEW_FUNCTION_PATH="$FUNCTION_DIRECTORY/$NEW_NAME"
if [[ -f $NEW_FUNCTION_PATH ]]; then
    echo "Function already exists for new desired name. Check existing functions using [[ alien list ]]. Aborting."
    exit 1
fi

NEW_FUNCTION_IS_COMMAND=$(command -v $NEW_NAME)
NEW_FUNCTION_IS_ALIAS=$(alias $NEW_NAME)

if [[ -n $NEW_FUNCTION_IS_COMMAND || -n $NEW_FUNCTION_IS_ALIAS ]];then
    echo "New function name is a file in PATH or is an alias. Aborting."
    exit 1
fi

# -------------------
#   EDITING / MOVING
# -------------------

OLD_FUNCTION_TEXT="function $FUNCTION() {"
OLD_FUNCTION_REGX="^$OLD_FUNCTION_TEXT$"
NEW_FUNCTION_TEXT="function $NEW_NAME() {"

mv $FUNCTION_PATH $NEW_FUNCTION_PATH

OLD_FUNCTION_TEXT_EXISTS=$(grep -n \
                            "$OLD_FUNCTION_TEXT" \
                            $NEW_FUNCTION_PATH \
                            | cut -d: -f1)

if [[ -z $OLD_FUNCTION_TEXT_EXISTS ]]; then
    echo "Error in function formatting. Is the function formatted properly in file  [[ $FUNCTION ]]?"
    echo "Aborting."
    exit 1
fi

sed -i \
    "s/$OLD_FUNCTION_REGX/$NEW_FUNCTION_TEXT/" \
    $NEW_FUNCTION_PATH

echo "Function [[ $FUNCTION ]] moved to [[ $NEW_NAME ]]"
echo "type [[ alien-source ]] to enable."