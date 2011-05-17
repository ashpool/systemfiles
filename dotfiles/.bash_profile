#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

DULL=0
BRIGHT=1

FG_BLACK=30
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_BLUE=34
FG_VIOLET=35
FG_CYAN=36
FG_WHITE=37

FG_NULL=00

BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_VIOLET=45
BG_CYAN=46
BG_WHITE=47

BG_NULL=00

ESC="\033"
NORMAL="\[$ESC[m\]"
RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"

BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
RED="\[$ESC[${DULL};${FG_RED}m\]"
GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"


refresh () { source ~/.bash_profile; }
pidof () { ps -Ac | egrep -i $@ | awk '{print $1}'; }

function add_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "${RED}-${RESET}"
}

function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo "${CYAN}+${RESET}"
}

function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "${YELLOW}*${RESET}"
}

function parse_git_to_be_commited {
  [[ $(git status 2> /dev/null | grep "to be committed:") != "" ]] && echo "${VIOLET}x${RESET}"
}

function parse_git_dirty {
    echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)$(parse_git_to_be_commited)"
}

function parse_git_branch {
  git symbolic-ref HEAD &> /dev/null || return
  echo -n " ("$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* //")$(parse_git_dirty)")"
}

function hlocal {
  rm /usr/local/hadoop/conf
  ln -s /usr/local/hadoop/conf.local /usr/local/hadoop/conf
}

function hremote {
  rm /usr/local/hadoop/conf
  ln -s /usr/local/hadoop/conf.prod /usr/local/hadoop/conf
}

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add
}

# Hadoop stuff
export HADOOP_HOME=/usr/local/hadoop
export PIG_HOME=/usr/local/pig
export HIVE_HOME=/usr/local/hive
export JAVA_HOME=/Library/Java/Home

# Misc exports
export LSCOLORS="Fxgxcxdxbxegedabagacad"
export MANPATH=/opt/local/share/man:$MANPATH
export EDITOR='vim'
export RSPEC=true

# History
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000

# Prompt
PROMPT_COMMAND='PS1="\u@\h:\w$(parse_git_branch)\$ "'

# Paths
add_path ~/bin
add_path /usr/local/bin
add_path /usr/local/sbin
add_path /opt/local/bin
add_path /opt/local/sbin
add_path ${HADOOP_HOME}/bin 
add_path ${PIG_HOME}/bin
add_path ${HIVE_HOME}/bin

# Bash completion
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

SSH_ENV="$HOME/.ssh/environment"

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

# Aliases
alias ls='ls -G'
alias pruts='ssh wouter@pruts.nl'
alias scpresume="rsync --partial --progress --rsh=ssh"

#set +x
#exec 2>&3 3>&-

