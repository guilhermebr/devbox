[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
 
[[ -s ~/.bashrc ]] && source ~/.bashrc

#colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
 
# human and useful ls
alias lh='ls -loxa -lh --color'
alias ls='ls --color'

# generic file/directory commands
alias rmf='rm -rf'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'

# generic git shortcuts
alias gs='git status'
alias gd='git diff'
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gch='git checkout' 
alias gr='git remote'
alias gh='git log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short'

# django-script
alias 'ma'='python manage.py'
alias 'mg'='python manage.py makemigrations'
alias 'sdb'='python manage.py syncdb --noinput'
alias 'rs'='python manage.py runserver'

export VIRTUAL_ENV_DISABLE_PROMPT=1

function git_prompt {
    # if user is in a repository
    git_status=$(git status 2> /dev/null)
    if [ "$git_status" = "" ]; then
        echo ''
    else
        # get branch name
        branch_name=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        commit_status=$(git status 2>/dev/null | tail -n 1)
        if [ "$commit_status" = "nothing to commit, working directory clean" ]; then
            commit_status_summary="clean"
        else
            commit_status_summary="pending"
        fi
        echo "$branch_name:$commit_status_summary"
    fi
}

function venv_prompt {
    venv_strip=${VIRTUAL_ENV##*/} 
    if [ "$venv_strip" = "" ]; then
        echo ''
    fi
    echo ${VIRTUAL_ENV##*/} # this strips the path
}

function get_prompt {
    
    # get venv and git status
    venv=$(venv_prompt)
    git=$(git_prompt)
    
    # put them together
    if [ "$venv" = "" ] && [ "$git" = "" ]; then
        prompt=""
    elif [ "$venv" = "" ]; then
        prompt=$git
    elif [ "$git" = "" ]; then
        prompt=$venv
    else
        prompt="$venv:$git"
    fi
 
    # format the output
    if [ "$prompt" = "" ]; then
        echo ""
    else
        prompt=${prompt//')'/']'}
        prompt=${prompt//'('/'['}
        echo " ($prompt)"
    fi
 
}
 
# run these functions before printing each prompt
function prompt_command {
    export PS1="\u@\h \w$(get_prompt) \$ "
}
export PROMPT_COMMAND=prompt_command

export GOPATH=~/go:$GOPATH
export PATH=~/bin:~/go/bin:$PATH
