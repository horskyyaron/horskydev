#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    if [[ "$(uname)" == "Linux" ]]; then
        # selected=$((find ~/personal ~/ -mindepth 1 -maxdepth 1 -type d )| fzf)


		selected=$(
			{
				find ~/personal -mindepth 1 -maxdepth 1 -type d ! -name '.*'
				find ~/projects -mindepth 1 -maxdepth 1 -type d ! -name '.*'
				find ~/work -mindepth 1 -maxdepth 1 -type d ! -name '.*'
			} | fzf
		)
    elif [[ "$(uname)" == "Darwin" ]]; then
	selected=$((find ~/personal ~/ -mindepth 1 -maxdepth 1 -type d && find ~/projects ~/ -mindepth 1 -maxdepth 2 -type d && find ~/moveo -type d -mindepth 1 -maxdepth 2 | fzf))
    else
        echo "Unsupported operating system"
    fi
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux -u new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux -u new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
