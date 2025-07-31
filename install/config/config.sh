#!/bin/bash

YARON_DEV_DOTFILES=~/personal/horskydev/install/config/dotfiles

curl -sS https://starship.rs/install.sh | sh

# bashrc
# echo "source $YARON_DEV_DOTFILES/bash/.bashrc" >>$HOME/.bashrc
source $HOME/.bashrc
