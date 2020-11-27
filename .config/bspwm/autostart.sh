# Top bar
~/.config/polybar/launch.sh &
# Notification daemon
twmnd &
# Compositor
picom --experimental-backends --backend glx &
# Background and colorscheme setter
feh --bg-fill $HOME/.config/wallpaper/wallhaven-e7zogk.jpg &
wal -i $HOME/.config//wallpaper/wallhaven-e7zogk.jpg &
# Nvidia Fan Controller
nvfancontrol &
# Alt tab daemon
alttab -w 1 -i 128x128 &
