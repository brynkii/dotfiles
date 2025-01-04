# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit


## some simple aliases for ease of life
# # ex - archive extractor
# # usage: ex <file>
ext ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

## Golang export
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

# #rusty cargo

export PATH="$HOME/.local/share/cargo/bin:$PATH"

## starship config hope this works
eval "$(starship init zsh)"


# Adds ~/.local/bin and subfolders to $PATH
export PATH=$PATH:~/.local/bin


#aliases
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias '?'=duck
alias '???'=google

# zoxide
eval "$(zoxide init zsh)"


source /home/brian/.config/broot/launcher/bash/br

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
