#!/bin/bash

set -e

if [[ "$PWD" != "$HOME/dotfiles" ]]; then
    echo "This repository must be cloned in ~/dotfiles." 1>&2
    exit 1
fi

shopt -s dotglob
shopt -s nullglob

for file in .[^.]?*; do
    case "$file" in
        *.swp) continue ;;
        .git) continue ;;
    esac
    target="$HOME/$file"
    if ! [[ -e "$target" ]]; then
        target="$HOME/$file"
        echo "Install: $file -> $target"
        ln -s "dotfiles/$file" "$target"
    elif [[ -L "$target" ]]; then
        echo "Skip: $file"
    else
        echo "ERROR: $file already exists and is not a symlink. Please move it out of the way."
        exit 1
    fi
done
