#!/usr/bin/env bash

[[ -f ~/.emacs.d.old/init-agenda.el ]] && echo "the repo seems to be deployed" && exit 0

cd ~
git clone git@github.com:koddo/.emacs.d.old.git
cd ~/.emacs.d.old
ln -s init-preinit-linux.el init-preinit-softlink.el
