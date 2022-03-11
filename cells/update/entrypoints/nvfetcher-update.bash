#!/usr/bin/env bash
cd "$(dirname "$@")"
# shellcheck disable=all
nvfetcher -c "$PRJ_ROOT/$@" -l changelog
# shellcheck disable=all
if [ -n "$(cat changelog)" ]; then
    if [ -n "${GITHUB_ENV}" ]; then
        echo "COMMIT_MSG<<EOF" >>"$GITHUB_ENV"
        echo "$(cat changelog)" >>"$GITHUB_ENV"
        echo "EOF" >>"$GITHUB_ENV"
    fi
    rm -rf changelog
else
    rm -rf hangelog
fi
