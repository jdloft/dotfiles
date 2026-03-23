# Key bindings
bind '"\e[H": beginning-of-line'        # Home
bind '"\e[F": end-of-line'              # End
bind '"\e[2~": overwrite-mode'          # Insert
bind '"\177": backward-delete-char'     # Backspace
bind '"\e[3~": delete-char'             # Delete
bind '"\e[A": history-search-backward'  # Up
bind '"\e[B": history-search-forward'   # Down
bind '"\e[D": backward-char'            # Left
bind '"\e[C": forward-char'             # Right
bind '"\e[5~": history-search-backward' # PageUp
bind '"\e[6~": history-search-forward'  # PageDown
bind '"\e[1;5D": backward-word'         # Ctrl-Left
bind '"\e[1;5C": forward-word'          # Ctrl-Right
bind '"\e[3;5~": kill-word'             # Ctrl-Delete
bind '"\C-h": backward-kill-word'       # Ctrl-Backspace

# Emacs mode
set -o emacs
