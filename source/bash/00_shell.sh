#
# Shell options
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#

shopt -s globstar >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -u mailwarn >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1
shopt -s extglob

test -f /etc/bash_completion && . /etc/bash_completion

#
# Environment
#

: ${HOME=~}
: ${UNAME=$(uname)}

export HISTCONTROL=ignorespace:erasedups
export HISTSIZE=1000
export HISTFILESIZE=2000

# Sort dotfiles before "a" in ls(1) and sort(1) (http://superuser.com/a/448294/164493)
export LC_COLLATE="C"

#
# Colors
#

if [ -x /usr/bin/dircolors ]
then
    eval "`dircolors -b`"
fi

# Colors http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/
if [[ $- == *i* ]]
then
    CLR_NONE=`tput sgr0`
    CLR_LINE=`tput smul`
    CLR_BOLD=`tput bold`
    CLR_BLACK=`tput setaf 0`
    CLR_RED=`tput setaf 1`
    CLR_GREEN=`tput setaf 2`
    CLR_YELLOW=`tput setaf 3`
    CLR_BLUE=`tput setaf 4`
    CLR_MAGENTA=`tput setaf 5`
    CLR_CYAN=`tput setaf 6`
    CLR_WHITE=`tput setaf 7`
fi

#
# Misc
#

export EDITOR=vim

export VIRTUAL_ENV_DISABLE_PROMPT=1

#
# Setup functions
#

PROMPT_COMMAND="_dotfiles-prompt"
