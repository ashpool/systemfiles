#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

refresh () { source ~/.bash_profile; }
pidof () { ps -Ac | egrep -i $@ | awk '{print $1}'; }

function add_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")" 
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
export PS1='\u@\h:\w$(parse_git_branch 2> /dev/null)\$ '

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

