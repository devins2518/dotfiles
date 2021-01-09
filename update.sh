#!/bin/bash

shopt -s dotglob # enable dotglob

for file in $(find . -name "*" -type f); do
    echo "Copying $file"
    cp ~/$file ./$file
done 2>/dev/null

shopt -u dotglob # disable dotglob again

echo "Done"
