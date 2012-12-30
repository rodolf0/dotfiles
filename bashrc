#!/bin/bash

function __aliases {
  alias which="type -path"
  alias cal="cal -3"
  alias where="type -all"
  alias ll="ls -l --col"
  alias rm="rm -i"
  alias mv="mv -i"
  alias cp="cp -i"
  alias ls="ls --color=tty"
  alias grep="grep --color=auto"
  alias make="make -j3"
  alias pgrep="pgrep -l"
  alias pinfo='ps -o pid,state,command -C'
  alias f='find . | grep'
  alias bs='ssh warlock@warzone3.com.ar'
  alias tvoff="bs -t -x 'sudo -i -u xbmc xset -display :0 dpms force off'"
  alias tvon="bs -t -x 'sudo -i -u xbmc xset -display :0 dpms force on'"
  alias e='emacsclient -t'
}


function __common_env {
  [ -f /etc/profile ]         && source /etc/profile
  [ -f /etc/bash_completion ] && source /etc/bash_completion

  #export LANG="es_AR"
  #export LC_MONETARY="es_AR.utf8"

  export PATH=$HOME/bin:$PATH:/usr/local/bin:/opt/bin
  [ -d /opt/maven/bin ]         && export PATH=$PATH:/opt/maven/bin
  [ -d /opt/matlab.r2009a/bin ] && export PATH=$PATH:/opt/matlab.r2009a/bin

  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  export PYTHONPATH=/usr/lib/python2.7/site-packages:$PYTHONPATH
  export PYTHONPATH=$PYTHONPATH:$HOME/Source/pylibs
  export PYTHONSTARTUP=~/.pythonrc

  export PS1='\[\e[01;32m\]\u \[\e[01;34m\]\W \$ \[\e[00m\]'
  export HISTSIZE=1000
  export EDITOR=vim
  #export DE=xfce # for xdg-open to work correctly
  export TERM=xterm-256color
  export CC=clang
  export CXX=clang++

  for s in ~/Source/shlibs/*.lib.sh; do source $s; done

  shopt -s extglob
  umask 0022
}


function __stronghold_env {
  export GOOS=linux
  export GOARCH=386
  export GOROOT=~/src/go
  export GOPATH=~/src/mygo:~/src/go
  for p in ${GOPATH//:/ }; do export PATH=$PATH:$p/bin; done

  #source /usr/share/autojump/autojump.bash
  alias devserv='python ~/src/google_appengine.py/dev_appserver.py'
}

function __warmill_env {
  export GOOS=linux
  export GOARCH=amd64
  export GOROOT=~/src/go
  export GOPATH=~/src/go:$GOPATH
  for p in ${GOPATH//:/ }; do export PATH=$PATH:$p/bin; done

  #source /etc/profile.d/autojump.bash
  alias devserv='python2 ~/src/google_appengine.py/dev_appserver.py'
}

tag() { alias $1="cd $PWD"; }

__aliases
__common_env
[ $(hostname -s) = 'stronghold' ] && __stronghold_env
[ $(hostname -s) = 'warmill' ]    && __warmill_env
[[ "$-" =~ i ]] && cal
