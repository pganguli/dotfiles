source "$HOME/.cargo/env"

alias xc="xclip -selection clipboard"
alias zoom="firejail zoom"

function cpr() {
    rsync --archive --human-readable --human-readable --partial --info=stats1 --info=progress2 --modify-window=1 "$@"
}

function rtcrec() {
    ffmpeg -f x11grab -video_size 1920x1080 -framerate 30 -i :0.0 \
           -f pulse -ac 2 -i 0 \
           -codec:a libopus -application voip \
           -codec:v libx264rgb -crf 0 -preset ultrafast \
           "$(date +%Y-%m-%d_%H.%M.%S).mkv"
}

function pulserec() {
    ffmpeg -f pulse -ac 2 -i 0 \
           -codec:a libopus -application voip \
           "$(date +%Y-%m-%d_%H.%M.%S).opus"
}
