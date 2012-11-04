# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls='gls -F --color'   # list
  alias l='gls -lAh --color'  # long list all, includes dot files
  alias la='gls -A --color'   # list all, includes dot files
  alias ll='gls -l --color'   # long list, excludes dot files
else 
  alias ls='ls -G --color'     # list
  alias l='ls -Gla --color'    # long list all, includes dot files
  alias la='ls -Ga --color'    # list all, includes dot files
  alias ll='ls -Alhp --color'  # long list, excludes dot files
fi

# Starts the extended vi when using vi
alias vi="vim"

# Lazy grep
alias -g G='| grep'

# Basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias tree='find . -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"'

# Super user
alias _='sudo'

# Show history
alias history='fc -l 1'
