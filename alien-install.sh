#!/usr/bin/zsh

# ---------------------------
#   Making Folders
# ---------------------------
if [[ ! -d ~/.alien ]]; then
    mkdir -m 777 ~/.alien
fi

if [[ ! -d ~/.alien/functions ]]; then
    mkdir -m 777 ~/.alien/functions
fi

# ---------------------------
#   Deleting and remaking shell scripts
# ---------------------------
rm -rf ~/.alien/bin
cp -R bin ~/.alien/bin
chmod 777 ~/.alien/bin

# ---------------------------
#   Aliasing alien and alien-source
# ---------------------------

ALIEN_PATH='export PATH=$PATH:$HOME/.alien/bin'
ALIEN_PATH_EXISTS=$(cat ~/.zshrc | grep $ALIEN_PATH)
if [[ -z $ALIEN_PATH_EXISTS ]];then
    echo -e $ALIEN_PATH >> ~/.zshrc
fi

ALIEN_SOURCE_COMMAND='source $HOME/.alien/bin/helpers/alien-source'
ALIEN_SOURCE_COMMAND_EXISTS=$(cat ~/.zshrc | grep $ALIEN_SOURCE_COMMAND)
if [[ -z $ALIEN_SOURCE_COMMAND_EXISTS ]];then
    echo -e $ALIEN_SOURCE_COMMAND >> ~/.zshrc
fi

ALIEN_SOURCE_ALIAS='alias alien-source="source $HOME/.alien/bin/helpers/alien-source"'
ALIEN_SOURCE_ALIAS_EXISTS=$(cat ~/.zshrc | grep $ALIEN_SOURCE_ALIAS)
if [[ -z $ALIEN_SOURCE_ALIAS_EXISTS ]];then
    echo -e $ALIEN_SOURCE_ALIAS >> ~/.zshrc
fi

echo "Alien Installed. Restarting zsh."
exec zsh