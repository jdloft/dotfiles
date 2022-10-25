set     red="%{\033[31m%}"
set   green="%{\033[32m%}"
set  yellow="%{\033[33m%}"
set    blue="%{\033[34m%}"
set magenta="%{\033[35m%}"
set    cyan="%{\033[36m%}"
set   white="%{\033[37m%}"
set     end="%{\033[0m%}"

if ($?prompt) then
  if ($?TERM) then
    switch($TERM)
      case xterm*:
        if ($?tcsh) then
          set preamble='%{\033]0;%n@%m:%c\007%}'
        endif
        breaksw
      case screen:
        if ($?tcsh) then
          set preamble='%{\033k%n@%m:%c\033\\%}'
        endif
        breaksw
      default:
        breaksw
    endsw
  endif
  set promptchars='$#'
  set exitcode="${red}%?${end} "
  set prompt="${blue}%n${end}@${yellow}%m${end} ${blue}%~${end} %# "
  set prompt="$preamble$exitcode$prompt"
  unset preamble exitcode
endif
unset red green yellow blue magenta cyan yellow white end
