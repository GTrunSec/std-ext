#!/usr/bin/env bash
cd $(dirname "$@")
nvfetcher -c $PRJ_ROOT/"$@" -l changelog
if [ ! -z "$(cat changelog)" ]; then
    if [ ! -z "${GITHUB_ENV}" ]; then
        echo "COMMIT_MSG<<EOF" >>$GITHUB_ENV
        echo "$(cat changelog)" >>$GITHUB_ENV
        echo "EOF" >>$GITHUB_ENV
    fi
    rm -rf changelog
else
    rm -rf changelog
fi
