#!/bin/bash
# ~/.bashrc is only sourced for interactive non-login shells
# /etc/profile will have already being loaded by bash

[ -f /etc/bashrc ] && source /etc/bashrc
# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv ] && source ~/.bashrc.priv

function __aliases {
  alias diff=colordiff
  alias which="type -path"
  alias rm="rm -i"
  alias mv="mv -i"
  alias cp="cp -i"
  alias grep="grep --color=auto"
  alias pinfo='ps -o pid,state,command -C'
  alias f='find . | grep'
  alias bs='ssh warlock@warzone3.com.ar'
  alias a=aparser
  alias webshare='python -m SimpleHTTPServer'
  alias ls="ls --color=tty"
  alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sudo sh'
  alias nvimup='brew update; brew reinstall --HEAD neovim'
}
__aliases


function __common_env {
  umask 0022
  shopt -s extglob
  shopt -s checkwinsize

  export PATH="$HOME/bin:/usr/local/bin:$PATH:/opt/bin"
  # gnu-mac
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"

  for s in ~/Source/shlibs/*.lib.sh; do source $s; done

  export HISTSIZE=130000
  export HISTFILESIZE=-1
  export EDITOR=vim
  [ -z "$TMUX" ] && export TERM=xterm-256color
  export PYTHONSTARTUP=~/.pythonrc
  export HISTSIZE=5000
  export LESS='-r'
  export PROMPT_DIRTRIM=3
  export PS1='\e[1;30m\t \e[1;34m@\e[1;30m\h \e[1;34m\w $([ $? = 0 ] && echo "\e[0;32m" || echo "\e[0;31m")${PIPESTATUS[@]} \$\e[0m '
  export SDL_MOUSE_RELATIVE=0
  export SDL_VIDEO_X11_MOUSEACCEL=6/1/0
}
__common_env


function __setup_go {
  export GOPATH=~/go
  export PATH=$PATH:~/go/bin
}
__setup_go

function tux {
  __tmuxsesid=$USER_$(hostname -s)
  tmux -2 -u new-session -AD -s $__tmuxsesid
}

# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv.post ] && source ~/.bashrc.priv.post
