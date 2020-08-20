if [ "$CLOUD_SHELL" = true ]; then
    export NO_SOLAR=true
    export NO_TMUXLINE=true
elif [ "$TERM_PROGRAM" = "Lens" ]; then
    export NO_SOLAR=true
fi
