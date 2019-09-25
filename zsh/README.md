Source the Linux or OSX rc in this directory in ~/.zshrc. Don't symlink - system-specific setup should be done there (Additionally, many installation scripts automatically add entries to ~.zshrc, and that proves to be difficult to maintain when these changes find themselves in the VCS file.

An example system ~/.zshrc for linux:

```
##################
# Customizations #
##################

alias gtr="cd ~/repos"

export PROJECT_ZSHRC_WHITELIST=( \
  "/home/someusername/repos/someproject" \
)

export PATH="$HOME/bin:$PATH"

############
# Env vars #
############

export FAVORITE_COLOR="Blue. No! YELLOOOOOOOOOooooooooooow!"

##########
# System #
##########

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

source ~/rvconfig/zsh/linux-zshrc
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source "$HOME/rvconfig/zsh/rvdev.zsh-theme"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

An example of a project zshrc file:

```
export RVDEV_WORK_BRANCH='feature/PROJECTNAME-1234-do-some-stuff'
export RVDEV_BASE_BRANCH='develop'
export RVDEV_REV_BRANCH='develop'
export RVDEV_REV2_BRANCH='develop'
export RVDEV_TEMP_BRANCH='develop'
export RVDEV_TEMP2_BRANCH='develop'
export RVDEV_DEV_BRANCH='develop'

alias gcwork='git checkout $RVDEV_WORK_BRANCH'
alias gcbase='git checkout $RVDEV_BASE_BRANCH'
alias gcrev='git checkout $RVDEV_REV_BRANCH'
alias gcrev2='git checkout $RVDEV_REV2_BRANCH'
alias gctemp='git checkout $RVDEV_TEMP_BRANCH'
alias gctemp2='git checkout $RVDEV_TEMP2_BRANCH'
alias gcdev='git checkout $RVDEV_DEV_BRANCH'

alias start='npm start'
alias unit='npm test'
```
