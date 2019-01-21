completion="$(brew --prefix)/bin/aws_zsh_completer.sh"

if test -f $completion
then
  source $completion
fi
