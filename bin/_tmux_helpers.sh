#!/usr/bin/env bash

start_tmux_session() {
    local session_name=$1
    local session_dir=$2
    local switch_after_create=${3:-true}
    local tmux_running

    tmux_running=$(pgrep tmux)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux -u new-session -s "$session_name" -c "$session_dir"
        exit 0
    fi

    if ! tmux has-session -t="$session_name" 2> /dev/null; then
        tmux -u new-session -ds "$session_name" -c "$session_dir"
        if [[ $switch_after_create == "false" ]]; then
            exit 0
        fi
    fi

    tmux switch-client -t "$session_name"
}
