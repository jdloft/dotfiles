#!/bin/sh
cd ~/.i3/fancy-lockscreen/i3lock-color
sudo apt-get install pkg-config libx11-dev libpam0g-dev libcairo2-dev libxcb1-dev libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev libev-dev libxcb-xinerama0-dev libxkbcommon-dev libxkbfile-dev libx11-xcb-dev libxcb-keysyms1-dev
make
sudo make install
