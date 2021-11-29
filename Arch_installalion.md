# installation from usb bootable stick for UEFI systems with GRUB

# 1. Prequistes:
## step 1:
Download arch image from the official repos.

## step 2:
Download Etcher and make your iso image bootable on your usb stick.


## step 3:
Disable TPM & enable CSM on your bios.

## step 4:
Load the boot iso in UEFI

## step 5:

# 2. Installation:
You should be in archiso mode now.

## step 1:
Check available keyboard layouts:
``` console
ls /usr/share/kbd/keymaps/**/*.map.gz
```

Load your keyboard layout:
``` console
loadkeys < your keyboard value here >
```

## step 2:
Ensure that the system clock is synced:
``` console
timedatectl set-ntp true
timedatectl status
```

## step 3:
list all available drives:
``` console
lsbl²k
```
## step 4:
Chose a drive where you want to install your arch:
``` console
cgdisk /dev/sda1
```
Partition your disk and reformat it.
You should have 3 partitions in total:

| N° | mount name | total allocated size | partition type | Format type |
| -- | ---------- | -------------------- | -------------- | ----------- |
| 1  |    /boot   |          2Gb         |    EFI 8300    |    fat 32   |
| 2  |    /swap   |           4Gb        |    SWAP 8200   |    swap     |
| 3  |    /arch   |    All remaining     |    EFI 8300    |    ext4     |

Write the partition table.

check the partitioning:
``` console
lsblk 
```
## step 5:
Format the partitions:

1./ partition boot:
``` console
mkfs.fat -F32 /dev/< name1 >
```

2./ partition swap:
``` console
mkswap /dev/< name2 >
```

3./ partition arch:
``` console
mkfs.ext4 /dev/< name3 >
```

check the formatting:
``` console
lsblk
```

## step 6:
Mounting the partitions:

1./ mouting swap:
``` console
swapon /dev/< name2 >
```

2./ mouting arch:
``` console
mount /dev/< name3 > /mnt
```

3./ mouting boot:
``` console
mkdir -p /mnt/boot
mount /dev/< name1 > /mnt/boot
```

## step 7:

Installing essential packages:

``` console
pacstrap /mnt base linux linux-firmware base-devel vi nano
```

## step 8:

Generate an fstab file 
(use -U or -L to define by UUID or labels, respectively)

``` console
genfstab -U /mnt >> /mnt/etc/fstab
```

## step 9:
Get into the installation instance of Arch:
``` console
arch-chroot /mnt
```

## step 10:

set timeztone:

``` console
ln -sf /usr/share/zoneinfo/< your zone > /etc/localtime
hwclock --systohc
```

set local:
``` console
vi /etc/locale.gen
locale-gen
```

set lang locale
``` console
vi /etc/locale.conf
LANG=en_US.UTF-8
```

set keyboard layout
``` console
vi /etc/vconsole.conf
KEYMAP=en
```

set hostname
``` console
vi /etc/hostname
atreides
```

Initramfs:
``` console
 mkinitcpio -P
```

set password:
``` console
passwd
```

## step 11:
set GRUB as a bootloader:

Install grub and efiboot manager
``` console
pacman -Sy grub efibootmgr
```

Install grub as bootloader:
< boot dir > in our case is /boot
``` console
grub-install --target=x86_64-efi --efi-directory=< boot dir > --bootloader-id=GRUB
```

## step 12:
Configure GRUB

``` console
grub-mkconfig -o /boot/grub/grub.cfg
```

## step 13:
reboot your arch to check for system stability.

## step 14:

Enable and configure Networking

``` console
systemctl start systemd-networkd && systemctl enable systemd-networkd
systemctl start systemd-resolved && systemctl enable systemd-resolved
```

list your network interfaces:
``` console
networkctl list
```

configuring interfaces on DCHP:

``` console
vi /etc/systemd/network/10-wired-interface-1.network

[Match]
Name=<interface name>

[Network]
DHCP=yes
```

restart networking
``` console
systemctl restart systemd-networkd && systemctl restart systemd-resolved
```

## step 15:

Add a user:
``` console
useradd -g users -G wheel,storage,power -m paul
passwd paul
```


## step 16:

set wheel group as sudoers by uncommenting wheel

``` console
visudo 
```
