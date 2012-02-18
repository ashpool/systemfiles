#PS4='+ $(gdate "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

#for module in $(find ~/.bash_profile.d ! -type d | sort); do
#  source $module
#done

if [ -d ~/.bash_profile.d ]; then
    for i in ~/.bash_profile.d/*; do
        if [ -r $i ]; then
            . $i
        fi
    done
    unset i
fi


#set +x
#exec 2>&3 3>&-

