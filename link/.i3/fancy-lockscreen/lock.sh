#!/bin/sh
i3lock -d --textcolor=ffffff00 --insidecolor=ffffff1c --ringcolor=ffffff3e --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 --insidevercolor=0000001c --ringwrongcolor=00000055 --insidewrongcolor=0000001c -p default -i ~/.i3/fancy-lockscreen/lockscreen.png 2> /dev/null
if [ $? -ne 0 ]; then # failed because of unsupported colors
    i3lock -d -c 000000 -p default -i ~/.i3/fancy-lockscreen/lockscreen.png
fi
