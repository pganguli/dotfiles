# Disable bell
xset -b
# Key repeat delay and rate
xset r rate 250 50
# X server terminate sequence
setxkbmap -option terminate:ctrl_alt_bksp
# Use CapsLock as second ESC
setxkbmap -option caps:escape
# Turn on Capslock on both Shift (single Shift cancels)
setxkbmap -option shift:both_capslock_cancel
# Set keyboard layout toggle
setxkbmap -layout us,us -variant ,dvorak -option grp:menu_toggle

exec /usr/bin/i3
