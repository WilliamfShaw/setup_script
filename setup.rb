#usr/bin/env ruby
puts "========================"
puts "INSTALLING HOMEBREW"
puts "========================"

system '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
system "brew update"
system "brew tap homebrew/dupes"
system "brew install homebrew/dupes/grep"

puts "========================"
puts "INSTALLING HEROKU TOOLBELT"
puts "========================"

system "brew install heroku-toolbelt"

puts "========================"
puts "INSTALLING WATCHMAN"
puts "========================"

system "brew install watchman"

puts "========================"
puts "INSTALLING NODE"
puts "========================"

system "brew install node"

puts "========================"
puts "INSTALLING POSTGRESQL"
puts "========================"

system "brew install postgres"
system "brew services start postgresql"

puts "========================"
puts "INSTALLING GIT"
puts "========================"

system "brew install git"

puts "========================"
puts "INSTALLING RBENV"
puts "========================"

system "brew install rbenv ruby-build"
system "rbenv install 2.3.1"
system "rbenv global 2.3.1"

puts "========================"
puts "SETTING UP BASH PROFILE"
puts "========================"

system 'cat > ~/.bash_profile << EOT
if which rbenv > /dev/null; then eval "\$(rbenv init -)"; fi

export PATH="\$PATH:/usr/local/bin"

# ALIASES

alias brewup="brew update && brew upgrade && brew cleanup"
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias ll="ls -FGlAhp"
alias ..="cd ../"
alias ...="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"
alias .6="cd ../../../../../../"

# NETWORKING ALIASES

alias myip="curl ip.appspot.com"


# GIT

DIR_COLOR="\[\e[0;32m\]"
GIT_BRANCH_COLOR="\[\e[0;36m\]"
GIT_CLEAN_COLOR="\[\e[1;32m\]"
GIT_DIRTY_COLOR="\[\e[0;31m\]"
PROMPT_COLOR="\[\033[38;5;172m\]"
RESET_COLOR="\[\e[0m\]"
PROMPT_CHARACTER="=>"

function __git_branch_status {
    if $(__git_repo_initialized); then
        if [[ -z $(git status -s) ]]; then
            echo -e "\$GIT_CLEAN_COLOR ✔"
        else
            echo -e "\$GIT_DIRTY_COLOR ✗"
        fi
    fi
}

function __git_repo_initialized {
  git ls-files >& /dev/null
}

function __git_branch_name {
    if $(__git_repo_initialized); then
        git symbolic-ref --short -q HEAD
    fi
}

function __prompt_command {
    PS1="\n\$DIR_COLOR\w \$GIT_BRANCH_COLOR\$(__git_branch_name)\$(__git_branch_status)\$RESET_COLOR\n\$PROMPT_COLOR\$PROMPT_CHARACTER \$RESET_COLOR"
}

PROMPT_COMMAND=__prompt_command

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
EOT
'

puts "========================"
puts "CLEANUP :)"
puts "========================"

system "source ~/.bash_profile"
system "brew cleanup"
