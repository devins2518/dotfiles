# Top bar
~/.config/polybar/launch.sh &
# Background and colorscheme setter
feh --bg-fill $HOME/.config/wallpaper/ &
# Compositor
picom --experimental-backends --backend glx &
# Alt tab daemon
alttab -w 1 -i 128x128 &
