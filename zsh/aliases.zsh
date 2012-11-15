alias reload!='. ~/.zshrc'

# named directories and shortcuts
hash -d code=$PROJECTS
hash -d projects=~code/projects
hash -d github=~code/github

hash -d git=/Users/Shared/development/projects_git
hash -d mikl=~git/development/mikl

# completion for some directories
c() { cd $PROJECTS/$1; }
_c() { _files -W $PROJECTS -/; }
compdef _c c

cdgit() { cd ~git/$1; }
_cdgit() { _files -W ~git -/; }
compdef _cdgit cdgit

cdmp() { cd ~git/mediaport3/$1; }
_cdmp() { _files -W ~git/mediaport3 -/; }
compdef _cdmp cdmp