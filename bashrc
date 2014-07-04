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
HISTSIZE=10000
HISTFILESIZE=20000

export HISTIGNORE="doing done":"doing now"

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

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='darwin'
fi


if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=tty'
elif [[ $platform == 'darwin' ]]; then
    alias ls='ls -G'
fi

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

if [ -x /opt/local/bin/gdircolors ]; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls -F --color=auto'
    alias la='ls -a'
    alias lf='ls -FA'
    alias ll='ls -lA'
    alias dir='gdir --color=auto'
    alias vdir='gvdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


if [ -x /usr/libexec/locate.updatedb ]; then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi

alias ll='ls -alF'
alias la='ls -A'
alias vi='vim'
alias l='ls -CF'
alias top='htop'
alias fixrow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'
alias nanrombabusy='cat /dev/urandom | hexdump -C | grep "ca fe"'
alias more='most';
alias less='most';
alias c='clear'
alias ssh='ssh -AX'
alias fin='cd ~/Dropbox/Finances/Toronto'
alias printtunnel='ssh -L 9100:128.100.23.53:9100 venkatesh@25.176.113.181'

alias tunnel='ssh -f -N -L 1122:142.150.234.71:3690 venkatesh@fs.csl.toronto.edu'
alias tunnel_shiny='ssh -f -N -L 1126:shiny13.syslab.sandbox:22 venkatesh@syslab.cs.toronto.edu'
alias tunnel_shiny_web='ssh -f -N -L 8088:shiny08.syslab.sandbox:8088 venkatesh@syslab.cs.toronto.edu && ssh -f -N -L 19888:shiny08.syslab.sandbox:19888 venkatesh@syslab.cs.toronto.edu && ssh -f -N -L 50070:shiny08.syslab.sandbox:50070 venkatesh@syslab.cs.toronto.edu'
alias tunnel_cluster131='ssh -f -N -L 1123:142.150.234.131:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster130='ssh -f -N -L 1124:142.150.234.130:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster129='ssh -f -N -L 1120:142.150.234.129:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster121='ssh -f -N -L 1119:142.150.234.121:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster128='ssh -f -N -L 1118:142.150.234.128:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_website='ssh -f -N -L 1125:seth.eecg.toronto.edu:22 venkatesh@25.176.113.181'
alias tunnel_cluster129='ssh -f -N -L 1120:142.150.234.129:22 venkatesh@fs.csl.toronto.edu'
alias tunnel_cluster151='ssh -f -N -L 1151:10.10.10.151:22 venkatesh@fs.csl.toronto.edu'

alias rsync_website='rsync -avz -e "ssh -p 1125" /Users/venkatesh/Dropbox/website venkatesh@localhost:/amza/a/a2/venkatesh/public_html/'
alias rsync_build='rsync -avz -e ssh /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ venkatesh@25.176.113.181:/home/venkatesh/hadoop-build'
alias rsync_mixapart_build_cluster121='rsync -avz -e "ssh -p 1119" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_mixapart_build_cluster128='rsync -avz -e "ssh -p 1118" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_mixapart_build_cluster129='rsync -avz -e "ssh -p 1120" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_mixapart_build_cluster130='rsync -avz -e "ssh -p 1124" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_mixapart_build_cluster131='rsync -avz -e "ssh -p 1123" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_ofs_build='rsync -avz -e "ssh -p 1126" /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0/build/hadoop-0.20.203.1-SNAPSHOT/ root@localhost:/root/hadoop-build'
alias rsync_xen_build='rsync -avz -e ssh /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar venkatesh@25.176.113.181:/home/venkatesh/xen'
alias rsync_xen_build_cluster130='rsync -avz -e "ssh -p 1124" /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar root@localhost:/root'
alias rsync_xen_build_cluster131='rsync -avz -e "ssh -p 1123" /Users/venkatesh/Documents/xen-workspace/venkatesh/target/venkatesh-0.0.1-SNAPSHOT-jar-with-dependencies.jar root@localhost:/root'
alias rsync_yarn_shiny13='rsync -avz /Users/venkatesh/Documents/hadoop-common/hadoop-dist/target/hadoop-3.0.0-SNAPSHOT/ shiny:/root/yarn/hadoop-yarn/'
alias rsync_yarn_shiny08='rsync -avz /Users/venkatesh/Documents/hadoop-common/hadoop-dist/target/hadoop-3.0.0-SNAPSHOT/ shiny08:/root/yarn/hadoop-yarn/'
alias rsync_hadoop_shiny08='rsync -avz /Users/venkatesh/Documents/workspace/hadoop-1.2/build/hadoop-1.2.2-SNAPSHOT/ shiny08:/root/hadoop-build/'
alias rsync_hadoop_shiny13='rsync -avz /Users/venkatesh/Documents/workspace/hadoop-1.2/build/hadoop-1.2.2-SNAPSHOT/ shiny:/root/hadoop-build/'
alias rsync_build_cluster151='rsync -avz -e "ssh -p 1151" /Users/venkatesh/Documents/workspace/hadoop-1.2/build/hadoop-1.2.2-SNAPSHOT/ venkatesh@localhost:/home/venkatesh/hadoop-build'
alias rsync_backup_hadoop="rsync -avz --delete --exclude 'build/'  ~/Documents/workspace/hadoop-1.2/ ~/Dropbox/UofT/hadoop_backup/"

alias mixapart='cd /Users/venkatesh/Documents/workspace/mixapart/hadoop-0.20.203.0'
alias datafart='curl --data-binary @- datafart.com'
alias mvn_hadoop_build='mvn clean install package -Dtar -Pdist -DskipTests -P-cbuild -Dmaven.javadoc.skip=true && cd hadoop-mapreduce-project/ && mvn clean install package -Dtar -Pdist -DskipTests -P-cbuild assembly:assembly -Dmaven.javadoc.skip=true && cd ..'

alias eclipse_hadoop_listen='export HADOOP_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5000"'
alias eclipse_hadoop_listen_blank='export HADOOP_OPTS=""'

alias cscope_build="rm tags; rm cscope.*; find . -type f ! -iwholename '*\.\/build\/*' ! -iwholename '*.jar' ! -iwholename '*git*' -iwholename '*lib\/jdiff\/*' -exec sh -c \"file {} | grep text 2>&1 1> /dev/null\" \; -print > cscope.files; ctags -R"
alias cscope="cscope -CqUki cscope.files"

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
export HADOOP_HOME=/Users/venkatesh/Documents/workspace/hadoop-1.2/build/hadoop-1.2.2-SNAPSHOT
export PATH=/sbin:/usr/sbin:/bin:/opt/local/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/opt/X11/bin:$HADOOP_HOME/bin:/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
#export LD_LIBRARY_PATH=/opt/local/lib:/usr/local/lib
#export DYLD_LIBRARY_PATH=/opt/local/lib:/usr/local/lib

if [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi
export PYTHONPATH=$PYTHONPATH:/usr/lib/xen-4.1/lib/python/:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/

umask 022

stty erase ^?

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

#----- automatically inserted -----
if [ -n "$PS1" ]; then
PS1='[\u@\h \t \w] \$ '
setenv () { export $1="$2"; }
unsetenv () { unset $*; }
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function cd {
if [ "$1" != "" ]
then
    pushd "$1" >/dev/null
else
    pushd ~ >/dev/null
fi
}

function p {
popd
}

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() {
    echo -e "$RED$*$NORMAL"
}

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function did() {
    /usr/bin/doing now $*
    /usr/bin/doing done
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
}

function debug() { [ "$DEBUG" ] && echo ">>> $*"; }

echo "What are you doing now?";
