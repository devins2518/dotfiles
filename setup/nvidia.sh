#!/usr/bin/env bash

nvidia_envvars=(
    VDPAU_DRIVER=nvidia
    LIBVA_DRIVER_NAME=vdpau
)
for var in ${nvidia_envvars[@]}; do
    grep $var /etc/environment -q || echo $var | sudo tee -a /etc/environment
done

grep "nvidia nvidia_modeset nvidia_uvm nvidia_drm" /etc/mkinitcpio.conf -q ||
    {
        sudo sed -ri 's/^(MODULES=\(.*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        sudo mkinitcpio -P linux
    }

grep "nvidia-drm.modeset=1" /etc/default/grub -q ||
    {
        sudo sed -ri 's/^(GRUB_CMDLINE_LINUX_DEFAULT=".*)"/\1 nvidia-drm.modeset=1"/' \
            /etc/default/grub
        sudo update-grub
    }

nvidia_pkgs=(
    nvidia-dkms
    nvidia-utils
    opencl-nvidia
    nvidia-settings
)

pkgs=(${pkgs[@]} ${nvidia_pkgs[@]})
useronly+=(nvidia)
environment+=(nvidia_etc)
