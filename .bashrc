#!/bin/bash
# shellcheck disable=SC1090
[[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh" --noattach

case $- in
*i*) ;; # interactive
*) return ;;
esac

# ------------------------- distro detection -------------------------

export DISTRO
[[ $(uname -r) =~ Microsoft ]] && DISTRO=WSL2 #TODO distinguish WSL1
#TODO add the rest

# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# ----------------------- environment variables ----------------------
#                           (also see envx)

export LANG=en_US.UTF-8 # assuming apt install language-pack-en done
export USER="${USER:-$(whoami)}"
export GITUSER="brynkii"
export FTP=242
export WEIGHT=83.7
export HEIGHT=174
export REPOS="$HOME/repos"
export GHREPOS="$REPOS/github/$GITUSER"
export DOTFILES="$HOME/dotfiles"
export SCRIPTS="$DOTFILES/.local/bin"
export SNIPPETS="$DOTFILES/.local/snippets"
export HELP_BROWSER=lynx
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export TEMPLATES="$HOME/Templates"
export PUBLIC="$HOME/Public"
export PRIVATE="$HOME/Private"
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
export VIDEOS="$HOME/Videos"
export WORKSPACES="$HOME/Workspaces" # container home dirs for mounting
export TERM=xterm-256color
export HRULEWIDTH=73
export EDITOR=nvim
export VISUAL=vi
export EDITOR_PREFIX=vi
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOPATH="$HOME/.local/share/go/"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
export CGO_ENABLED=0
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export CFLAGS="-Wall -Wextra -Werror -O0 -g -fsanitize=address -fno-omit-frame-pointer -finstrument-functions"

export LESS="-FXR"
export LESS_TERMCAP_mb="[35m" # magenta
export LESS_TERMCAP_md="[33m" # yellow
export LESS_TERMCAP_me=""      # "0m"
export LESS_TERMCAP_se=""      # "0m"
export LESS_TERMCAP_so="[34m" # blue
export LESS_TERMCAP_ue=""      # "0m"
export LESS_TERMCAP_us="[4m"  # underline

export ANSIBLE_CONFIG="$HOME/.config/ansible/config.ini"
export ANSIBLE_INVENTORY="$HOME/.config/ansible/inventory.yaml"
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
export MANPAGER="less -R --use-color -Dd+r -Du+b"
#export ANSIBLE_STDOUT_CALLBACK=json

#export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

