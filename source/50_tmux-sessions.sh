# Alert if Tmux sessions are open
if command -v "tmux" > /dev/null 2>&1; then
    num_sessions=`tmux list-sessions 2> /dev/null | wc -l`
    if [ "$?" -eq 0 ]; then
        echo "There are $((num_sessions)) Tmux sessions opened"
    fi
fi
