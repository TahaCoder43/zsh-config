source ~/.config/zsh/antigen.zsh
source ~/.coords

# third party bundles.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

unset command_not_found_handle

# . "$HOME/.cargo/env"

export EDITOR=/usr/bin/nvim
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin/
export XDG_CONFIG_HOME=/home/$USER/.config/

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/my-themes/bubblescustom.omp.json)" 

vimmed() {
    eval "$@" > /tmp/output_vimmed && cd /tmp && nvim output_vimmed
}

side_btop() {
    kitty --class=kitty_btop -T btop sh -c "btop" # I have my kde plasma configured such that any window with class kitty_btop, will be put in a specific place
                                                  # and once btop closes his kitty window will close too
}

load-env() {
    for line in $(cat .env); do
        export $line;
    done
}

alias la="ls -a"
alias ktx="kitty tmux"
alias vi="nvim"
alias sudo-env="sudo -E env \"PATH=$PATH\""
alias reload="source ~/.config/zsh/.zshrc"
#alias blender="LIBGL_ALWAYS_SOFTWARE=1 blender"
