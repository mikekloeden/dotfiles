# load vcs_info and register our prompt function
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats " %B%F{magenta}[%%b%f%s%B%F{magenta}]%f%k-%B%F{magenta}[%%b%F{green}%b%B%F{magenta}|%F{red}%a%B%F{magenta}]%f%k"
zstyle ':vcs_info:*' formats       " %B%F{magenta}[%%b%f%s%B%F{magenta}]%f%k-%B%F{magenta}[%%b%F{green}%b%B%F{magenta}]%f%k %F{yellow}%c%F{green}%u"

precmd() {
    vcs_info
}

prompt_refdiff() {
  remote=`git rev-parse --symbolic-full-name --abbrev-ref HEAD@{u} 2>/dev/null`
  if [ $? -gt 0 ]; then
    echo -n ""
  else
    set -- `git rev-list --left-right --count HEAD...${remote}`
    [ $1 -gt 0 ] && echo -n "%f↑%F{green}$1"
    [ $2 -gt 0 ] && echo -n "%f↓%F{red}$2"
  fi
}

# Setup the prompt with pretty colors
setopt prompt_subst
PROMPT='%{%f%k%b%}
%(?..%{%F{red}%}✖ $?%f )%B%F{magenta}%n@%m%f%b %F{yellow}%3~%f${vcs_info_msg_0_}$(prompt_refdiff)
%{%f%k%b%} %# '