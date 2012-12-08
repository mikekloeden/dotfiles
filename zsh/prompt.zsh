# load vcs_info and register our prompt function
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats " %{%B%F{magenta}%}[%{%%b%f%}%s:%{%%b%F{green}%}%b%{%B%F{green}%}|%F{red}%a%{%B%F{magenta}%}]%{%f%k%}"
zstyle ':vcs_info:*' formats       " %{%B%F{magenta}%}[%{%%b%f%}%s:%{%%b%F{green}%}%b%{%B%F{magenta}%}]%{%f%k%}"

precmd() {
    vcs_info
}

prompt_refdiff() {
  if git rev-parse origin &> /dev/null
  then
    set -- `git rev-list --left-right --count origin...HEAD`
    [ $1 -gt 0 ] && echo -$1
    [ $2 -gt 0 ] && echo +$2
  fi
}

# Setup the prompt with pretty colors
setopt prompt_subst
PROMPT='%{%f%k%b%}
%(?..%{%F{red}%}✖ $?%f )%B%F{magenta}%n@%m%f%b %F{yellow}%3~%f${vcs_info_msg_0_} %B%F{magenta}$(prompt_refdiff)%f%b 
%{%f%k%b%} %# '