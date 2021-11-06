sudo pacman -S git
cd /tmp/ && git clone https://aur.archlinux.org/package-query.git && cd package-query

makepkg -s && sudo pacman -U package-query-*.pkg.tar.zst

cd .. && git clone https://aur.archlinux.org/yaourt.git && cd yaourt

makepkg -s && sudo pacman -U yaourt*.pkg.tar.zst
