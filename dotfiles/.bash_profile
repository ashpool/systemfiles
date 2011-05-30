#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

for module in $(find ~/.bash_profile.d ! -type d | sort); do
  source $module
done

#set +x
#exec 2>&3 3>&-

