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

dotfiles_dir="$HOME/dotfiles"

if [[ -d "$dotfiles_dir" ]]; then
    timestamp=$(date +"%Y-%m-%d_%H%M%S")
    backup_dir="$HOME/dotfiles_bak_${timestamp}"
    echo "backing up existing dotfiles to ${backup_dir}"
    mv "$dotfiles_dir" "$backup_dir"
fi

echo "cloning dotfiles..."
git clone git@github.com:horskyyaron/awesome_dotfiles.git "$dotfiles_dir"

if ! cd "$dotfiles_dir"; then
    echo "failed to enter dotfiles directory"
    exit 1
fi

echo "stowing dotfiles"
for path in */; do
    dir_name=${path%/}
    echo "stowing ${dir_name}"
    stow "$dir_name"
done
