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




#------------------------------------------------------------------------------
# Returncode.
#------------------------------------------------------------------------------
function returncode
{
  returncode=$?
  if [ $returncode != 0 ]; then
    echo "[$returncode]"
  else
    echo ""
  fi
}

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
                else
                        eval $(dircolors)
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
                PS1='\[\033[0;31m\]$(returncode)\[\033[0;37m\]\[\033[0;35m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
        else
                PS1='\[\033[0;31m\]$(returncode)\[\033[0;37m\]\[\033[0;35m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
        alias fgrep='fgrep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias ll='ls -lF'
        alias la='ls -A'
        alias l='ls -CF'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\[$(returncode)\]\u@\h \W \$ '
        else
                PS1='\[$(returncode)\]\u@\h \w \$ '
        fi
fi


set -o vi
alias ll='ls -la'
alias lt='ls -lrt'
alias dus='du -sm * | sort -n'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
export PATH=/sbin:$PATH

# set jdk environment 
export JAVA_HOME=/usr/local/src/jdk1.6.0_24/
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


# set PATH for adb and android sdk folder
# export PATH=/home/cm/bin:/home/cm/android-sdk-linux/tools/:/home/cm/android-sdk-linux/platform-tools/:/home/cm/android-sdk-linux/build-tools/19.1.0:$PATH

# set PATH for arm-linux-gcc eabi 4.6
# export CM11=/home/cm/cm11
# export PATH=$CM11/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin:$PATH

# export PATH=$PATH:/media/cm-k860i/arm-eabi-4.6/bin:$PATH
# export ARCH=arm
# export SUBARCH=arm
# export CROSS_COMPILE=arm-eabi- 


#
# End of /etc/bash.bashrc
#
