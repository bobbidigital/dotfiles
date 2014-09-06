export PATH=$PATH:/Users/jsmith/Library/Python/2.7/lib/python/site-packages:/Users/jsmith/Library/Python/2.7/bin/:/Applications/Postgres.app/Contents/Versions/9.3/bin:/Users/jsmith/.vim/ftdetect/node_modules/.bin/
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
#source /Users/jsmith/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export TERM=xterm-256color

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
alias ll='ls -la'
alias ..='cd ..'
alias grep='grep --color=auto'
alias deployprod='git push heroku master'
alias deploystage="git push staging `git branch|grep '^*'|awk ' { print $2 }'`:master"