[[ -d /.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

# ----------------------------- PostgreSQL ----------------------------

# export PGDATABASE=cowork

# -------------------------------- gpg -------------------------------

export GPG_TTY=$(tty)

# ------------------------------- pager ------------------------------

if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# ----------------------------- dircolors ----------------------------

if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# ------------------------------- path -------------------------------

pathappend() {
	declare arg
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//":$arg:"/:}
		PATH=${PATH/#"$arg:"/}
		PATH=${PATH/%":$arg"/}
		export PATH="${PATH:+"$PATH:"}$arg"
	done
} && export -f pathappend

pathprepend() {
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//:"$arg:"/:}
		PATH=${PATH/#"$arg:"/}
		PATH=${PATH/%":$arg"/}
		export PATH="$arg${PATH:+":${PATH}"}"
	done
} && export -f pathprepend

# remember last arg will be first in path
pathprepend \
	"$HOME/.local/bin" \
	"$HOME/.local/go/bin" \
	"$HOME/.nimble/bin" \
	"$GHREPOS/cmd-"* \
	"$HOME/.local/tools/nvim-linux64/bin" \
	"$HOME/.local/tools/.fzf/bin" \
	"$HOME/.cargo/bin" \
	/usr/local/go/bin \
	/usr/local/opt/openjdk/bin \
	/usr/local/bin \
	"$SCRIPTS"

pathappend \
	/usr/local/opt/coreutils/libexec/gnubin \
	'/mnt/c/Windows' \
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation' \
	/usr/local/bin \
	/usr/local/sbin \
	/usr/local/games \
	/usr/games \
	/usr/sbin \
	/usr/bin \
	/snap/bin \
	/sbin \
	/bin

# ------------------------------ cdpath ------------------------------

export CDPATH=".:$GHREPOS:$DOTFILES:$REPOS:/media/$USER:$HOME"

# ------------------------ bash shell options ------------------------

# shopt is for BASHOPTS, set is for SHELLOPTS

shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell

#shopt -s nullglob # bug kills completion for some
#set -o noclobber

# -------------------------- stty annoyances -------------------------

#stty stop undef # disable control-s accidental terminal stops
stty -ixon # disable control-s/control-q tty flow control

# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth:erasedups:ignorespace:ignoredups
export HISTSIZE=100000
export HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

set -o vi
shopt -s histappend


# ----------------------------- keyboard -----------------------------

# only works if you have X and are using graphic Linux desktop

_have setxkbmap && test -n "$DISPLAY" &&
	setxkbmap -option caps:escape &>/dev/null

# ------------------------------ aliases -----------------------------
#      (use exec scripts instead, which work from vim and subprocs)
      
unalias -a
alias todo='vi ~/.todo'
alias ip='ip -c'
alias '?'=duck
alias '??'=gpt
alias '???'=google
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias free='free -h'
alias df='df -h'
alias diff='diff --color'
alias sshh='sshpass -f $HOME/.sshpass ssh '
alias temp='cd $(mktemp -d)'
alias view='vi -R' # which is usually linked to vim
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias coin="xclip '(yes|no)'"
alias more="less"

# aliases for multiple directory listing commands
if [ -n "$(command -v eza 2>&1)" ]; then
	alias ls="eza -Ah --icons --color=always --group-directories-first --show-symlinks"
	alias la="eza -Alh --icons"
	alias lx='eza -lBh --icons --sort=extension'               # sort by extension
	alias lk='eza -lSh --icons --sort=size'               # sort by size
	alias lc='eza -lrh --icons --sort=changed'               # sort by change time
	alias lu='eza -lrh --icons --sort=accessed'               # sort by access time
	alias lr='eza -lRh --icons'                # recursive eza
	alias lt='eza -l --icons --sort=newest'               # sort by date
	alias lw='eza -xAh --icons'                # wide listing format
	alias ll='eza -l --icons --git --git-repos --changed --total-size'                # long listing format
	alias labc='eza -la --icons --sort=name --group-directories-first'              #alphabetical sort
	alias lfi='eza -f --icons'  # files only
	alias ldir='eza -D --icons'   # directories only
else
	alias la='ls -Alh'                # show hidden files
	alias ls='ls -aFh --color=always' # add colors and file type extensions
	alias lx='ls -lXBh'               # sort by extension
	alias lk='ls -lSrh'               # sort by size
	alias lc='ls -lcrh'               # sort by change time
	alias lu='ls -lurh'               # sort by access time
	alias lr='ls -lRh'                # recursive ls
	alias lt='ls -ltrh'               # sort by date
	alias lw='ls -xAh'                # wide listing format
	alias ll='ls -Fls'                # long listing format
	alias labc='ls -lap'              #alphabetical sort
	alias lfi="ls -l | egrep -v '^d'"  # files only
	alias ldir="ls -l | egrep '^d'"   # directories only
fi

# show all logs in /var/log 
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Alias's to show disk space and space used in a folder
alias folders='du -h --max-depth=1 2> /dev/null | awk \
  "/[0-9]+G/ {printf \"\033[31m%s\033[0m\n\", \$0} \
   /[0-9]+M/ {printf \"\033[32m%s\033[0m\n\", \$0} \
   /[0-9]+K/ {printf \"\033[97m%s\033[0m\n\", \$0} \
   !/[0-9]+[GMK]/ {print \$0}"'

alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'

# alias to modified commands 
alias ps='ps -auxf'
alias ping='ping -c 10'
alias mkdir='mkdir -p'
alias rm="trash -v"

# show open ports
alias openports='netstat -nape --inet'

# search
alias h="history | grep "  # search command-line history
alias f="find . | grep "   # search files in the current folder
alias hist="history | fzf --reverse --tac " # look at the command line history using fzf

# cat alias
if [ -n "$(command -v batcat 2>&1)" ]; then
	alias cat="batcat"
fi

# ----------------------------- functions ----------------------------

# lesscoloroff() {
#   while IFS= read -r line; do
#     unset ${line%%=*}
#   done < <(env | grep LESS_TERM)
# } && export -f lesscoloroff

# Extracts any archive(s)
ext ()
{
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.tar.xz)    tar xJf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.zst)       zstd -d "$1"   ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Copy and go to the directory
cpg() {
	if [ -d "$2" ]; then
		cp "$1" "$2" && cd "$2" || return;
	else
		cp "$1" "$2"
	fi
}

# Move and go to the directory
mvg() {
	if [ -d "$2" ]; then
		mv "$1" "$2" && cd "$2"  || return;
	else
		mv "$1" "$2"
	fi
}

# Create and go to the directory
mkdirg() {
	mkdir -p "$1"
	cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
	local d=""
	limit=$1
	for ((i = 1; i <= limit; i++)); do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd "$d" || return ;
}

# search for text in all files in the current folder
ftext() {
	# -i case-insensitive
	# -I ignore binary files 
	# -H causes filname to be printed
	# -r recursive search
	# -n causes the line number to be printed
	# optional: -F treat search term as literal, not a regular expression
	# optional: -l only print filenames and not the matching lines
	grep -iIHrn --color=always "$1" . | less -r
}

# show the current distribution
distribution() {
	local dtype="unknown" #Default to unknown

	# use /etc/os-release for modern distro identification
	if [ -r /etc/os-release ]; then
		source /etc/os-release
		case $ID in
			fedora|rhel|centos)
				dtype="redhat"
				;;
			sles|opensuse*)
				dtype="suse"
				;;
			ubuntu|debian)
				dtype="debian"
				;;
			gentoo)
				dtype="gentoo"
				;;
			arch)
				dtype="arch"
				;;
			slackware)
				dtype="slackware"
				;;
			*)
			# If ID is not recognized,keep dtype as unknown
			  ;;
		esac
	fi

	echo $dtype
}

