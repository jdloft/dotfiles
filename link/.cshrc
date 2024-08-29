setenv DOTFILES ~/.dotfiles

alias src source ~/.cshrc

# Source all files in "source"
set nonomatch
if (-f ~/.cshrc.pre) then
  source ~/.cshrc.pre
endif
foreach file ($DOTFILES/source/csh/*)
  if (-r $file) then
    source $file
  endif
end
if (-f ~/.cshrc.post) then
  source ~/.cshrc.post
endif
