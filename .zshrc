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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

export EDITOR=/usr/bin/nvim
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin/
export PATH=$PATH:~/Softwares/Python/bin
export XDG_CONFIG_HOME=/home/$USER/.config/

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/my-themes/bubblescustom.omp.json)" 

# printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'

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

py() {
    local command=$1
    shift

    if [[ -e /home/taham/Softwares/Python/bin/$command ]]; then
        /home/taham/Softwares/Python/bin/$command $@
    else
        echo "py command not found '$command'"
    fi
}

get-total-size() {
    rm -rf /tmp/dependencies-size.csv
    touch /tmp/dependencies-size.csv

    get-dependencies-size $1

    awk 'BEGIN { sum_size=0; } {
    switch ($NF) {
        case "KiB":
            size = $(NF-1) / 1024
            break
        case "MiB":
            size = $(NF-1)
            break
    }
    sum_size += size
    } END { print sum_size "MiB" }' /tmp/dependencies-size.csv

    rm -rf /tmp/dependencies-size.csv
}

get-dependencies-size() {
    apk info --depends $1 | {
        read get_lost
        while read package; do
            read installed < <(apk info --installed $package)
            if [[ $installed == "" ]]; then # if not installed
                { read get_lost; read size; } < <(apk info --size $package)
                echo $package: $size >> /tmp/dependencies-size.csv
            fi
        done
    }
}

alias la="ls -a"
alias ktx="kitty tmux"
alias sudo-env="sudo -E env \"PATH=$PATH\""
alias dnfin="sudo dnf install"
alias reload="source ~/.config/zsh/.zshrc"
alias pyrepl="py ptpython --vi"
alias blender="LIBGL_ALWAYS_SOFTWARE=1 blender"
