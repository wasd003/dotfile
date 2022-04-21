

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
	zsh-autosuggestions
)
# oh-my-zsh settings
ZSH_THEME="terminalparty"
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
alias ohmyzsh="mate ~/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# zplug
if [[ -f ~/.zplug/init.zsh ]] {
  source ~/.zplug/init.zsh

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

# fd
alias fd="fdfind"
alias fda="fdfind -IH"

# python module
export PATH="$PATH:/home/jch/.local/bin"

# set git editor to vim
export GIT_EDITOR=vim

# proxy
export http_proxy=http://192.168.10.1:7890
export https_proxy=http://192.168.10.1:7890

# turn off the binding of Ctrl-S
# so that vim can use <c-s> to save changes
bindkey -r '\C-s'
stty -ixon

host=~/Documents/host-linux
guest=~/Documents/guest-linux


#################### custom command ####################

# tmux 
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tn='tmux new -s'

# list kernel
alias lskernel='dpkg --list | grep linux-image'

# cat printk
alias cpk='sudo cat /proc/sys/kernel/printk'

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

# fzf
# put this line at bottom of .zshrc
source ~/opt/fzf/shell/key-bindings.zsh
