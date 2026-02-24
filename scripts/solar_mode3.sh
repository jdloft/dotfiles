#!/bin/sh
# Solarized mode 3 by jdloft
# colors 10-14 are inherited from non-bright variants
# colors 16-21 are bright variants
# the rest of the colors are strategically placed in the 256 color space

# based off of base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)

# Neutral-gray Solarized remix:
base03="23/26/29"
base02="2f/34/38"
base01="6b/74/7a"
base00="7a/84/8b"
base0="97/a0/a6"
base1="a6/ae/b3"
base2="df/e3/e3"
base3="f2/f4/f3"
yellow="b5/89/00"
orange="cb/4b/16"
red="dc/32/2f"
magenta="d3/36/82"
violet="7b/80/c0"
blue="4b/88/b8"
cyan="4f/9b/95"
green="85/99/00"

# if [ -n "$TMUX" ]; then
#   # Tell tmux to pass the escape sequences through
#   # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
#   put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
#   put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
#   put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
if [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# common
put_template 1  $red
put_template 2  $green
put_template 3  $yellow
put_template 4  $blue
put_template 5  $magenta
put_template 6  $cyan
put_template 9  $orange # brred
put_template 10 $green # brgreen
put_template 11 $yellow # bryellow
put_template 12 $blue # brblue
put_template 13 $magenta # brmagenta
put_template 14 $cyan # brcyan
put_template 104 $violet
put_template 235 $base03
put_template 236 $base02
put_template 243 $base01
put_template 244 $base00
put_template 247 $base0
put_template 145 $base1
put_template 254 $base2
put_template 255 $base3

if [ ! -z $SOLAR_LIGHT ] && [ $SOLAR_LIGHT = true ]; then
  color_background=$base3
  color_foreground=$base00

  put_template 0  $base2
  put_template 7  $base02
  put_template 8  $base00 # not typical, but I would prefer this be legible on background
  put_template 15 $base03 # brwhite
else
  color_background=$base03
  color_foreground=$base0

  put_template 0  $base02
  put_template 7  $base2
  put_template 8  $base0 # not typical, but I would prefer this be legible on background
  put_template 15 $base3 # brwhite
fi

# foreground / background / cursor color
if [ -z "$ITERM_SESSION_ID" ]; then
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color_background
unset color_foreground
unset base03
unset base02
unset base01
unset base00
unset base0
unset base1
unset base2
unset base3
unset yellow
unset orange
unset red
unset magenta
unset violet
unset blue
unset cyan
unset green
