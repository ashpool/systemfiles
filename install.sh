#!/bin/bash

do_vim=true
do_backup=true

while getopts ":nhb" opt; do
  case $opt in
    n)
      unset do_vim
      ;;
    b)
      unset do_backup
      ;;
    h)
      echo "Usage: $0 <options>"
      echo -e "  -b\tSkip backups"
      echo -e "  -n\tSkip vim bundle install"
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

if [ ! -f $HOME/.rvm/bin/rvm ]; then
  echo "== [RVM] installing"
  bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
  echo -e 
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

echo "== [BASH] Reloading"
source $HOME/.bash_profile
echo -e
echo "$skipped skipped, $linked linked, $backedup backed up, $dircreated dirs created"

