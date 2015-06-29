#!/bin/bash

# setup ssh keys on login
if [ ! -z $PS1 ]; then
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent -s`
    ssh-add
  fi
fi
