
## How to install dxvulkan:
pacman -S meson mingw-w64-gcc mingw-w64-crt glslang


## git clone these repos:
in this example, we'll be cloning and builinding in /opt:

cd /opt 
git clone https://github.com/doitsujin/dxvk.git

git clone --recursive https://github.com/HansKristian-Work/vkd3d-proton

## conpile the projects:
conpiling dxvk
cd /opt/dxvk

./package-release.sh master /opt/ --no-package

cd /opt/vkd3d-proton


## install projects in wineprefix:
Example dir:
mkdir ~/.local/wineprefix/my_prefix

cd /opt/dxvk-master/




WINEPREFIX=~/.local/wineprefix/my_prefix ./setup_dxvk.sh install

## mkdir x32 & x64 for lutris for our custom dxvk-proton builds
mkdir -p ~/.local/share/lutris/runtime/dxvk/master/x32 && mkdir -p ~/.local/share/lutris/runtime/master/x64
