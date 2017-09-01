alias ls='gls --color'
alias l='gls --color -latr'
export ANDROID_HOME='/Users/matias/Library/Android/sdk'
PATH=$HOME/bin:$PATH

source ~/.git-prompt.sh
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\] $(__git_ps1)  \n\$ '
