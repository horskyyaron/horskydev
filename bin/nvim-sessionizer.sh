#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${script_dir}/_tmux_helpers.sh"

selected="$HOME/.config/horskyvim/"
selected_name=$(basename "$selected" | tr . _)

start_tmux_session "$selected_name" "$selected" "false"
