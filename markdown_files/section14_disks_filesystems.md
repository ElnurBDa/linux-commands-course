---
title: "Disks, Partitions & Filesystems (Core)"
sub_title: "Linux Commands Course · Section 14"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Storage Concepts
================
- **Disk** → physical device (e.g., `/dev/sda`, `/dev/nvme0n1`)
- **Partition** → logical segment of a disk (e.g., `/dev/sda1`)
- **Filesystem** → structure that defines how data is stored (e.g., ext4, xfs, btrfs)

Linux uses a single unified directory tree — all disks and partitions get *mounted* somewhere under `/`.

---

Listing Storage Devices — `lsblk`
=================================
List block devices (disks, partitions, LVM volumes).

```bash
lsblk -f
```

Example output:

```
NAME   FSTYPE LABEL  UUID                                 MOUNTPOINT
sda
├─sda1 ext4   root   21f0-4c3f                            /
├─sda2 swap   swap   a1b2c3d4-e5f6-7890-1122-334455667788 [SWAP]
```

- `NAME` → device name  
- `FSTYPE` → filesystem type  
- `MOUNTPOINT` → where it’s mounted

---

Display UUIDs and Filesystem Info — `blkid`
===========================================
Show filesystem type and unique IDs.

```bash
sudo blkid
```

Example:

```
/dev/sda1: UUID="21f0-4c3f" TYPE="ext4" PARTLABEL="root"
/dev/sda2: UUID="a1b2c3d4" TYPE="swap"
```

UUIDs are used in `/etc/fstab` for stable device mounting.

---

Check Disk Usage — `df -h`
==========================
View mounted filesystems and their space usage.

```bash
df -h
```

Example:

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /
tmpfs           2.0G  2.0M  2.0G   1% /run
```

`-h` makes sizes human-readable.

---

Directory Usage — `du`
=====================
Show how much space files and directories take.

```bash
du -sh *
```

- `-s` → summarize totals  
- `-h` → human-readable sizes

Example output:

```
4.0K  Documents
1.2G  Downloads
400M  Pictures
```

Great for finding large folders.

---

Mounting a Filesystem — `mount`
===============================
Mount a device (attach it to a directory).

```bash
sudo mount /dev/sdb1 /mnt
```

Verify with:

```bash
df -h | grep sdb1
```

Unmount when done:

```bash
sudo umount /mnt
```

Mount read-only:

```bash
sudo mount -o ro /dev/sdb1 /mnt
```

---

Persistent Mounts — `/etc/fstab`
================================
`/etc/fstab` defines filesystems that auto-mount at boot.

View file:

```bash
cat /etc/fstab
```

Example entry:

```
UUID=21f0-4c3f  /data  ext4  defaults  0 2
```

Fields:
1. Device or UUID  
2. Mount point  
3. Filesystem type  
4. Options (`defaults`, `ro`, `noatime`, etc.)  
5. Dump (backup flag)  
6. fsck order (1=root, 2=others)

---

Partitioning (Demo Only!) — `fdisk` and `parted`
================================================
Use **only with care** — modifying partitions can erase data!

List disks and partitions:

```bash
sudo fdisk -l
```

Interactive mode (dangerous!):

```bash
sudo fdisk /dev/sdb
```

For modern disks (>2TB) use `parted`:

```bash
sudo parted /dev/sdb
```

You can view, create, and delete partitions. Always unmount before modifying.

---

Creating a Filesystem — `mkfs`
==============================
Format a partition with a filesystem.

Example (ext4):

```bash
sudo mkfs.ext4 /dev/sdb1
```

Other examples:

```bash
sudo mkfs.xfs /dev/sdb1
sudo mkfs.vfat /dev/sdb1
```

Check before formatting to avoid destroying data!

---

Filesystem Check — `fsck`
=========================
Scans and repairs filesystem errors.

```bash
sudo fsck /dev/sdb1
```

Run only on **unmounted** filesystems.

You can auto-confirm fixes with `-y`:

```bash
sudo fsck -y /dev/sdb1
```

---

Filesystem Tuning — `tune2fs`
=============================
View or modify filesystem parameters (ext filesystems).

```bash
sudo tune2fs -l /dev/sda1
```

Example adjustments:

```bash
sudo tune2fs -m 1 /dev/sda1   # reserve 1% space for root
sudo tune2fs -c 0 /dev/sda1   # disable auto-check by mount count
```

---

Resizing Filesystems — `resize2fs`
==================================
Resize an **ext** filesystem after adjusting partition size.

Shrink (offline only):

```bash
sudo resize2fs /dev/sdb1 20G
```

Expand to fill available space:

```bash
sudo resize2fs /dev/sdb1
```

Run after resizing partition with `fdisk` or `parted`.

---

Swap Space — Virtual Memory
===========================
Linux uses **swap** as overflow for RAM.

Enable swap area:

```bash
sudo swapon /dev/sda2
```

Disable it:

```bash
sudo swapoff /dev/sda2
```

Show current swap usage:

```bash
swapon --show
```

Or view via `free -h`.

---

Creating a Swap File (Alternative)
==================================
If no swap partition exists, create one as a file.

```bash
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

Make it permanent in `/etc/fstab`:

```
/swapfile none swap sw 0 0
```

---

Recap
=====
- Inventory: `lsblk`, `blkid`, `df -h`, `du -sh *`  
- Mounting: `mount`, `umount`, `/etc/fstab`  
- Partitioning (demo): `fdisk`, `parted`  
- Filesystems: `mkfs`, `fsck`, `tune2fs`, `resize2fs`  
- Swap: `swapon`, `swapoff`, `/swapfile`  

These commands form the foundation of disk and storage management in Linux.

---


