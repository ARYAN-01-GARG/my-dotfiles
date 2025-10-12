# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="daveverwer"

plugins=(
    git
    archlinux
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
#----------------------------------------------------------------

# Set-up icons for files/directories in terminal using lsd
alias ls='exa --no-filesize --color=always --icons=always --no-user'
alias l='ls -l'
alias la='ls -a'
alias lt='ls --tree' 
alias lla='ls -la'
alias cd='z'

#----------------------------------------------------------------

# fuzzy find commands
alias cdh='z $(find ~ -maxdepth 4 -type d -not -path "*/node_modules*" -not -path "*/.git/*" -not -path "*/logs" -not -path "*/target"  -not -path "*/venv"| fzf --height=70% --preview="exa -T --color=always {}")'
alias cdf='z $(find . -maxdepth 4 -type d -not -path "*/node_modules*" -not -path "*/.git" -not -path "*/logs" -not -path "*/target"  -not -path "*/venv"| fzf --height=70% --preview="exa -T --color=always {}")'
alias ff='nvim $(fzf --preview="bat --color=always {}")'
alias codef='code $(find ~ -maxdepth 4 -type d -not -path "*/node_modules*" -not -path "*/logs" -not -path "*/.git" -not -path "*/target"  -not -path "*/venv"| fzf)'
alias nf='nvim $(find ~ -maxdepth 4 -type d -not -path "*/node_modules*" -not -path "*/logs" -not -path "*/.git" -not -path "*/target"  -not -path "*/venv"| fzf)'

#----------------------------------------------------------------

# git aliases for speed commands
alias ga='git add .'
alias gcm='git commit -m'
alias gs='git status'
alias gsw='git switch'
alias gpush='git push'
alias gpull='git pull'
alias gl='git log --oneline --graph --all --parents'

#----------------------------------------------------------------

# zoxide base search
alias nzo='~/.scripts/search_by_zoxide.sh'
alias zd='~/.scripts/search_dir_zoxide.sh'

#----------------------------------------------------------------

# gh authentication
alias ghsw='gh auth switch --user'
alias ghst='gh auth status'



#----------------------------------------------------------------

# basic aliases for linux command
alias c='clear'
alias e='exit'
alias h='cd ~'

alias lg='lazygit'
alias n='nvim'
alias t='~/.scripts/tmux_start.sh'

#----------------------------------------------------------------

alias dmu='yt-dlp -x --audio-format mp3'
alias vres='yt-dlp -F'

#----------------------------------------------------------------

# open docs fman 
alias fman='compgen -c | fzf | xargs man'

#----------------------------------------------------------------

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

#----------------------------------------------------------------

# zoxide setup
eval "$(zoxide init zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicate commands
setopt HIST_REDUCE_BLANKS     # trim unnecessary spaces

#----------------------------------------------------------------

# bun completions
[ -s "/home/aryan/.bun/_bun" ] && source "/home/aryan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
