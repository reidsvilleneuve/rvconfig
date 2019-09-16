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
