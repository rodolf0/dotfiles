#!/usr/bin/env bash
set -e
dotdir=$(cd "$(dirname $0)"; pwd)

while read cfg; do
  sfile="$(echo "$cfg" | sed 's/ *:.*$//; s/ *$//')"
  dfile="$(echo "$cfg" | sed 's/^.*: *//; s/^ *//')"
  if [ -e "$HOME/$dfile" ] && ! [[ "$@" =~ force ]]; then
    echo "Already exists: '$dfile', bailing"
    exit 1
  fi
  echo "ln -s '$dotdir/$sfile' '~/$dfile'"
  ln -fs "$dotdir/$sfile" "$HOME/$dfile"
done < "$dotdir/manifest"
