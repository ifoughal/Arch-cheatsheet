## KDE installation:

### upgrade you Arch base
pacman -Syu

### Install xorg with default parameters

pacman -S xorg

### Install Plasma & kde with default parameters:

pacman -S plasma-meta kde-applications

### enable services:

systemctl enable sddm & systemctl enable NetworkManager

### reboot your arch
reboot
