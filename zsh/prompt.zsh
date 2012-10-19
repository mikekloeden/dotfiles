# load vcs_info and register our prompt function
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats " %{%B%F{green}%}[%{%f%}%s:%{%B%F{blue}%}%b%{%B%F{green}%}|%F{red}%a%{%B%F{green}%}]%{%f%k%}"
zstyle ':vcs_info:*' formats       " %{%B%F{green}%}[%{%f%}%s:%{%B%F{blue}%}%b%{%B%F{green}%}]%{%f%k%}"

precmd() {
    vcs_info
}

# Setup the prompt with pretty colors
setopt prompt_subst
PROMPT='%{%f%k%b%}
%(?..%{%F{red}%}✘%f )%B%F{green}%n@%m%f%b %F{yellow}%3~%f${vcs_info_msg_0_} 
%{%f%k%b%} %# '