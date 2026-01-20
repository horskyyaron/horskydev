#!/bin/bash

# This will extend Omarchy, thus it doesn't override some dotfiles but
# extends them.
# e.g. adding "source some/file.sh" into another file.

# HORSKYDEV_DOTFILES=~/.local/share/horskydev/install/config/dotfiles
#
# # bashrc
# echo "configuring bash"
# curl -sS https://starship.rs/install.sh | sh
# echo "source ${HORSKYDEV_DOTFILES}/bash/.bashrc" >> "$HOME/.bashrc"
# cp "${HORSKYDEV_DOTFILES}/tmux/.tmux.conf" "$HOME/"

echo "cloning dotfiles..."
curl -sS https://starship.rs/install.sh | sh
git clone git@github.com:horskyyaron/awesome_dotfiles.git "$HOME/dotfiles"
