#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

for module in $(ls ~/.bash_profile.d/ | sort); do
  source ~/.bash_profile.d/$module
done

#set +x
#exec 2>&3 3>&-

