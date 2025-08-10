# alias vim='NVIM_APPNAME=adventofnvim nvim'
alias vim=nvim
eval "$(starship init bash)"

# TODO:
# need to add script that will create a bin folder and add it to path.
# copy the tmux-sessionizer script into it

# alias vim=NVIM_APPNAME=horskyvim nvim
# alias nvim=NVIM_APPNAME=horskyvim nvim

# alias vim='nvim'
alias vim='NVIM_APPNAME=horskyvim nvim'


export PATH=$PATH:$HOME/.local/share/horskydev/bin

# zsh syntax
# bindkey -s ^f "tmux-sessionizer\n"

# bash syntax
bind '"\C-f":"tmux-sessionizer.sh\n"'
bind '"\C-n":"nvim-sessionizer.sh\n"'
