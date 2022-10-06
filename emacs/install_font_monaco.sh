#!/usr/bin/env bash

# idempotency
[[ -f ~/.fonts/Monaco-Linux.ttf ]] && exit 0



URL=https://github.com/hbin/top-programming-fonts/raw/master/Monaco-Linux.ttf
SHA256=3591226486df72fcb901b83565077bf05da5e9f809a7c94bca76593e5aa9805a
TMPFILE=$(mktemp)

curl -L -o "$TMPFILE" "$URL"
echo "$SHA256 $TMPFILE" | sha256sum --check

if [[ $? -ne 0 ]] ; then
    echo "sha256 doesn't match"
    rm "$TMPFILE"
    exit 1
fi

mkdir -p ~/.fonts
mv "$TMPFILE" ~/.fonts/Monaco-Linux.ttf
fc-cache -f -v
