#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

COL_BLUE="\x1b[34;01m"
COL_LIGHTBLUE="\x1b[36;01m"
COL_PURPLE="\x1b[35;01m"
COL_YELLOW="\x1b[33;01m"
COL_GREEN="\x1b[32;01m"
COL_RED="\x1b[31;01m"
COL_RESET="\x1b[39;49;00m"

refresh () { source ~/.bash_profile; }
pidof () { ps -Ac | egrep -i $@ | awk '{print $1}'; }

function add_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo -e "${COL_RED}-${COL_RESET}"
}

function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo -e "${COL_LIGHTBLUE}+${COL_RESET}"
}

function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo -e "${COL_YELLOW}*${COL_RESET}"
}

function parse_git_dirty {
    echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\ (\1$(parse_git_dirty))/"
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
export PS1='\u@\h:\w$(parse_git_branch)\$ '

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

