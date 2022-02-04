# on-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="mate ~/.oh-my-zsh"

# proxy
export http_proxy=http://192.168.10.1:7890
export https_proxy=http://192.168.10.1:7890

# bind key vim map
bindkey -v
# ctrl + r to search history
bindkey '^R' history-incremental-search-backward 
# turn off the binding of Ctrl-S
bindkey -r '\C-s'
stty -ixon

# clipboard
set clipboard=unamed

# tmux alias
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tn='tmux new -s'

# generate tags
alias mkcstag='find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files && cscope -bR'
alias mkctag='ctags -R'
# set cscope db
alias csdb='export CSCOPE_DB=`pwd`/cscope.out'

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
