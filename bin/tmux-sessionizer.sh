#!/usr/bin/env bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${script_dir}/_tmux_helpers.sh"

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
