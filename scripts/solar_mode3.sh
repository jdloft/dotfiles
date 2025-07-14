#!/bin/sh
# Solarized mode 3 by jdloft
# colors 10-14 are inherited from non-bright variants
# colors 16-21 are bright variants
# Old: 10 11 12 13 14 08
# New: 16 17 18 19 20 21

# based off of base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)

base03="00/2b/36"
base02="07/36/42"
base01="58/6e/75"
base00="65/7b/83"
base0="83/94/96"
base1="93/a1/a1"
base2="ee/e8/d5"
base3="fd/f6/e3"
yellow="b5/89/00"
orange="cb/4b/16"
red="dc/32/2f"
magenta="d3/36/82"
violet="6c/71/c4"
blue="26/8b/d2"
cyan="2a/a1/98"
green="85/99/00"

color_background=$base03
color_foreground=$base0
color00=$base02 # black
color01=$red # red
color02=$green # green
color03=$yellow # yellow
color04=$blue # blue
color05=$magenta # magenta
color06=$cyan # cyan
color07=$base2 # white
color08="65/7b/83" # brblack - bright black override from mode 2
color09=$orange # brred
color10=$color02 # brgreen
color11=$color03 # bryellow
color12=$color04 # brblue
color13=$color05 # brmagenta
color14=$color06 # brcyan
color15=$base3 # brwhite
color16=$base01
color17=$base00
color18=$base0
color19=$violet
color20=$base1
color21=$base03

if [ ! -z $SOLAR_LIGHT ] && [ $SOLAR_LIGHT = true ]; then
  color_background=$base3
  color_foreground=$base00
  color15=$color07
  color16=$base1
  color17=$base0
  color18=$base00
  color20=$base01
  color21=$base3
fi

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

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

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
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
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
