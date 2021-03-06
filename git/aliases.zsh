# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias gcd='cd "`git rev-parse --show-toplevel`"'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gsb='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gs='git status --short'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gp='git push origin HEAD'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -a -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
