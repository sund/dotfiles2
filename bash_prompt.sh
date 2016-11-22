# bash prompt

###
## variables
#
atHost=$(echo -e -n "\x40") # at host symbol
inDir="in"
#inDir=$(echo -e -n "\xF0\x9F\x93\x82 ") # in directory symbol
gitChanges="±" # symbol for git changes

###
## functions
#

function parse_git_dirty() {

  [[ $(git status 2> /dev/null | tail -n1) != *nothing\ to\ commit* ]] && echo "$gitChanges"

}

function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

###
## what are our terminal abilites?
#

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
	# are we ever going to enocunter a terminal with this many?
		RED=$(tput setaf 1)
		ORANGE=$(tput setaf 172)
		YELLOW=$(tput setaf 3)
		GREEN=$(tput setaf 190)
		BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 9)
		PURPLE=$(tput setaf 141)
    WHITE=$(tput setaf 0)
	else
		RED=$(tput setaf 1)
		ORANGE=$(tput setaf 3)
		YELLOW=$(tput setaf 11)
		GREEN=$(tput setaf 2)
		BLUE=$(tput setaf 4)
		MAGENTA=$(tput setaf 5)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)

	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else

	RED="\033[0;31m"
	ORANGE="\033[1;33m" # or bold yellow
	YELLOW="\033[0;33m"
	GREEN="\033[0;32m"
	BLUE="\033[0;34m"
	MAGENTA="\033[0;35m"
	PURPLE="\033[1;36m" # more bold cyan than purple
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"

fi

export RED
export ORANGE
export YELLOW
export GREEN
export BLUE
export MAGENTA
export PURPLE
export WHITE
export BOLD
export RESET

#
##
###

###
## finally the prompt
#

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]$atHost \[$PURPLE\]\h \[$WHITE\]$inDir \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\l \# \$ \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"
export SUDO_PS1="\[$ORANGE\]\u $( echo -e "\xE1\x90\x85") \h → \w $( echo -e "\xE1\x90\x89")  \[$RESET\]"
