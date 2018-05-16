#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion


#### add by zhufeng ####

set -o vi
alias ls='ls --color=auto'
alias ll='ls -la'
alias lt='ls -lrt'
alias dus='du -sm * | sort -n'
alias vi='vim'
alias yumn='yum --noplugins --disablerepo=epel,rhel-* '
alias C='export LANG=C'

if [ $(id -u) -eq 0 >/dev/null  2>&1 ]; 
then
	PS1="[\[\e[31;4m\]\u\[\e[0m\]@\[\e[36;4m\]\h \[\e[34;4m\]\w\[\e[0m\]]\\$ "
else
	PS1="[\[\e[32;4m\]\u\[\e[0m\]@\[\e[36;4m\]\h \[\e[34;4m\]\w\[\e[0m\]]\\$ "
fi

#### end of add by zhufeng ####

#
# End of /etc/bash.bashrc
#
