#!/bin/bash

HORSKYDEV_INSTALL_DIR=~/.local/share/horskydev/install

show_subtext() {
    local frame_rate=${3:-640}
    local effect=${2:-wipe}

    echo "$1" | tte --frame-rate "$frame_rate" "$effect"
    echo
}

show_logo() {
    local effect=${1:-expand}
    local frame_rate=${2:-120}

    clear
    tte -i "$HOME/.local/share/horskydev/logo.txt" --frame-rate "$frame_rate" "$effect"
    echo
}

# Development tools
show_logo beams 240
show_subtext "Installing terminal tools [1/2]"
source $HORSKYDEV_INSTALL_DIR/development/terminal.sh
source $HORSKYDEV_INSTALL_DIR/development/nvim.sh

# Configuration
show_logo decrypt 920
show_subtext "Configuring dotfiles [2/2]"
source $HORSKYDEV_INSTALL_DIR/config/config.sh
