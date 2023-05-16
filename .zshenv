export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME:=${HOME}/.config}/zsh}
export HISTFILE=${HISTFILE:=${XDG_STATE_HOME:=${HOME}/.local/state}/zsh/history}
export PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:=${XDG_STATE_HOME:=${HOME}/.local/state}/pass}

source $ZDOTDIR/.zshenv
