#!/usr/bin/env bash
cd "$(dirname "$@")"
# shellcheck disable=all
nvfetcher -c "$PRJ_ROOT/$@" -l nvfetcher-changelog
# shellcheck disable=all
if [[ -n "$(cat nvfetcher-changelog)" && -n "${GITHUB_ENV}" ]]; then
     echo "COMMIT_MSG<<EOF" >>"$GITHUB_ENV"
     echo "$(cat changelog)" >>"$GITHUB_ENV"
     echo "EOF" >>"$GITHUB_ENV"
    rm -rf nvfetcher-changelog
else
    rm -rf nvfetcher-changelog
fi
