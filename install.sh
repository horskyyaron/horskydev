#!/bin/bash

YARON_DEV_INSTALL=~/personal/horskydev/install

show_subtext() {
  echo "$1" | tte --frame-rate ${3:-640} ${2:-wipe}
  echo
}

show_logo() {
  clear
  tte -i ./logo.txt --frame-rate ${2:-120} ${1:-expand}
  echo
}

# Development tools
# show_logo beams 240
# show_subtext "Installing terminal tools [1/2]"
# source $YARON_DEV_INSTALL/development/terminal.sh
# source $YARON_DEV_INSTALL/development/nvim.sh

# Configuration
show_logo decrypt 920
show_subtext "Configuring dotfiles [2/2]"
source $YARON_DEV_INSTALL/config/config.sh
