#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# what directories should be installable by all users including the root user
base=(
    home
)

# folders that should, or only need to be installed for a local user
useronly=(
    home
)

environment=(
)

pkgs=(
    bottom
    ffmpeg
    firefox-bin
    gcc
    git
    gopls
    grub-holdshift
    hyperfine
    inferno-git
    jq
    libnotify
    lm_sensors
    lua-format
    lua-language-server-git
    neovim-git
    networkmanager
    os-prober
    pamixer
    pavucontrol
    pcmanfm
    perf
    pulseaudio
    ripgrep
    rust-analyzer-nightly-bin
    spleen-font
    tokei
    tree
    update-grub
    whitesur-cursor-theme-git
    whitesur-gtk-theme-git
    whitesur-icon-theme-git
    zls
    zsh
)

grep "Repos/dotfiles" /etc/environment -q || { echo "DOT=/home/devin/Repos/dotfiles" | sudo tee -a /etc/environment && echo "Added DOT envvar"; }
wallpaper="/etc/wallpaper/wallpaper.png"
if [[ ! -f "$wallpaper" ]]; then
    sudo mkdir /etc/wallpaper
    sudo curl https://raw.githubusercontent.com/manderio/manpapers/main/edited/devins2518/dark_road_upscaled_tokyonight.png -o $wallpaper
    echo "$wallpaper downloaded."
fi

sudo grep "^#%wheel ALL=(ALL) NOPASSWD:ALL" /etc/sudoers -q || { sudo sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers; }
grep "^GRUB_DEFAULT=saved" /etc/default/grub -q || { sudo sed -i 's/^GRUB_DEFAULT.*/GRUB_DEFAULT=saved/' /etc/default/grub; }
grep "^GRUB_SAVEDEFAULT=true" /etc/default/grub -q || { sudo sed -i 's/^#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/' /etc/default/grub; }
grep "^GRUB_DISABLE_OS_PROBER=false" /etc/default/grub -q || { echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub; }
grep "^GRUB_TIMEOUT_STYLE=countdown" /etc/default/grub -q || { sudo sed -i 's/^GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=countdown/' /etc/default/grub; }

envvars=(
    DOT_INTEL
    DOT_NVIDIA
    DOT_WAYLAND
    DOT_X
)

for var in ${envvars[@]}; do
    if [[ ! -v $var ]]; then
        echo "$var not set! Refusing to continue"
        exit 1
    fi
done

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}
export -f stowit
export pkgs
export useronly
export environment

if [[ "$DOT_INTEL" == "1" ]]; then
    . ${DOT:=/home/devin/Repos/dotfiles}/setup/intel.sh
fi
if [[ "$DOT_WAYLAND" == 1 ]]; then
    . ${DOT:=/home/devin/Repos/dotfiles}/setup/wayland.sh
fi

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${base[@]}; do
    stowit "${HOME}" $app 
done

# install only user space folders
for app in ${useronly[@]}; do
    if [[ ! "$(whoami)" = *"root"* ]]; then
        stowit "${HOME}" $app 
    fi
done

# install things for /etc
for app in ${environment[@]}; do
    sudo bash -c "$(declare -f stowit); stowit "/etc" $app"
done

yay -S --noconfirm --norebuild --noredownload --notimeupdate --needed ${pkgs[@]}

echo ""
echo "##### ALL DONE"
