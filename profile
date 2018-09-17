alias ls='gls --color'
alias l='gls --color -latr'
export ANDROID_HOME='/Users/ematiu/Library/Android/sdk'
PATH=$HOME/bin:$PATH
export GPG_TTY=$(tty)

source ~/.git-prompt.sh
source ~/bin/git-completion.bash
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\] $(__git_ps1)  \n\$ '
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home/'
export COPAY_EXTERNAL_SERVICES_CONFIG_LOCATION="~/.copay/externalServices.json"
export BITPAY_EXTERNAL_SERVICES_CONFIG_LOCATION="~/.bitpay/externalServices.json"
alias tw="~/dev/bw/bin/wallet -f ~/testnet.dat "

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/dev/grin/target/debug:$PATH"
export PATH="$PATH:$HOME/dev/arcanist/bin/"
export PATH="$PATH:/Users/ematiu/dev/bitcoin-abc/build/src/"
export PYTHONPATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python', 'site-packages'))"):$PYTHONPATH
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/Users/ematiu/Library/Android/sdk/platform-tools"

alias bit='bitoin-cli'
alias bitr='bitcoin-cli -regtest '
alias bitt='bitcoin-cli -testnet '
alias r='git pull --rebase origin master'
export GOPATH="$HOME/dev/go"


source /Users/ematiu/dev/bitcoin-abc/contrib/bitcoin-cli.bash-completion
source /Users/ematiu/dev/bitcoin-abc/contrib/bitcoin-tx.bash-completion

alias sublime='reattach-to-user-namespace sublime'
alias open='reattach-to-user-namespace open'
