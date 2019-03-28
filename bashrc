# ~/.bashrc is only sourced for interactive non-login shells
# /etc/profile will have already being loaded by bash

[ -f /etc/bashrc ] && source /etc/bashrc
# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv ] && source ~/.bashrc.priv

__aliases() {
  alias diff=colordiff
  alias which="type -path"
  alias rm="rm -i"
  alias mv="mv -i"
  alias cp="cp -i"
  alias grep="grep --color=auto"
  alias ls="ls --color=auto"
  alias vim=nvim
  alias bpl="nc -l ${PIPEPORT:-27284}"  # back-pipe listen
  alias o=xdg-open
  alias e=$EDITOR
  alias dm1='du --max-depth=1 -m'
  alias d.='du -sh .'
  f1() { find "${*:-.}" -mindepth 1 -maxdepth 1; }
  f1f() { find "${*:-.}" -mindepth 1 -maxdepth 1 -type f; }
  f1d() { find "${*:-.}" -mindepth 1 -maxdepth 1 -type d; }
  # Find in history
  fh() {
    local entry="$(HISTTIMEFORMAT= history | fzf +s -e --tac | sed 's/^[0-9]\+ *//')"
    echo "$entry"
  }
  # Find directory and CD to it
  cdf() {
    local base="${1:-.}"
    local path=$(command find "$base" \
      \( -path '*/\.*' \
      -o -name .git \
      -o -name buck-out \
      \) -prune \
      -o -type d -print \
      2>/dev/null |
      fzf +m -e) &&
    cd "$path"
  }
}
__aliases

__crush_alias() {
  alias cc='crush cut'
  alias cag='crush aggr'
  alias cca='crush calc'
}
__crush_alias

__shell_setup() {
  shopt -s extglob
  shopt -s checkwinsize
  shopt -s histappend
  export HISTSIZE=130000
  export HISTFILESIZE=-1
  export PROMPT_DIRTRIM=3
  # the \[ braketing needs to be there so readline can calculate line length
  export PS1='\[\e[1;30m\]\t ' # time
  [ "$HOSTPROMPT" ] && export PS1=$PS1'\[\e[1;33m\]\H ' # hostname
  export PS1=$PS1'\[\e[1;34m\]\w ' # working dir
  # exit code needs to be checked before any command to avoid loosing it
  export PS1=$PS1'$([[ ${PIPESTATUS[*]} =~ ^0( 0)*$ ]] && echo "\[\e[0;32m\]" || echo "\[\e[1;31m\]")${PIPESTATUS[*]} '
  # last char of prompt is NBSP: ^V + 160 to enable backsearch in tmux.conf
  export PS1=$PS1'\$\[\e[m\] ' # prompt and color reset
}
__shell_setup

__common_env() {
  umask 0022
  export PATH="$HOME/bin:$HOME/.local/bin:$HOME/local/bin:/usr/local/bin:$PATH:/opt/bin"
  which nvim &>/dev/null && export EDITOR=nvim || export EDITOR=vim
  export PYTHONSTARTUP=~/.pythonrc
  export LESS='-r'
}
__common_env

__pretty_less() {
	export LESS_TERMCAP_mb=$(printf "\e[1;31m")
	export LESS_TERMCAP_md=$(printf "\e[1;31m")
	export LESS_TERMCAP_me=$(printf "\e[0m")
	export LESS_TERMCAP_se=$(printf "\e[0m")
	export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
	export LESS_TERMCAP_ue=$(printf "\e[0m")
	export LESS_TERMCAP_us=$(printf "\e[1;32m")
}
__pretty_less

__setup_langs() {
  export GOPATH=~/go
  export PATH=$PATH:~/go/bin
  export PATH=$PATH:~/.cargo/bin
  export PATH=$PATH:~/.node-modules/bin
}
__setup_langs

for s in ~/Source/shlibs/*.lib.sh; do [ -f "$s" ] && source "$s"; done

# stuff not to be tracked by git goes here
[ -f ~/.bashrc.priv.post ] && source ~/.bashrc.priv.post || true
