#!/bin/bash
cd `dirname $0`

dotfilepath="$PWD/dotfiles"
now=$(date +%Y%m%d%H%M%S)
mkdir -p backups

files=$(find $dotfilepath -type f)
for file in $files; do
  basefile=$(echo $file | sed s#$dotfilepath/##g)
  echo "Installing ~/$basefile"
  if [ -f ~/$basefile ]; then
    backuppath="$PWD/backups/$basefile-$now"
    mkdir -p `dirname $backuppath`
    
    echo "Backing up ~/$basefile to $backuppath"
    cp ~/$basefile $backuppath

    echo "Removing old ~/$basefile"
    rm -f ~/$basefile
  fi

  if [ ! -d `dirname ~/$basefile` ]; then
    directory=$(dirname ~/$basefile)
    echo "Creating directory $directory"
    mkdir -p $directory 
  fi 

  echo "Linking $file to ~/$basefile"
  ln -s $file ~/$basefile
done

