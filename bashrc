# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

alias ls='ls -G --color=tty'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -G --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'
alias top='htop'
alias nanrombabusy='cat /dev/urandom | hexdump -C | grep "ca fe"'
alias more='most';
alias less='most';
alias c='clear'
alias ssh='ssh -AX'
alias fin='cd ~/Dropbox/Finances/Toronto'
alias tunnel='ssh -f -N -L 1122:142.150.234.71:3690 venkatesh@fs.csl.toronto.edu'
alias printtunnel='ssh -L 9100:128.100.23.53:9100 venkatesh@25.176.113.181'
alias tunnel_cluster131='ssh -f -N -L 1123:142.150.234.131:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster130='ssh -f -N -L 1124:142.150.234.130:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_website='ssh -f -N -L 1125:seth.eecg.toronto.edu:22 venkatesh@25.176.113.181'
alias rsync_website='rsync -avz -e "ssh -p 1125" /Users/venkatesh/Dropbox/website venkatesh@localhost:/amza/a/a2/venkatesh/public_html/'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias rsync_build='rsync -avz -e ssh /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ venkatesh@25.176.113.181:/home/venkatesh/hadoop-build'
alias mixapart='cd /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0'
alias rsync_xen_build='rsync -avz -e ssh /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar venkatesh@25.176.113.181:/home/venkatesh/xen'
alias rsync_xen_build_cluster130='rsync -avz -e "ssh -p 1124" /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar root@localhost:/root'
alias rsync_xen_build_cluster131='rsync -avz -e "ssh -p 1123" /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar root@localhost:/root'
alias datafart='curl --data-binary @- datafart.com'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export TERM=xterm
export CVS_RSH=/usr/local/bin/ssh
export FIGNORE=.svn
export EDITOR=vim
export ACK_COLOR_MATCH="bold red"
export HADOOP_HOME=/usr/local/hadoop
export PATH=/sbin:/usr/sbin:/bin:/opt/local/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/opt/X11/bin:$HADOOP_HOME/bin
export JAVA_HOME=$(/usr/libexec/java_home)

#########
if [ -L /.yroot -a -f /tmp/.ysbsrootrc ]
then
        source /tmp/.ysbsrootrc
fi

umask 022

man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

ssh-reagent () {
for agent in /tmp/ssh-*/agent.*; do
    export SSH_AUTH_SOCK=$agent
    if ssh-add -l 2>&1 > /dev/null; then
        echo Found working SSH Agent:
        ssh-add -l
        return
    fi
done
echo Cannot find ssh agent - maybe you should reconnect and forward it?
}

#########
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
if [ "$YROOT_NAME" ]; then
    if echo $TERM|grep -q screen ; then PROMPT_COMMAND='echo -ne "\033]0;\007\ek${YROOT_NAME}\e\\"'; fi
else
    if echo $TERM|grep -q screen ; then PROMPT_COMMAND='echo -ne "\033]0;build3:${PWD}\007\ekdev\e\\"'; fi
fi

#----- automatically inserted -----
if [ -n "$PS1" ]; then
PS1='[\u@\h \t \w] \$ '
if [ -n "$YROOT_NAME" ]; then
PS1="[$YROOT_NAME] [\u@\h \t \w] \$ "
fi
setenv () { export $1="$2"; }
unsetenv () { unset $*; }
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
