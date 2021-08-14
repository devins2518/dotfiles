#!/usr/bin/env bash

xorg_pkgs=(
    alacritty
    alttab-git
    bspwm
    discord_arch_electron
    dunst
    feh
    maim
    picom-ibhagwan-git
    rofi
    lightdm
    lightdm-gtk-greeter
    xclip
    xdotool
    sxhkd
)

pkgs=(${pkgs[@]} ${xorg_pkgs[@]})
useronly+=(xorg)
# environment+=(lightdm)
