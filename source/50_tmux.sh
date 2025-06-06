if [[ $- == *i* ]] && command -v "tmux" > /dev/null 2>&1; then
    TMUX_VERSION=$(tmux -V | sed -En "s/^tmux[^0-9]*([.0-9]+).*/\1/p")
    IFS=. read -r major minor <<< "$TMUX_VERSION"
    if [ "$major" -lt 2 ] || { [ "$major" -eq 2 ] && [ "$minor" -lt 1 ]; }; then
        alias tmux="tmux -f $DOTFILES/config/tmux/tmux-old.conf"
    fi

    # Alert if Tmux sessions are open
    num_sessions=`tmux list-sessions 2> /dev/null | wc -l`
    if [ "$?" -eq 0 ] && [ "$num_sessions" -gt 0 ] && [ ! "$TMUX" ]; then
        if [ "$num_sessions" -eq 1 ]; then
            echo "There is $((num_sessions)) Tmux session opened"
        else
            echo "There are $((num_sessions)) Tmux sessions opened"
        fi
    fi
fi
