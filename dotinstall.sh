#!/usr/bin/env bash
set -e

dotdir=$(cd "$(dirname $0)"; pwd)
dotbak=~/.dotbak-$(date +%F)
mkdir -p "$dotbak"

while read f; do
  dst=~/".$f"
  if [ -e "$dst" ]; then
    echo "Backing up $f to $dotbak"
    mv "$dst" "$dotbak"/
  fi
  echo "Symlinking $dst to $dotdir/$f"
  ln -s "$dotdir/$f" "$dst"
done < "$dotdir/manifest"
