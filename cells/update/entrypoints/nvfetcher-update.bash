#!/usr/bin/env bash
cd "$(dirname "$@")"
# shellcheck disable=all
nvfetcher -c "$PRJ_ROOT/$@" -l /tmp/nvfetcher-changelog
# shellcheck disable=all
if [[ -n "$(cat /tmp/nvfetcher-changelog)" && -n "${GITHUB_ENV}" ]]; then
     echo "COMMIT_MSG<<EOF" >>"$GITHUB_ENV"
     echo "$(cat /tmp/nvfetcher-changelog)" >>"$GITHUB_ENV"
     echo "EOF" >>"$GITHUB_ENV"
fi
