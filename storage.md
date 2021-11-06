# Useful commands for storage handling

### How to list all available drives (useful when mounting):
``` console
$!  fdisk -l
```

### How to unmount a storage at /mnt:

``` console
$! umount -l /mnt/
```

### How to check storage for errors:

``` console
$! ntfsfix /dev/sdb2
```


### How to force mount a ntfs storage for windows storage support:

``` console
$! mount -t ntfs-3g /dev/sdb2 /mnt/hdd -o force
```

### How to force mount a fat storage for windows storage support:

``` console
$! mount -t vfat /dev/sda3 /hdd -o force,umask=000
```



