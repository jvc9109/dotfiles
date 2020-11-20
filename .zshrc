export DOTFILES_PATH=$HOME/.dotfiles

setopt HIST_IGNORE_ALL_DUPS
bindkey -e

WORDCHARS=${WORDCHARS//[\/]}

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)


if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

for aliasToSource in "$DOTFILES_PATH/_aliases/"*; do source "$aliasToSource"; done
for functionsToSource in "$DOTFILES_PATH/_functions/"*; do source "$functionsToSource"; done
# ------------------------------
# Post-init module configuration
# ------------------------------



# }}} End configuration added by Zim install

# Created by newuser for 5.8
_reverse_search_vit() {
  local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)
  LBUFFER=$selected_command
}

zle         -N    _reverse_search_vit
bindkey  '^r'  _reverse_search_vit
