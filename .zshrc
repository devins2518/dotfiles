# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias pacupdate="pacman -Qqe > ~/Pkglist.txt"
alias vim=nvim
alias flamegraph=flamegraph.pl
alias temps='sensors | grep coretemp -A 5'
alias pacdate='~/.config/scripts/pacdate'
# Do neofetch on startup
ufetch

# Fuzzy finding
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/HISTFILE
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/devin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR=nvim
export VISUAL=nvim

alias ls="ls -l --color=always"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

function top-dir() {
    (du -ah $1 | sort -n -r | head -n $2) 2>/dev/null
}
function search() {
    (find $1 -name "*$2*") 2>/dev/null
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
