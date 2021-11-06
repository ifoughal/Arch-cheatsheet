https://drive.google.com/drive/folders/1r-X8g6It5AO7SwgJc1JQfJ8KCOyqrr_d

## prequisites:
make sure DKMS and kernel headers are installed, 
pacman -S dkms linux-headers


## get your sound card info:
sudo lspci -v -nn



## check status of your driver
dmesg | grep ca0132


## check your kernel release:
uname -r

example result:
5.14.16-arch1-1

## download source of your kernel's version:
https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.14.16.tar.gz

Extract sound/pci/hda from the archive.

This is the folder that contains the main hda_ files that you'll need to compile and link with the module. 

You can discard the files that don't have the prefix hda_ as we won't be compiling any of the other patch_ files other than patch_ca0132.c . 

Also, make sure to keep ca0132_regs.h.


## download dkms archvie

Now, you should download the current dkms archive, extract it.
https://drive.google.com/file/d/19e2PcGqNqGVY_4-8SPSuAiEXzP5b9Hbx/view

Replace all the hda_ files with the ones from the kernel source you downloaded. 

Once this is done, copy the ca0132-beta-1.0 folder into your /usr/src folder, and run the command:

cp -R ca0132-beta-1.0/ /usr/src/

sudo dkms build -m ca0132-beta -v 1.0

and then:

sudo dkms install -m ca0132-beta -v 1.0

That should be it.
