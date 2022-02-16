#!/usr/bin/env bash
for path in $(find "$PRJ_ROOT/.github/workflows" -type f)
do
    sed -i 's|https://github.com/numtide/nix-.*./releases/download/nix-.*.|'"$nixVersion"'|' $path
done
