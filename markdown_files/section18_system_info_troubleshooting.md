---
title: "System Information & Troubleshooting (Plus)"
sub_title: "Linux Commands Course · Section 18"
author: "IDSchool"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


System Facts — `uname`, `hostnamectl`, `lsb_release`
====================================================
### Kernel and architecture

```bash
uname -a
```

Example output:

```
Linux workstation 6.8.0-45-generic #1 SMP x86_64 GNU/Linux
```

Displays kernel name, version, architecture, and OS type.

### Host identity

```bash
hostnamectl
```

Output example:

```
   Static hostname: workstation
         Icon name: computer-laptop
           Chassis: laptop
        Machine ID: 3c68f3e8d9284f2d8b22a
           Boot ID: 86b9e1c9bbd64c83bb7e2
  Operating System: Ubuntu 24.04 LTS
            Kernel: Linux 6.8.0-45-generic
      Architecture: x86-64
```

### Distribution info

```bash
lsb_release -a
```

or

```bash
cat /etc/os-release
```

Shows distribution name, release, and codename.

---

Quick Health Snapshot
=====================
### Uptime and load

```bash
uptime
```

Output:

```
10:25:41 up 3 days,  2:41,  3 users,  load average: 0.20, 0.25, 0.18
```

Shows system uptime and average CPU load over 1, 5, and 15 minutes.

### Memory usage

```bash
free -h
```

Example:

```
              total        used        free      shared  buff/cache   available
Mem:           15Gi       3.5Gi       9.4Gi       256Mi       2.2Gi        11Gi
Swap:          2.0Gi       0.0Gi       2.0Gi
```

### System performance overview

```bash
vmstat 2 5
```

- Displays CPU, memory, swap, and I/O stats every 2 seconds (5 times).

### Disk I/O stats

```bash
iostat -x 2 3
```

- Requires `sysstat` package (`sudo apt install sysstat`).
- Shows read/write rates and utilization per device.

---

Kernel Messages — `dmesg`
=========================
Displays boot and kernel messages.

```bash
dmesg | less
```

Filter for hardware errors:

```bash
dmesg | grep -i error
```

Or view only recent messages:

```bash
dmesg --ctime | tail -n 20
```

Helpful for diagnosing device issues or driver problems.

---

Hardware Overview
=================
### CPU Information

```bash
lscpu
```

Example output:

```
Architecture:            x86_64
CPU(s):                  8
Model name:              Intel(R) Core(TM) i7-10750H CPU @ 2.60GHz
Thread(s) per core:      2
Core(s) per socket:      6
```

### Memory Layout

```bash
lsmem
```

Shows detected memory blocks and sizes.

---

PCI Devices — `lspci`
=====================
Lists hardware on the PCI bus (network cards, GPUs, etc.).

```bash
lspci | less
```

Example snippet:

```
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics
01:00.0 3D controller: NVIDIA Corporation RTX 3060
```

Add `-v` or `-vv` for verbose details.

---

USB Devices — `lsusb`
=====================
Show all connected USB devices.

```bash
lsusb
```

Example output:

```
Bus 001 Device 004: ID 046d:c52b Logitech USB Receiver
Bus 002 Device 002: ID 0781:5567 SanDisk Cruzer Blade
```

Use `lsusb -t` for a tree view by USB port.

---

System BIOS and Hardware Metadata — `dmidecode`
===============================================
`dmidecode` reads the **DMI/SMBIOS table** for low-level system details.

```bash
sudo dmidecode | less
```

Examples of sections:
- BIOS version and vendor
- Baseboard (motherboard) info
- Chassis and serial numbers
- Memory slot info

To target a specific type:

```bash
sudo dmidecode -t bios
sudo dmidecode -t memory
sudo dmidecode -t system
```

Read-only — safe to inspect, not modify.

---

Example — Quick System Summary
==============================
Combine tools for a complete picture:

```bash
echo "==== SYSTEM ===="
hostnamectl
echo "==== CPU ===="
lscpu | grep 'Model name'
echo "==== MEMORY ===="
free -h
echo "==== DISKS ===="
lsblk -f
echo "==== NETWORK ===="
ip a | grep inet
```

This gives an at-a-glance report of your machine.

---

Recap
=====
- **System facts:** `uname`, `hostnamectl`, `lsb_release`, `/etc/os-release`  
- **Health:** `uptime`, `free -h`, `vmstat`, `iostat`, `dmesg`  
- **Hardware:** `lscpu`, `lsmem`, `lspci`, `lsusb`, `dmidecode`  

These commands together let you audit, benchmark, and troubleshoot your Linux system effectively.

---


