#!/usr/bin/env bash
# https://github.com/koalaman/shellcheck/wiki/SC2044
shopt -s globstar nullglob
for file in "$PRJ_ROOT"/.github/workflows/*
do
    sed -i 's|https://github.com/numtide/nix-.*./releases/download/nix-.*.|'"$nixVersion"'|' "$file"
done
