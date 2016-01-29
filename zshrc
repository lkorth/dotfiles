autoload -U compinit
compinit

autoload -U colors
colors

autoload -U select-word-style
select-word-style bash

autoload edit-command-line
zle -N edit-command-line
bindkey -v
bindkey "^R" history-incremental-search-backward

# functions
timeout() {
  perl -e 'use Time::HiRes qw( usleep ualarm gettimeofday tv_interval ); ualarm 100000; exec @ARGV' "$@";
}

git_untracked_count() {
  count=`echo $(timeout git ls-files --other --exclude-standard | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[yellow]%}?%{$fg_no_bold[black]%}:%{$reset_color$fg[yellow]%}$count%{$reset_color%}"
}

git_modified_count() {
  count=`echo $(timeout git ls-files -md | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[red]%}M%{$fg_no_bold[black]%}:%{$reset_color$fg[red]%}$count%{$reset_color%}"
}

git_staged_count() {
  count=`echo $(timeout git diff-index --cached --name-only HEAD 2>/dev/null | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[green]%}S%{$fg_no_bold[black]%}:%{$reset_color$fg[green]%}$count%{$reset_color%}"
}

git_branch() {
  branch=$(git symbolic-ref HEAD --quiet 2> /dev/null)
  if [ -z $branch ]; then
    echo "%{$fg[yellow]%}$(git rev-parse --short HEAD)%{$reset_color%}"
  else
    echo "%{$fg[green]%}${branch#refs/heads/}%{$reset_color%}"
  fi
}

git_remote_difference() {
  branch=$(git symbolic-ref HEAD --quiet)
  if [ -z $branch ]; then return; fi

  remote=$(git remote show)
  ahead_by=`echo $(git log --oneline $remote/${branch#refs/heads/}..HEAD 2> /dev/null | wc -l)`
  behind_by=`echo $(git log --oneline HEAD..$remote/${branch#refs/heads/} 2> /dev/null | wc -l)`

  output=""
  if [ $ahead_by -gt 0 ]; then output="$output%{$fg_bold[white]%}↑%{$reset_color%}$ahead_by"; fi
  if [ $behind_by -gt 0 ]; then output="$output%{$fg_bold[white]%}↓%{$reset_color%}$behind_by"; fi

  echo $output
}

git_user() {
  user=$(git config user.name)
  if [ -z $user ]; then
    echo "%{$fg_bold[red]%}no user%{$fg[black]%}@%{$reset_color%}"
  else
    echo "$user%{$fg[black]%}@%{$reset_color%}"
  fi
}

in_git_repo() {
  if [[ -d .git ]]; then
    echo 0
  else
    echo $(git rev-parse --git-dir > /dev/null 2>&1; echo $?)
  fi
}

git_prompt_info() {
  if [[ $(in_git_repo) -gt 0 ]]; then return; fi
  print " $(git_user)$(git_branch)$(git_remote_difference)$(git_staged_count)$(git_modified_count)$(git_untracked_count) "
}

simple_git_prompt_info() {
  ref=$($(which git) symbolic-ref HEAD 2> /dev/null) || return
  user=$($(which git) config user.name 2> /dev/null)
  echo " (${user}@${ref#refs/heads/})"
}

tmux-start() {
  tmux -S /tmp/$1 new-session -s $1 -d
  chmod 777 /tmp/$1
  tmux -S /tmp/$1 attach -t $1
}

tmux-join() {
  tmux -S /tmp/$1 new-session -t $1
}

tmux-list() {
  ps -eo ruser,command | grep '[n]ew-session -s' | ruby -ne '$_ =~ /^(\w+).*-s (\w+)/; puts "#{$1} started #{$2}"'
}

tmux-watch() {
  tmux -S /tmp/$1 attach -t $1 -r
}

setopt prompt_subst

HISTFILE=$HOME/.zsh_history # location of history file
SAVEHIST=2048               # large history
HISTSIZE=2048               # large history
setopt append_history       # append history for all instances
setopt hist_ignore_dups     # ignore duplicate entries
setopt hist_reduce_blanks   # trim blanks
setopt hist_verify          # show before executing history commands
setopt inc_append_history   # add commands as they are typed, don't wait until shell exit
setopt share_history        # share hist between sessions
unsetopt nomatch            # Allow [ or ] where ever you want

export LOCALE="en_US.UTF-8"
export LANG="en_US.UTF-8"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PROMPT='%{$fg_bold[green]%}%m:%{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}%# '

export GREP_OPTIONS='--color'
export EDITOR=vim
export LESS='XFR'

stty stop undef
stty start undef

# aliases
alias ll='ls -lha'
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove'
alias attach='tmux-start lkorth'
alias format-json='python -mjson.tool'
alias bi='bundle install'
alias nginx-logs='goaccess -a -p ~/.goaccessrc -f /var/log/nginx/access.log'

## servers
alias home="ssh -p 22022 -i ~/.ssh/rsa_luke_lukekorth_com luke@home.ofkorth.net"
alias server="ssh -p 22022 -i ~/.ssh/rsa_luke_lukekorth_com luke@ofkorth.net"

[[ -s ~/.zshrc_custom ]] && source ~/.zshrc_custom

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
