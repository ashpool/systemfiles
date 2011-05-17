#!/bin/bash
cd `dirname $0`

dotfilepath="$PWD/dotfiles"
now=$(date +%Y%m%d%H%M%S)
mkdir -p backups

files=$(find $dotfilepath -type f)
for file in $files; do
  basefile=$(echo $file | sed s#$dotfilepath/##g)
  echo "== [DOTFILE] installing ~/$basefile"

  link=$(readlink ~/$basefile)
  if [ "$link" == "$file" ]; then
    echo "   [NOLINK] ~/$basefile already linked to $file"
    echo -e
    continue
  fi

  if [ -f ~/$basefile ]; then
    backuppath="$PWD/backups/$basefile-$now"
    mkdir -p `dirname $backuppath`
    
    echo "   [BACKUP] ~/$basefile to $backuppath"
    cp ~/$basefile $backuppath

    echo "   [REMOVE] ~/$basefile"
    rm -f ~/$basefile
  fi

  if [ ! -d `dirname ~/$basefile` ]; then
    directory=$(dirname ~/$basefile)
    echo "   [CREATE DIR] $directory"
    mkdir -p $directory 
  fi 

  echo "   [LINK] $file ==> ~/$basefile"
  ln -s $file ~/$basefile
  echo -e
done


if [ -f ~/.gitlocal ]; then 
  echo "== [GIT] using local configuration"
  sed -i '' -e "/# GITLOCAL/r $HOME/.gitlocal" ~/.gitconfig
else
  echo "== [GIT] using default configuration"
  sed -i '' -e "/# GITLOCAL/r $HOME/.gitdefaults" ~/.gitconfig
fi

sed -i -e 's/^# GITLOCAL$//g' ~/.gitconfig

echo -e

if [ ! -f ~/.rvm/bin/rvm ]; then
  echo "== [RVM] installing"
  bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
  source ~/.bash_profile
fi
