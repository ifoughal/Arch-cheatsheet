
## prequisites for lutris:

pacman -S vagrant virtualbox-host-dkms

#### check that virtualbox is running:

VBoxManage --version

#### if it outputs an error, run the vbox setup:

sudo /sbin/rcvboxdrv setup

#### Once virtualbox is set up, build wine-ge-custom:

cd /opt/
git clone --recurse-submodules https://github.com/gloriouseggroll/wine-ge-custom -b 6.18-GE-1

cd /opt/wine-ge-custom
./makebuild.sh lutris http://github.com/gloriouseggroll/wine ge-6.18-1



## How to install dxvulkan:
pacman -S meson mingw-w64-gcc mingw-w64-crt glslang


## git clone these repos:
in this example, we'll be cloning and builinding in /opt:

cd /opt 
git clone https://github.com/doitsujin/dxvk.git

git clone --recursive https://github.com/HansKristian-Work/vkd3d-proton

## conpile the projects:
### conpiling dxvk
cd /opt/dxvk

./package-release.sh master /opt/ --no-package

### conpiling vkd3d-proton
cd /opt/vkd3d-proton
./package-release.sh master /opt/ --no-package

cd /opt/vkd3d-proton-master

## [OPTION 1]:


## mkdir x32 & x64 for lutris for our custom dxvk-proton builds
mkdir -p ~/.local/share/lutris/runtime/dxvk/master/x32

mkdir -p ~/.local/share/lutris/runtime/dxvk/master/x64

cp /opt/dxvk-master/x32/* ~/.local/share/lutris/runtime/dxvk/master/x32

cp /opt/dxvk-master/x64/* ~/.local/share/lutris/runtime/dxvk/master/x64


mkdir -p ~/.local/share/lutris/runtime/vkd3d/master/x32

mkdir -p ~/.local/share/lutris/runtime/vkd3d/master/x64

cp /opt/vkd3d-proton-master/x86/* ~/.local/share/lutris/runtime/vkd3d/master/x32

cp /opt/vkd3d-proton-master/x64/* ~/.local/share/lutris/runtime/vkd3d/master/x64


## [ OPTION 2]: 
## install projects in wineprefix:
Example dir:
mkdir ~/.local/wineprefix/my_prefix

### Installing dxvk
cd /opt/dxvk-master/
WINEPREFIX=~/.local/wineprefix/my_prefix ./setup_dxvk.sh install

### Installing vkd3d-proton
cd /opt/vkd3d-proton-master
WINEPREFIX=~/.local/wineprefix/my_prefix ./setup_vkd3d_proton.sh install


## [Troubleshooting]:
if for some reason you see in the logs of your vulkan compiler that dx12 is not available; then manually probe your gpu:

sudo nvidia-modprobe -u -c=0

