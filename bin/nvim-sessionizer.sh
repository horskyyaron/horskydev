#!/usr/bin/env bash

start_tmux_session() {
    local session_name=$1
    local session_dir=$2
    local tmux_running

    tmux_running=$(pgrep tmux)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux -u new-session -s "$session_name" -c "$session_dir"
        exit 0
    fi

    if ! tmux has-session -t="$session_name" 2> /dev/null; then
        tmux -u new-session -ds "$session_name" -c "$session_dir"
        exit 0
    fi

    tmux switch-client -t "$session_name"
}

selected="$HOME/.config/horskyvim/"
selected_name=$(basename "$selected" | tr . _)

start_tmux_session "$selected_name" "$selected"
