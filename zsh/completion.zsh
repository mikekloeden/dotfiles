# completion for some directories
_mcd() { _files -W $PWD -/; }
compdef _mcd mcd

cdgit() { cd ~git/$1; }
_cdgit() { _files -W ~git -/; }
compdef _cdgit cdgit

cdmp() { cd ~git/mediaport3/$1; }
_cdmp() { _files -W ~git/mediaport3 -/; }
compdef _cdmp cdmp


# setup completion
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

# some defaults
zstyle ':completion:*' completer _expand _complete _ignored _approximate

zstyle ':completion:*' use-perl on
zstyle ':completion:*' rehash yes

zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

# enable menu completion
zstyle ':completion:*' menu select

# enable verbose completion; descriptions like: '-a  -- list entries starting with .'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:-command-:*:' verbose no

# default menu selection for a few commands
zstyle ':completion:*:*:(kill*|man|git|e|c|cd*):*' menu yes

# remove current commandline form possible completions
zstyle ':completion:*:(rm|kill):*' ignore-line yes

# completion order
zstyle ':completion:*:complete:-command-:*:*' tag-order aliases commands functions builtins reserved-words
zstyle ':completion:*:complete:-command-:*:*' group-order aliases functions builtins commands reserved-words

# use known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
hosts=(
  #"$_global_ssh_hosts[@]"
  #"$_ssh_hosts[@]"
  $hosts
)
zstyle ':completion:*:hosts' hosts $hosts

zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:*:users' ignored-patterns \
        apache bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mongod mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa webmail xfs \
        'qmail*' \
        '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# Colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# colorize parameters with uncommon names
zstyle ':completion:*:parameters' list-colors "=[^a-zA-Z]*=$color[red]"
# colorize aliases
zstyle ':completion:*:aliases' list-colors "=*=$color[green]"
# colorize _* functions
zstyle ':completion:*:functions' list-colors "=_*=$color[red]"
# colorize original input
zstyle ':completion:*:original' list-colors "=*=$color[red];$color[bold]"
# highlight reserved words like 'select' or 'end'
zstyle ':completion:*:reserved-words' list-colors "=*=$color[red]"
# colorize hostname completion
zstyle ':completion:*:*:*:*:hosts' list-colors "=*=$color[green]"
# colorize username completion
zstyle ':completion:*:*:*:*:users' list-colors "=*=$color[red]"

# description in selection menu
zstyle ':completion:*:descriptions' format "- %{${fg_bold[magenta]}%}%d%{${reset_color}%} -"
zstyle ':completion:*:messages'     format "- %{${fg_bold[yellow]}%}%d%{${reset_color}%} -"
zstyle ':completion:*:corrections'  format "- %{${fg_bold[magenta]}%}%d%{${reset_color}%} - (%{${fg[yellow]}%}errors %e%{${reset_color}%})"

zstyle ':completion:*:default'      \
  select-prompt \
  "Match %m%  Line %l%{${fg_no_bold[red]}%}  %p%{${reset_color}%}"

zstyle ':completion:*:default'      \
  list-prompt   \
  "Line %l%{${fg_no_bold[red]}%}  Continue?%{${reset_color}%}"

zstyle ':completion:*:warnings'     \
  format        \
  "- %{${fg_bold[red]}%}no match%{${reset_color}%} - %{${fg_no_bold[yellow]}%}%d%{${reset_color}%}"
zstyle ':completion:*' group-name ''
