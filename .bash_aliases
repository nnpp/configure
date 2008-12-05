############################################################
# Pakage Management
#

# Gentoo
alias em='sudo emerge'

# Arch
alias p='pacman'

function sp {
  if [ -f 'script/plugin' ];then
    ./script/plugin $@
  else
    sudo pacman $@
  fi
}

############################################################
# System
#
alias rm=trash
trash()
{
  mv $@ /tmp
}

alias ls='ls --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color'

alias sd='sudo shutdown -h now'

# VIM
alias sgv='sudo gvim'
alias gv='gvim'
alias sv='sudo vim'
alias v='vim'

# Touchpad
alias tpf='synclient touchpadoff=1'
alias tpo='synclient touchpadoff=0'


alias ri='qri'

############################################################
# Rails
#
alias ss='./script/server'
alias sg="./script/generate"
alias as="./script/autospec"

alias sc='./script/console'
alias sd='./script/dbconsole'

############################################################
# Git
#

alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff'
alias gp='git push'

# gc      => git checkout master
# gc bugs => git checkout bugs
function gc {
if [ -z "$1" ]; then
  git checkout master
else
  git checkout $1
fi
}
