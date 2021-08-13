bunnyfetch
echo ""
if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
  source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
fi

# Fuzzy finding
zstyle ':completion:*' matcher-list "" \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

function top-dir() {
    (du -ah $1 | sort -n -r | head -n $2) 2>/dev/null
}
function search() {
    (find $1 -name "*$2*") 2>/dev/null
}
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
alias ls='ls -l --color=always'
alias grep='rg'
alias vim='nvim'
alias vi='nvim'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,underline"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit && compinit

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

HISTFILE="$HOME/.zsh/HISTFILE"
HISTSIZE=2000
SAVEHIST=2000
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
