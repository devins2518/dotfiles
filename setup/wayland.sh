#!/usr/bin/env bash

wayland_envvars=(
    XDG_SESSION_TYPE=wayland
    XDG_SESSION_DESKTOP=river
    XDG_CURRENT_DESKTOP=river
    MOZ_ENABLE_WAYLAND=1
    CLUTTER_BACKEND=wayland
    QT_QPA_PLATFORM=wayland-egl
    ECORE_EVAS_ENGINE=wayland-egl
    ELM_ENGINE=wayland_egl
    SDL_VIDEODRIVER=wayland
    _JAVA_AWT_WM_NONREPARENTING=1
    NO_AT_BRIDGE=1
)
for var in ${wayland_envvars[@]}; do
    grep $var /etc/environment -q || echo $var | sudo tee -a /etc/environment
done

wayland_pkgs=(
    foot
    greetd
    greetd-tuigreet-bin
    grim
    kile-wl
    mako
    midle-wl
    paper-wl
    river-git
    slurp
    swaylock
    wl-clipboard
    wlr-randr
    wofi
    xorg-xwayland
)

pkgs=(${pkgs[@]} ${wayland_pkgs[@]})
useronly+=(wayland)
environment+=(greetd)
