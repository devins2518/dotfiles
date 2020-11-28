# Top bar
~/.config/polybar/launch.sh &
# Notification daemon
twmnd &
# Compositor
picom --experimental-backends --backend glx &
# Background and colorscheme setter
feh --bg-fill $HOME/Downloads/wallhaven-0pqp2m.jpg &
flavours generate dark $HOME/Downloads/wallhaven-0pqp2m.jpg && flavours apply generated &
# Nvidia Fan Controller
nvfancontrol &
# Alt tab daemon
alttab -w 1 -i 128x128 &
