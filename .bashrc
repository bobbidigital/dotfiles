export PATH=$PATH:$HOME/Library/Python/2.7/lib/python/site-packages:$HOME/Library/Python/2.7/bin/:/Applications/Postgres.app/Contents/Versions/9.3/bin:/Users/jsmith/.vim/ftdetect/node_modules/.bin/
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
#source /Users/jsmith/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export TERM=xterm-256color
export EDITOR='vim'
source ~/.bin/tmuxinator.bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:$HOME/packer"
alias ll='ls -la'
alias ..='cd ..'
alias grep='grep --color=auto'
alias deployprod='git push heroku master'
alias deploystage="git push staging `git branch|grep '^*'|awk ' { print $2 }'`:master"
