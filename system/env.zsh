# Only set this if we haven't set $EDITOR up somewhere else previously.
if [[ "$EDITOR" == "" ]] ; then
  export EDITOR='/usr/local/bin/mate -w'
fi
