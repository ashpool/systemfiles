#!/bin/bash
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
  echo "== [DOTFILE] installing ~/$basefile"

  link=$(readlink ~/$basefile)
  if [ "$link" == "$file" ]; then
    echo "   [NOLINK] ~/$basefile already linked correctly"
    echo -e
    ((skipped++))
    continue
  fi

  if [ -f ~/$basefile ]; then
    backuppath="$PWD/backups/$basefile-$now"
    mkdir -p `dirname $backuppath`
    
    echo "   [BACKUP] ~/$basefile to $backuppath"
    cp ~/$basefile $backuppath

    echo "   [REMOVE] ~/$basefile"
    rm -f ~/$basefile
    ((backedup++))
  fi

  if [ ! -d `dirname ~/$basefile` ]; then
    directory=$(dirname ~/$basefile)
    echo "   [CREATE DIR] $directory"
    mkdir -p $directory 
    ((dircreated++))
  fi 

  echo "   [LINK] $file ==> ~/$basefile"
  ln -sf $file ~/$basefile
  echo -e
  ((linked++))
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
  echo -e 
fi

echo "$skipped skipped, $linked linked, $backedup backed up, $dircreated dirs created"

