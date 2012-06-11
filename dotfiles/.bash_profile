#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

specific=".bash_system_specific"

if [ ! -f ${specific} ]; then
  touch $HOME/$specific
fi

source $HOME/$specific

for module in $(find ~/.bash_profile.d ! -type d | sort); do
  source $module
done


#set +x
#exec 2>&3 3>&-


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
