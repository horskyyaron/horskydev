#!/bin/bash

# This will extend Omarchy, thus it doesn't override some dotfiles but
# extends them.
# e.g. adding "source some/file.sh" into another file.

YARON_DEV_DOTFILES=~/.local/share/horskydev/install/config/dotfiles

# bashrc
echo "configuring bash"
curl -sS https://starship.rs/install.sh | sh
echo "source $YARON_DEV_DOTFILES/bash/.bashrc" >> $HOME/.bashrc
cp $YARON_DEV_DOTFILES/tmux/.tmux.conf ~
