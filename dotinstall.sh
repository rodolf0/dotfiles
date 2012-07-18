#!/usr/bin/env bash

set -e

dotdir="$(dirname "$(readlink -f "$0")")"
dotbak="$(readlink -f ~/.dotbak-$(date +%F))"
mkdir -p "$dotbak"

while read f; do
  dst=~/."$(basename "$f")"
  if [ -e "$dst" ]; then
    echo "Backing up $f to $dotbak"
    mv "$dst" "$dotbak"/
  fi
  echo "Symlinking $dst"
  ln -s "$dotdir/$f" "$dst"
done < "$dotdir/manifest"


# vim: set sw=2 sts=2 : #
