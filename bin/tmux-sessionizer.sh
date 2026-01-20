#!/usr/bin/env bash

select_directory() {
    case "$(uname)" in
        Linux)
            {
                find ~/personal -mindepth 1 -maxdepth 1 -type d ! -name '.*'
                find ~/projects -mindepth 1 -maxdepth 1 -type d ! -name '.*'
                find ~/work -mindepth 1 -maxdepth 1 -type d ! -name '.*'
            } | fzf
            ;;
        Darwin)
            {
                find ~/personal ~/ -mindepth 1 -maxdepth 1 -type d
                find ~/projects ~/ -mindepth 1 -maxdepth 2 -type d
                find ~/moveo -type d -mindepth 1 -maxdepth 2
            } | fzf
            ;;
        *)
            echo "Unsupported operating system"
            return 1
            ;;
    esac
}

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
    fi

    tmux switch-client -t "$session_name"
}

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(select_directory) || exit 0
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

start_tmux_session "$selected_name" "$selected"
