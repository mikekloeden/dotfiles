# ls overides
if $(ls --color &>/dev/null)
then
  alias ls='ls --color'
else 
  alias ls='ls -G'
fi
# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls='gls --color'      # list
  alias la='gls -Ap --color'  # list, includes dot files
  alias ll='gls -l --color'   # long list
  alias l='gls -lAh --color'  # long list, includes dot files
else 	
  alias la='ls -Ahp'  # list, includes dot files
  alias ll='ls -l'    # long list
  alias l='ls -lAh'   # long list, includes dot files
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

# Todo
alias t='todo.sh'
