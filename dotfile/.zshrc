

 ######################################################
#                                                      #
#  __________  _________ ___ ______________________    #
#  \____    / /   _____//   |   \______   \_   ___ \   #
#    /     /  \_____  \/    ~    \       _/    \  \/   #
#   /     /_  /        \    Y    /    |   \     \____  #
#  /_______ \/_______  /\___|_  /|____|_  /\______  /  #
#          \/        \/       \/        \/        \/   #
#                                                      #
 ######################################################


# on-my-zsh
export ZSH="$HOME/.oh-my-zsh"
# plug repo: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
    colored-man-pages
	vi-mode
	command-not-found
	extract
)
# oh-my-zsh settings
ZSH_THEME="terminalparty"
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
alias ohmyzsh="mate ~/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


# zplug
# zplug install - Install packages in parallel
# zplug load - Source installed plugins and add installed commands to $PATH
# list - List installed packages
# update - Update installed packages in parallel
if [[ -f ~/.zplug/init.zsh ]] {
  source ~/.zplug/init.zsh

  # zplug's plugin needn't to be writte in plugins array above
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-autosuggestions"

  if ! zplug check --verbose; then
      echo 'Run "zplug install" to install'
  fi
  # source plugins and add commands to $PATH
  zplug load
}

# auto-suggestions
bindkey '^j' autosuggest-execute
bindkey '^l' autosuggest-accept

export M5_PATH=/home/jch/Documents/run-gem/offical_assets/aarch-system-20210904

# fd
alias fd="fdfind"
alias fda="fdfind -IH"

# python module
export PATH="$PATH:/home/jch/.local/bin"

# flame graph for perf
export PATH="$PATH:/home/jch/Downloads/FlameGraph"
alias genflame="sudo perf script -f|stackcollapse-perf.pl|flamegraph.pl>flame.svg"

# set git editor to vim
export GIT_EDITOR=vim

# proxy
export http_proxy=http://192.168.10.1:7890
export https_proxy=http://192.168.10.1:7890

# turn off the binding of Ctrl-S
# so that vim can use <c-s> to save changes
bindkey -r '\C-s'
stty -ixon

# z
. ~/Downloads/z/z.sh

# go
export PATH=$PATH:/usr/local/go/bin

# arm tool chain
export PATH=$PATH:/usr/local/arm-toolchain/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu/bin

# git alias
alias gs='git status'
alias gb='git branch'
alias ga='git add .'
alias gc='git commit --no-verify'
alias gl='git log --graph --pretty=oneline --abbrev-commit --all'
alias gc='git checkout'
alias gp='git push'
alias gd='git diff'

alias bd="BaiduPCS-Go"

# export M5_PATH=/home/jch/Documents/gem5/

#################### custom command ####################

# tmux 
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tn='tmux new -s'

# cat printk
cpk() {
	sudo cat /proc/sys/kernel/printk
}

# echo printk
epk() {
    sudo bash -c "echo $1 $2 $3 $4 > /proc/sys/kernel/printk"
}

# firewall 
firewall() {
	for i in raw mangle nat filter ; do
		echo -e "\n-------------------" TABLE: $i '---------------------' ;
		sudo iptables -t $i -L ;
	done
}
 
# delete all .swp in current directory
rmswp() {
	find . -type f -name "*.sw[klmnop]" -delete
}

# cross compile arm kernel
makearm() {
	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- $@
}

# fzf
# enable key-binding
source /usr/share/doc/fzf/examples/key-bindings.zsh

#generate core dump
ulimit -c unlimited
gen_core() {
    sudo bash -c "echo core > /proc/sys/kernel/core_pattern "
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jch/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jch/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jch/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jch/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export QT_DEBUG_PLUGINS=1
