#!/usr/bin/env bash

intel_envvars=(
    VDPAU_DRIVER=va_gl
    LIBVA_DRIVER_NAME=i965
)
for var in ${wayland_envvars[@]}; do
    grep $var /etc/environment -q || echo $var | sudo tee -a /etc/environment
done

grep "i915" /etc/mkinitcpio.conf -q ||
    {
        sudo sed -ri 's/^(MODULES=\(.*)\)/\1 i915)/' /etc/mkinitcpio.conf
        sudo mkinitcpio -P linux
    }

intel_pkgs=(
    mesa
    vulkan-intel
    lib32-mesa
    intel-media-driver
)

pkgs=(${pkgs[@]} ${intel_pkgs[@]})
