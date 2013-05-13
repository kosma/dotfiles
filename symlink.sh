#!/bin/bash

set -e
shopt -s dotglob
shopt -s nullglob

for file in .[^.]?*; do
    case "$file" in
        *.swp) continue ;;
        .git) continue ;;
        .gitmodules) continue ;;
        .gitignore) continue ;;
    esac
    target="$HOME/$file"
    if ! [[ -e "$target" ]]; then
        target="$HOME/$file"
        echo "Install: $file -> $target"
        ln -s "$PWD/$file" "$target"
    elif [[ -L "$target" ]]; then
        echo "Skip: $file"
    else
        echo "ERROR: $file already exists and is not a symlink. Please move it out of the way."
        exit 1
    fi
done
