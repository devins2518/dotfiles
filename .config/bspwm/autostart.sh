# Notification daemon
twmnd &
# Compositor
picom --experimental-backends --backend glx &
# Background and colorscheme setter
feh --bg-fill $HOME/.config/wallpaper/summer/earlymorning.png &
flavours generate dark $HOME/.config/wallpaper/summer/earlymorning.png && flavours apply generated &
# Nvidia Fan Controller
nvfancontrol &
# Alt tab daemon
alttab -w 1 -i 128x128 &
# Top bar
~/.config/polybar/launch.sh &
