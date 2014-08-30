export EDITOR=vim

# aliases
alias ll='ls -lha'
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove'
alias attach='tmux-start lkorth'
alias format-json="python -mjson.tool"

## servers
alias home="ssh -p 22022 -i ~/.ssh/rsa_luke_lukekorth_com luke@home.ofkorth.net"
alias server="ssh -p 22022 -i ~/.ssh/rsa_luke_lukekorth_com luke@ofkorth.net"

# functions
function tmux-start {
  tmux -S /tmp/$1 new-session -s $1 -d
  chmod 777 /tmp/$1
  tmux -S /tmp/$1 attach -t $1
}

function tmux-join {
  tmux -S /tmp/$1 new-session -t $1
}

function tmux-list {
  ps -o ruser,command -ax | grep '[n]ew-session -s' | ruby -ne '$_ =~ /^(\w+).*-s (\w+)/; puts "#{$1} started #{$2}"'
}
