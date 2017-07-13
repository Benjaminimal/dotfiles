#!/bin/bash
#---------------------------------------
# install.sh
#   Installs dotfiles
#---------------------------------------

dir=~/dotfiles
olddir=~/.dotfiles_old
files=".vimrc .zshrc"

echo "Creating $olddir for backup of existing dotfiles in ~"
mkdir -p $olddir

cd $dir

for file in $files; do
    echo "Moving $file from ~ to $olddir"
    mv ~/$file $olddir/
    echo "Creating symlink to $file in ~"
    ln -s $dir/$file ~/$file
done
