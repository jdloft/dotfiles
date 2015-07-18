#!/bin/bash
# starts tmux, etc.

if [[ ! -z $PS1 ]]; then
    if [[ -z $TMUX ]]; then
        if [ "$DOTFILES_HOST" = "hydrogen" ]; then
            SESSIONS="main"
        elif [ "$DOTFILES_HOST" = "tools-bastion-01.tools.eqiad.wmflabs" ]; then
            SESSIONS="tools"
        fi

        function go-session {
            tmux has-session -t $1 > /dev/null 2>&1
            if [ "$?" -eq 1 ]; then
                session-$1
            fi
            tmux attach -t $1 && exit
        }

        # Sessions
        function session-main {
            tmux new-session -d -s main
            tmux new-window -d -t main:9 -n dotfiles 'dotfiles'
        }

        function session-tools {
            tmux new-session -d -s tools
            tmux new-window -d -t tools:9 -n dotfiles 'dotfiles'
        }

        # Do stuff
        for x in $SESSIONS
        do
            go-session $x
        done
    fi
fi
