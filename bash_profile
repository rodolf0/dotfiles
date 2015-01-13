source ~/.bashrc

if false && [ -z "$TMUX" ]; then
    __tmuxsesid=$USER_$(hostname -s)
    exec tmux new-session -AD -s $__tmuxsesid
fi
