#!/usr/bin/env bash

grep "^HandlePowerKey" /etc/systemd/logind.conf -q ||
    { sudo sed -i 's/^#HandlePowerKey.*/HandlePowerKey=suspend/' /etc/systemd/logind.conf; }
grep "^AllowSuspend" /etc/systemd/sleep.conf -q ||
    { sudo sed -i 's/^#AllowSuspend.*/AllowSuspend=yes/' /etc/systemd/sleep.conf; }
grep "^AllowHibernation" /etc/systemd/sleep.conf -q ||
    { sudo sed -i 's/^#AllowHibernation.*/AllowHibernation=yes/' /etc/systemd/sleep.conf; }
grep "^AllowSuspendThenHibernate" /etc/systemd/sleep.conf -q ||
    { sudo sed -i 's/^#AllowSuspendThenHibernate.*/AllowSuspendThenHibernate=yes/' /etc/systemd/sleep.conf; }
grep "^HibernateDelaySec" /etc/systemd/sleep.conf -q ||
    { sudo sed -i 's/^#HibernateDelaySec.*/HibernateDelaySec=1h/' /etc/systemd/sleep.conf; }
# grep "^FONT" /etc/vconsole.conf -q ||
#     { sudo sed -i 's/^FONT.*/FONT=spleen-16x32/' /etc/vconsole.conf; }

surface_pkgs=(
    cpupower
    linux-surface
    linux-surface-headers
    upower
)

pkgs=(${pkgs[@]} ${surface_pkgs[@]})
