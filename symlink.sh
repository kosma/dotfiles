#!/bin/bash

set -e
shopt -s dotglob
shopt -s nullglob

# Use native symlinks on Windows
export MSYS="winsymlinks:nativestrict"

for file in .[^.]?*; do
    case "$file" in
        *.swp) continue ;;
        .git) continue ;;
        .gitmodules) continue ;;
        .gitignore) continue ;;
    esac

    target="$HOME/$file"

    if [[ -L "$target" ]]; then
        echo "Skip: $file"
	continue
    elif [[ -f "$target" ]]; then
        echo "Move: $file"
        mv "$target" "$target.dist"
    fi

    if ! [[ -e "$target" ]]; then
        echo "Install: $file -> $target"
        ln -s "$PWD/$file" "$target"
    else
        echo "ERROR: $file already exists and is not a symlink. Please move it out of the way."
        exit 1
    fi
done
