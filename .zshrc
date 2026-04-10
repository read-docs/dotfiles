export EDITOR="nvim"
export VISUAL="nvim"

# Kolory i aliasy
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias git_personal='git config --global user.email "moossotimoteo@gmail.com" && git config --global user.name "megawonzz9"'
alias git_school='git config --global user.email "u69_tymmos_lbn@technischools.com" && git config --global user.name "read-docs"'

alias ll='ls -alF'
alias cls='clear'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cr='cargo run'
alias nasm64='func(){ nasm -f elf64 "$1.asm" -o "$1.o" && ld "$1.o" -o "$1" && ./"$1"; }; func'

alias vi='vim'
alias nivm='nvim'
alias vim='nvim'

# Prompt
PROMPT='%n@%m:%~%# '

# Środowisko
. "$HOME/.cargo/env"
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/go/bin"


export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# opencode
export PATH=/home/tmk/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/home/tmk/.bun/_bun" ] && source "/home/tmk/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
