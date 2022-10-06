#!/usr/bin/env bash

# idempotency
[[ -f ~/.emacs-profiles.el ]] && exit 0



# download zip and check hash of a specific commit of this:
# https://github.com/plexus/chemacs2

# latest at the time
COMMIT=d722459287566e8c91ae077bf3d65966ebece190
SHA256=97a3300e1a95fcc6f7174ef24a47913ae83c0ec80e17f8d9fe5a452f09f2d35b



TMPFILE=$(mktemp --suffix=.zip)
TMPDIR=$(mktemp -d)
BACKUP=$(mktemp -u ~/.emacs.d.backup-XXXXXX)

[[ -d ~/.emacs.d ]] && [[ ! -f ~/.emacs.d/chemacs.el ]] && mv ~/.emacs.d "$BACKUP"

curl -L -o "$TMPFILE" "https://github.com/plexus/chemacs2/archive/$COMMIT.zip"
echo "$SHA256 $TMPFILE" | sha256sum --check
if [[ $? -ne 0 ]] ; then
    echo "sha256 doesn't match"
    exit 1
fi
    

# here we manually do an equivalent of --strip-components=1, which unzip doesn't support
unzip "$TMPFILE" -d "$TMPDIR"
F=("$TMPDIR"/*)   # F[0] now is the prefix we want to get rid of
(( ${#F[@]} == 1 )) && [[ -d "${F[0]}" ]] && mv "${F[0]}" ~/.emacs.d

rm "$TMPFILE"


if [[ ! -f ~/.emacs-profiles.el ]] ; then
  echo '(("default" . ((user-emacs-directory . "~/.emacs.d.old"))))' >> ~/.emacs-profiles.el
fi 







# TODO: catch exceptions


# TODO: check if $COMMIT is the last commit
# $ curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/plexus/chemacs2/commits/main/branches-where-head
# [
#   {
#     "name": "main",
#     "commit": {
#       "sha": "d722459287566e8c91ae077bf3d65966ebece190",
#       "url": "https://api.github.com/repos/plexus/chemacs2/commits/d722459287566e8c91ae077bf3d65966ebece190"
#     },
#     "protected": false
#   }
# ]

