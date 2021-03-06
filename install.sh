#!/bin/bash


function usage() {
  cat<<EOF
Usage: $0 <options>
  -b        Skip backups
  -v        Skip vim bundle install
  -r        Skip rvm install
  -h        <- This ;-)
EOF
}

os=${OSTYPE//[0-9.]/} #Strip off numbers because of darwin version number

do_vim=true
do_backup=true
do_rvm=true
do_brew=true

while getopts ":vbrh" opt; do
  case $opt in
    v)
      unset do_vim
      ;;
    b)
      unset do_backup
      ;;
    r)
      unset do_rvm
      ;;
    w)
      unset do_brew
      ;;
    h)
      usage
      exit
      ;;
  esac
done

cd `dirname $0`

dotfilepath="$PWD/dotfiles"
now=$(date +%Y%m%d%H%M%S)
mkdir -p backups

skiped=0
linked=0
backedup=0
dircreated=0

files=$(find $dotfilepath -type f)
for file in $files; do
  basefile=$(echo $file | sed s#$dotfilepath/##g)
  homefile="$HOME/$basefile"
  echo "== [DOTFILE] installing $homefile"

  link=$(readlink $homefile)
  if [ "$link" == "$file" ]; then
    echo "   [NOLINK] $homefile already linked correctly"
    echo -e
    ((skipped++))
    continue
  fi

  if [ $backup ]; then
    if [ -f $homefile ]; then
      backuppath="$PWD/backups/$basefile-$now"
      mkdir -p `dirname $backuppath`
      
      echo "   [BACKUP] $homefile to $backuppath"
      cp $homefile $backuppath

      echo "   [REMOVE] $homefile"
      rm -f $homefile
      ((backedup++))
    fi
  fi

  if [ ! -d `dirname $homefile` ]; then
    directory=$(dirname $homefile)
    echo "   [CREATE DIR] $directory"
    mkdir -p $directory 
    ((dircreated++))
  fi 

  echo "   [LINK] $file ==> $homefile"
  ln -sf $file $homefile
  echo -e
  ((linked++))
done

if [ -f $HOME/.gitlocal ]; then 
  echo "== [GIT] using local configuration"
  sed -i '' -e "/# GITLOCAL/r $HOME/.gitlocal" $HOME/.gitconfig
else
  echo "== [GIT] using default configuration"
  sed -i '' -e "/# GITLOCAL/r $HOME/.gitdefaults" $HOME/.gitconfig
fi

sed -i -e 's/^# GITLOCAL$//g' $HOME/.gitconfig

echo -e

if [ $os == "darwin" ]; then
  if [ $do_brew ]; then
    if [ ! -f /usr/local/bin/brew ]; then
      echo "== [BREW] installing"
      /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
      echo -e 
    fi
  fi
fi

if [ $do_rvm ]; then 
  if [ ! -f $HOME/.rvm/bin/rvm ]; then
    echo "== [RVM] installing"
    bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    echo -e 
  fi
fi

if [ ! -d ~/.vim/bundle/vundle ]; then
  echo "== [VUNDLE] installing"
  mkdir -p ~/.vim/bundle
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  echo -e
fi

if [ $do_vim ]; then
  echo "== [VIM] Vundle update"
  vim +BundleInstall! +BundleClean +q
  echo -e 
fi

# Make sure ssh file have the right permissions
chmod 600 $HOME/.ssh/*

echo "== [BASH] Reloading"
source $HOME/.bash_profile
echo -e
echo "$skipped skipped, $linked linked, $backedup backed up, $dircreated dirs created"
