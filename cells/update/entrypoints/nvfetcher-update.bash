#!/usr/bin/env bash
# shellcheck disable=all
nvfetcher -c "$PRJ_ROOT/$@" -l nvfetcher-changelog
# shellcheck disable=all
if [[ -n "$(cat nvfetcher-changelog)" && -v "${GITHUB_ENV}" ]]; then
	echo "COMMIT_MSG<<EOF" >>"$GITHUB_ENV"
	echo "$(cat nvfetcher-changelog)" >>"$GITHUB_ENV"
	echo "EOF" >>"$GITHUB_ENV"
	rm -rf "$PRJ_ROOT"/nvfetcher-changelog
else
	rm -rf "$PRJ_ROOT"/nvfetcher-changelog
fi
