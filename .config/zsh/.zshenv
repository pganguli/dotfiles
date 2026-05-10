# Filename:      zshenv
# Purpose:       system-wide .zshenv file for zsh(1)
# Authors:       grml-team (grml.org), (c) Michael Prokop <mika@grml.org>
# Bug-Reports:   see http://grml.org/bugs/
# License:       This file is licensed under the GPL v2.
################################################################################
# This file is sourced on all invocations of the shell.
# It is the 1st file zsh reads; it's read for every shell,
# even if started with -f (setopt NO_RCS), all other
# initialization files are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Notice: .zshenv is the same, execpt that it's not read
# if zsh is started with -f
#
# Global Order: zshenv, zprofile, zshrc, zlogin
################################################################################

# language settings (read in /etc/environment before /etc/default/locale as
# the latter one is the default on Debian nowadays)
# no xsource() here because it's only created in zshrc! (which is good)
[[ -r /etc/environment ]] && source /etc/environment

# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(uname -n)}

# make sure /usr/bin/id is available
if [[ -x /usr/bin/id ]]; then
    [[ -z "$USER" ]] && export USER=$(/usr/bin/id -un)
    [[ $LOGNAME == LOGIN ]] && LOGNAME=$(/usr/bin/id -un)
fi

## set $PATH

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# generic $PATH handling
if (( EUID != 0 )); then
  path=(
    "${path[@]}"
    "$HOME/bin"
    "$HOME/.local/bin"
    "${CARGOPATH:-}/bin"
    "${GOPATH:-}/bin"
    "${JULIAUPPATH:-}/bin"
    /opt/uppaal-5.0.0/bin
    /opt/uppaal-5.0.0/lib/app/bin
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    /usr/local/games
    /usr/games
    "${ADDONS:-}"
  )
else
  path=(
    "${path[@]}"
    "$HOME/bin"
    /usr/local/sbin
    /usr/local/bin
    /sbin
    /bin
    /usr/sbin
    /usr/bin
    "${ADDONS:-}"
  )
fi

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH
path=( "${path[@]:#}" )

# Ensure uniqueness
typeset -U path

# less (:=pager) options:
[[ -x /usr/bin/lesspipe.sh ]] && export LESSOPEN="|lesspipe.sh %s"

# Use a default width of 80 for manpages for more convenient reading
export MANWIDTH=${MANWIDTH:-80}

export READNULLCMD=${PAGER:-/usr/bin/pager}

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
