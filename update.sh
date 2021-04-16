#!/bin/bash

DIR=/home/devin/Repos/dotfiles

pacman -Qqe > ~/Pkglist.txt
shopt -s dotglob # enable dotglob

for file in $(find . -name "*" -type f); do
    echo "Copying $file"
    cp ~/$file $DIR/file
done > /dev/null 2>&1

rm -r $DIR/.config/nvim/lua
cp -r ~/.config/nvim/lua $DIR/.config/nvim/lua

rm -r $DIR/.config/scripts
cp -r ~/.config/scripts $DIR/.config/scripts

shopt -u dotglob # disable dotglob again

echo "Done"
