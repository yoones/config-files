#!/bin/bash

alias gop='cd ~/projects/'

# aliases 101
alias l='ls'
alias ll='ls -l'
alias lla='ll -a'
alias lld='ll -d'
alias llh='ll -h'
alias llah='ll -ah'
alias clean='rm -f *~ ; rm -f .*~ ; rm -f \#*\#'
alias ccl='clean ; clear ; pwd ; ll'
alias ne='emacs -nw'
alias sne='sudo emacs -nw'
alias df='df -h'
alias j='jobs'
alias catx='hexdump -C'
alias bc="\bc -q"
alias gdb="\gdb -q"
alias gotmp="cd /tmp/toto"
alias godl="cd ~/Downloads"
alias dl="cd ~/Downloads"
alias m="most"

# network
alias pg='ping -c 1 google.com'

# programmation
alias v='valgrind --track-origins=yes --leak-check=full'
alias make='clear ; /usr/bin/make'
alias fclean='make fclean'
alias xmake='make re > /dev/null'
alias ner='ne ./config/routes.rb'
alias st="clear ; git st"

# rails
alias rs='rails s'
alias rc='rails c'
# alias rd="rdesc"
# alias rr="rrout"
alias migrate="rake db:migrate"

# tools
function mktmp()
{
    r=`echo -n "/tmp/_$RANDOM" | cut -b 1-9`
    mkdir $r && echo "created in: $r" || echo "failed"
}

# # extra aliases
# if [ -f ~/.bash_extra_aliases ]; then
#     . ~/.bash_extra_aliases
# fi
