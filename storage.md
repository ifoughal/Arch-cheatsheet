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


# Rook-Ceph clustering

## Introduction:
Ceph is a unified distributed storage system, supporting:
- RGW: S3 / swift / object storage
- RBD: Block device
- CEPHFS (Distributed NFS)

## Components:
### CEPH:
- Ceph-Mon:
  - Central authoritiy for authentication, data placement, policies
  - Coordinates all the cluster compnents
  - Protects critical cluster state
  - 3 to 7 per cluster
- Manager:
  - Aggregates real-time metrics
  - Host for pluggable maangement functions
  - 1 active + 1 standby per clsuter
- OSDs:
  - stores data on devices (HDD, SSD, NVMe, etc)
  - services I/O requests to clients
  - peers, replicates and rebalances data
  - 10-1000 per cluster

- CephFS: ditributed Network file system
  - POSIX-compliant distributed file system, allows to share file storage accross multiple clients (distributed network file system, allowing sclability and fault tolerance)
  - Allows multiple client to RW on the mounted filesystem as if it was a local disk
  - data is handled and stored in RADOS (Ceph replication, fault tolerance, scalability)
  - supports FS operations: files, symlinks; dirs, permissions, hardlinks, etc.
  - has 2 components:
    - MDS: Metadata server
      - Data is stored in RADOS, but metadata (permissions, dir structures, etc) is managed by MDS daemons
      - can be scaled up for performance and HA and LB 
    - RADOS OSDs
      - actual file data is stored in OSDs, distributed, replicated accross the ceph cluster      
- RBD:
  - RADOS (reliable autonomic distributed object store) core layer in Ceph, which distributes & replicates storage accross the cluster nodes to increase reliability and scalability
  - RBD: (Rados Block device) is the block storage interface build on top of RADOS; used to expose ceph storage as virtual bloc disks for OSes; snapshots/clones; Thin Provisionning with LVM.
          eg use cases:
          - VM storage for hypervisors like OpenStack
          - PV for K8s via ceph CSI driver
          - Block storage for stateful applications like DBs, message queues (kafka), web services. etc.
- CEPH CSI (Container Storage Interface):
  - A kubernetes driver that allows to use Ceph storage (RBD/CEPHFS) as PVs
  - A standard developped to allow k8s to talk to storage systems in a uniform way (CRDs)
  - Enables snapsho and cloning support
  - Enables access modes: readwrite once/many, readonly many
  - defined via the k8s storage class
  - matches the pods PVC to a new RBD volume or CephFS subvolume, which gets automounted during the pod creation
- RGW: object storage access, 1 process minimum

  
- 
### ROOK:
Manager of ceph for kubernetes
Runs a statefulset on all nodes



