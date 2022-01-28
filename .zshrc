# zshell
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="mate ~/.oh-my-zsh"

# proxy
export http_proxy=http://192.168.10.1:7890
export https_proxy=http://192.168.10.1:7890

# bind key vim map
bindkey -v

# clipboard
set clipboard=unamed

############################# custome commands ############################

export dir=~/Documents/tdx-sim/host-linux

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

# 2 version qeum in server, specify version
alias qemu-system-x86_64=/usr/local/bin/qemu-system-x86_64
alias qemu-system-aarch64=/usr/local/bin/qemu-system-aarch64

