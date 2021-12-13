#
# ~/.bashrc
#
export EDITOR=vim
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35;1m\]\u\[\033[01;35;1m\]@\[\033[01;35;1m\]\h\[\033[01;31;1m\]:\[\033[01;34;1m\]\w \[\033[01;32;1m\]\t \[\033[01;35;1m\]\$ \[\033[01;37;1m\]'
