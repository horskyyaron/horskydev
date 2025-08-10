#!/usr/bin/env bash

selected="$HOME/.config/horskyvim/"
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# if tmux isn't running, create new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux -u new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux -u new-session -ds $selected_name -c $selected
	exit 0
fi

tmux switch-client -t $selected_name
