if [ "$CLOUD_SHELL" = true ]; then
    export NO_SOLAR=true
    export NO_TMUXLINE=true
elif [ "$TERM_PROGRAM" = "Lens" ]; then
    export NO_SOLAR=true
elif [ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" ]; then
    export NO_SOLAR=true
fi
