# Useful commands for storage handling

### How to list all available drives (useful when mounting):
``` console
fdisk -l
```

### How to unmount a storage at /mnt:

``` console
umount -l /mnt/
```

### How to check storage for errors:

``` console
ntfsfix /dev/sdb2
```


### How to force mount a ntfs storage for windows storage support:

``` console
mount -t ntfs-3g /dev/sdb2 /mnt/hdd -o force
```

### How to force mount a fat storage for windows storage support:

``` console
mount -t vfat /dev/sda3 /hdd -o force,umask=000
```

### permanenet mounting:

get your mounts uuid:

``` console
blkid
```

example results:
``` console
/dev/sdb2: BLOCK_SIZE="512" UUID="105410D1105410D1" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="30ab56e2-c9cd-40d7-8931-9ddc2d043bd0"
```

set new entries on fstab:

``` console
UUID=105410D1105410D1         /media/hdd           ntfs          defaults   0 0
```

