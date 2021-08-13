#!/usr/bin/env bash

intel_envvars=(
    VDPAU_DRIVER=va_gl
    LIBVA_DRIVER_NAME=i965
)
for var in ${wayland_envvars[@]}; do
    grep $var /etc/environment -q || echo $var | sudo tee -a /etc/environment
done

intel_pkgs=(
    mesa
    vulkan-intel
    lib32-mesa
    intel-media-driver
)

pkgs=(${pkgs[@]} ${intel_pkgs[@]})
