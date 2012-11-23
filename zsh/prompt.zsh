# load vcs_info and register our prompt function
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats " %{%B%F{magenta}%}[%{%%b%f%}%s:%{%%b%F{green}%}%b%{%B%F{green}%}|%F{red}%a%{%B%F{magenta}%}]%{%f%k%}"
zstyle ':vcs_info:*' formats       " %{%B%F{magenta}%}[%{%%b%f%}%s:%{%%b%F{green}%}%b%{%B%F{magenta}%}]%{%f%k%}"

precmd() {
    vcs_info
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos -gt 0 ]
    then
      echo "✔ $todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

# Setup the prompt with pretty colors
setopt prompt_subst
PROMPT='%{%f%k%b%}
%(?..%{%F{red}%}✖ $?%f )%B%F{magenta}%n@%m%f%b %F{yellow}%3~%f${vcs_info_msg_0_} 
%{%f%k%b%} %# '
RPROMPT="%B%F{magenta}$(todo)%{%f%k%b%}"
