#!/usr/bin/env bash

__MARKCACHE=$HOME/.marks

j-mark() {
  local path=$(readlink -f "$([ "$1" -a -d "$1" ] && echo "$1" || pwd)")
  echo "Bookmarking [$path]" >&2
  { cat "$__MARKCACHE"; echo "$path"; } | sort -u > "${__MARKCACHE}.tmp" &&
    mv -f "${__MARKCACHE}.tmp" "$__MARKCACHE"
}

j-unmark() {
  local path=$(cat "$__MARKCACHE" | fzf +m --height 15 -q "$*")
  if [ -z  "$path" ]; then
    echo "No mark found" >&2
    return
  fi
  grep -Fv "$path" "$__MARKCACHE" > "${__MARKCACHE}.tmp" &&
    mv -f "${__MARKCACHE}.tmp" "$__MARKCACHE"
}

j() {
  [ -f  "$__MARKCACHE" ] || {
    echo "No marks cache file found." >&2
    return
  }
  local path=$(cat "$__MARKCACHE" | fzf +m --height 15 -q "$*")
  [ -d "$path" ] && cd "$path" || cd "$(dirname "$path")" ||
    echo "Couldn't jump to [${path}]" >&2
}
