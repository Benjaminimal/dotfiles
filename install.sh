#!/bin/bash
#---------------------------------------
#
# install.sh
#
#                   Benjamin Zinschitz
#
#
#   Back up existing dotfiles and
#   symlink these new ones
#
#---------------------------------------


dir=~/.dotfiles
olddir=~/.dotfiles_old
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
files=".vimrc .zshrc"

if [ ! -d $dir ]; then
    echo "Creating directory $olddir"
    mkdir $dir
    echo "Copying new dotfiles to $dir"
    for file in $files; do
        cp $scriptdir/$file $dir/$file
    done
fi

for file in $files; do
    if [ -e ~/$file ]; then
        if [ ! -d $olddir ]; then
            echo "Creating directory $olddir"
            mkdir -p $olddir
            cd $dir
        fi
        echo "Moving ~/$file to $olddir"
        mv ~/$file $olddir/
    fi
    echo "Creating symlink to $dir/$file"
    ln -s $dir/$file ~/$file
done
