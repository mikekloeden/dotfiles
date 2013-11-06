autoload colors && colors
# load vcs_info and register our prompt function
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' stagedstr '%F{yellow}M%f' 
zstyle ':vcs_info:*' unstagedstr '%F{green}M%f' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats " %B%F{magenta}[%%b%f%s%f%k:%%b%F{green}%b%B%F{magenta}|%F{red}%a%B%F{magenta}]%f%k"
zstyle ':vcs_info:*' formats       " %B%F{magenta}[%%b%f%s%f%k:%%b%F{green}%b%B%F{magenta}]%f%k %c%u"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st

precmd() {
    vcs_info
}

# Show untracked files indicator
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    hook_com[unstaged]+='%F{red}??%f'
  fi  
}

# Show remote ref name and number of commits ahead-of or behind
+vi-git-st() {
    local ahead behind remote
    local -a gitstatus

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        ahead=$(git rev-list --count ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null)
        (( $ahead )) && gitstatus+=( "+${ahead}" )

        behind=$(git rev-list --count HEAD..${hook_com[branch]}@{upstream} 2>/dev/null)
        (( $behind )) && gitstatus+=( "-${behind}" )

        divider="%B%F{magenta}/%f%k"
        hook_com[branch]="${hook_com[branch]}%f...%B%F{magenta}${remote}%f%k${gitstatus:+ }${(j: :)gitstatus}"
    fi
}

# Setup the prompt with pretty colors
setopt prompt_subst
PROMPT='%f%k%b
%(?..%F{red}✖ $?%f )%B%F{magenta}${SSH_TTY:+%n@%m }%f%b%F{yellow}%3~%f${vcs_info_msg_0_}
%f%k%b %# '