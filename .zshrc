source ~/.config/zsh/antigen.zsh

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

vimmed() { 
    eval "$@" > /tmp/output_vimmed && nvim /tmp/output_vimmed
}

alias la="ls -a"
alias ktx="kitty tmux"
alias sudo-env="sudo -e env \"PATH=$PATH\""
alias dnfin="sudo dnf install"
alias reload="source ~/.config/zsh/.zshrc"

unset command_not_found_handle

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

export EDITOR=/usr/bin/nvim
export PAGER="/usr/bin/nvim -R"
export PATH=$PATH:~/.local/bin

eval "$(oh-my-posh init zsh --config /home/taham/.posh_themes/clean-detailed.omp.json)" 
