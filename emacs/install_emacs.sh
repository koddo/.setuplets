#!/usr/bin/env bash

if [[ -n "$(find -H /var/lib/apt/periodic/update-success-stamp -mmin +10)" ]] ; then
  apt update      # not too often
fi

# -y doesn't re-install if installed, but does update
apt install -y emacs


