# install utilties

sudo pacman -S lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia nvidia nvidia-utils

## add nvidia to pacman hook for auto-upgrades on kernel upgrades:

/etc/pacman.d/hooks/nvidia.hook

[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'

# blacklist nouveau
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

# Load nvidia modules on boot – update firmware

vi /etc/mkinitcpio.conf

MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)


sudo mkinitcpio -P linux


















