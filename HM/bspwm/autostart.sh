# Top bar
~/.config/polybar/launch.sh &
# Background and colorscheme setter
feh --bg-fill /etc/nixos/spaceman.png &
# Compositor
picom --config $HOME/.config/picom.conf &
# Alt tab daemon
alttab -w 1 -i 128x128 &