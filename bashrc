#!/bin/bash

# ~/.bashrc is only sourced for interactive non-login shells
# /etc/profile will have already being loaded by bash

function __aliases {
  alias diff=colordiff
  alias which="type -path"
  alias cal="cal -3"
  alias rm="rm -i"
  alias mv="mv -i"
  alias cp="cp -i"
  alias ls="ls --color=tty"
  alias grep="grep --color=auto"
  alias pinfo='ps -o pid,state,command -C'
  alias f='find . | grep'
  alias bs='ssh warlock@warzone3.com.ar'
  alias e='emacsclient -nw'
  alias eserver='emacs --daemon'
  alias a=aparser
}
__aliases


function __common_env {
  export PATH=$HOME/bin:$PATH:/usr/local/bin:/opt/bin
  export PYTHONSTARTUP=~/.pythonrc
  export PS1='\[\e[01;32m\]\u \[\e[01;34m\]\W \$ \[\e[00m\]'
  export HISTSIZE=5000
  export EDITOR=vim
  export TERM=xterm-256color

  for s in ~/Source/shlibs/*.lib.sh; do source $s; done

  shopt -s extglob
  umask 0022
}
__common_env


[ -z "$TMUX" ] && type -path tmux &>/dev/null && exec tmux -2 -u
