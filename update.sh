#!/bin/bash

pacman -Qqe > ~/Pkglist.txt
shopt -s dotglob # enable dotglob

for file in $(find . -name "*" -type f); do
    echo "Copying $file"
    cp ~/$file ./$file
done > /dev/null 2>&1

rm -r .config/nvim/lua
cp -r ~/.config/nvim/lua .config/nvim/lua

shopt -u dotglob # disable dotglob again

echo "Done"