# Show the current version of the operating system
ver() {
	local dtype
	dtype=$(distribution)

	case $dtype in
		"redhat")
			if [ -s /etc/redhat-release ]; then
				cat /etc/redhat-release
			else
				cat /etc/issue
			fi
			uname -a
			;;
		"suse")
			cat /etc/susE-release
			;;
		"debian")
			lsb_release -a
			;;
		"gentoo")
			cat /etc/gentoo-release
			;;
		"arch")
			cat /etc/os-release
			;;
		"slackware")
			cat /etc/slackware-version
			;;
		*)
			if [ -s /etc/issue ]; then
				cat /etc/issue
			else
				echo "Error: Unknown distribution"
				exit 1
			fi
			;;
	esac
}

# Show current network information
netinfo() {
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	/sbin/ifconfig | awk /'inet addr/ {print $4}'
	/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	myip=$(lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g')
	echo "${myip}"
	echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip() {
	# Dumps a list of all IP addresses for every device
	# /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

	### Old commands
	# Internal IP Lookup
	#echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'
	#
	#	# External IP Lookup
	#echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q

	# Internal IP Lookup.
	if [ -e /sbin/ip ]; then
		echo -n "Internal IP: "
		/sbin/ip addr show wlan0 | grep "inet " | awk -F: '{print $1}' | awk '{print $2}'
	else
		echo -n "Internal IP: "
		/sbin/ifconfig wlan0 | grep "inet " | awk -F: '{print $1} |' | awk '{print $2}'
	fi

	# External IP Lookup
	echo -n "External IP: "
	curl -s ifconfig.me
}

# ------------- Hardware information -----------------------------------
hwinfo() {
	sensors  # Needs: 'sudo apt-get install lm-sensors'
	uptime   # Needs: 'sudo apt-get install lsscsi'
	lsscsi
	free -h 
}

# Trim leading and trailing spaces (for scripts)
 trim() {
   local var=$*
   var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace char
   var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace cha
   echo -n "$var"\n
}


# ------------- source external dependencies / completion ------------

# for mac
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

owncomp=(
	pdf zet keg kn yt gl auth pomo config live iam sshkey ws x z clip
	./build build b ./k8sapp k8sapp ./setup ./cmd run ./run
	foo ./foo cmds ./cmds z bonzai openapi obs
)

for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done

_have gh && . <(gh completion -s bash)
_have glow && . <(glow completion  bash)
_have goreleaser && . <(goreleaser completion bash 2>/dev/null)
_have klogin && . <(klogin completion bash 2>/dev/null)
_have pandoc && . <(pandoc --bash-completion)
_have kubectl && . <(kubectl completion bash 2>/dev/null)
_have istioctl && . <(istioctl completion bash 2>/dev/null)
#_have clusterctl && . <(clusterctl completion bash)
_have k && complete -o default -F __start_kubectl k
_have kind && . <(kind completion bash)
_have kompose && . <(kompose completion bash)
_have helm && . <(helm completion bash)
_have minikube && . <(minikube completion bash)
_have conftest && . <(conftest completion bash)
_have mk && complete -o default -F __start_minikube mk
_have podman && _source_if "$HOME/.local/share/podman/completion" # d
_have docker && _source_if "$HOME/.local/share/docker/completion" # d
_have docker-compose && complete -F _docker_compose dc            # dc

_have ansible && . <(register-python-argcomplete3 ansible)
_have ansible-config && . <(register-python-argcomplete3 ansible-config)
_have ansible-console && . <(register-python-argcomplete3 ansible-console)
_have ansible-doc && . <(register-python-argcomplete3 ansible-doc)
_have ansible-galaxy && . <(register-python-argcomplete3 ansible-galaxy)
_have ansible-inventory && . <(register-python-argcomplete3 ansible-inventory)
_have ansible-playbook && . <(register-python-argcomplete3 ansible-playbook)
_have ansible-pull && . <(register-python-argcomplete3 ansible-pull)
_have ansible-vault && . <(register-python-argcomplete3 ansible-vault)
#_have ssh-agent && test -z "$SSH_AGENT_PID" && . <(ssh-agent)

# Enable bash programmable completion features in interactive shells 
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
elif [ -f $HOME/.local/share/bash_completion ]; then 
	. $HOME/.local/share/bash_completion
fi
# remember last arg will be first in path
pathprepend \
	"$HOME/.local/bin" \
	"$HOME/.local/go/bin" \
	"$HOME/.nimble/bin" \
	"$REPOS/cmd-"* \
	/usr/local/go/bin \
	/usr/local/opt/openjdk/bin \

# install zoxide 
eval "$(zoxide init bash)"

# install starship
eval "$(starship init bash)"

# fzf defaults
export FZF_DEFAULT_OPTS="-e -i --info=default --cycle --scroll-off=5 --preview-window=wrap --bind  'home:first,end:last'"

# Welcome message
fastfetch
echo -ne "Hello $USER It's "; kronos
echo -e "And now your moment of Zen:"; fortune

# Check if the shell is interactive
if [[ $- == *i* ]]; then
    # Bind Ctrl+f to insert 'zi' followed by a newline
    bind '"\C-f":"zi\n"'
fi

# installing Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"


# Configuring asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# Configuring direnv
eval "$(direnv hook bash)"

source /home/brian/.config/broot/launcher/bash/br

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH="/home/brian/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/brian/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
[[ ! ${BLE_VERSION-} ]] || ble-attach
