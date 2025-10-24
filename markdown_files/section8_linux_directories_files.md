---
title: "Essential Linux Directories & Files (Core)"
sub_title: "Linux Commands Course · Section 8"
author: "IDSchool"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Linux Filesystem Philosophy
===========================
Everything in Linux is organized under a **single root directory `/`**.

- No drive letters (like C: or D:)
- All devices, users, and applications live under `/`
- Each directory has a specific purpose

Think of it as a **tree**, with `/` as the root and everything branching from it.

---

Core Directory Layout Overview
==============================
| Directory | Purpose |
|------------|----------|
| `/bin` | Essential user binaries (commands needed for all users) |
| `/sbin` | System binaries (commands for system administration) |
| `/usr/bin` | Most user commands and applications |
| `/usr/sbin` | System admin tools not required for booting |
| `/etc` | System configuration files |
| `/var` | Variable data (logs, mail, cache) |
| `/home` | User home directories |
| `/tmp` | Temporary files (cleared on reboot) |
| `/dev` | Device files (represent hardware or virtual devices) |
| `/proc` | Virtual filesystem exposing process and kernel info |
| `/sys` | System and hardware information (kernel interface) |
| `/opt` | Optional or third-party software packages |

---

/bin and /sbin
==============
Contain the most **fundamental executables**.

Examples:

```bash
ls /bin
ls /sbin
```

Typical contents:
- `/bin/ls`, `/bin/cp`, `/bin/mv`, `/bin/cat`
- `/sbin/reboot`, `/sbin/ifconfig`, `/sbin/fsck`

Used during system boot and single-user recovery mode.

---

/usr/bin and /usr/sbin
======================
`/usr` = “Unix System Resources.”

Holds the **main body of user utilities** and optional system tools.

```bash
ls /usr/bin | head
ls /usr/sbin | head
```

Applications like `vim`, `python`, `gcc`, `systemctl`, etc., live here.

This is where most installed software resides.

---

/etc — Configuration Files
===========================
Contains **system‑wide configuration** for all programs and services.

Examples:

```bash
ls /etc
```

Subdirectories like `/etc/network`, `/etc/ssh`, `/etc/systemd` hold their respective configs.

These files are usually **plain text**, editable with a text editor.

---

/var — Variable Data
====================
“Variable” because contents change frequently.

Common uses:
- `/var/log/` → log files (`syslog`, `auth.log`)
- `/var/spool/` → print/mail queues
- `/var/cache/` → cached data
- `/var/lib/` → application state (databases, package info)

Example:

```bash
ls /var/log
```

Logs are vital for troubleshooting.

---

/home — User Directories
=========================
Each user has a personal workspace under `/home`.

Example structure:

```
/home/alice
/home/bob
```

Contains personal files, downloads, and shell settings.

```bash
ls ~
```

The `~` symbol always refers to your current user's home directory.

---

/tmp — Temporary Storage
========================
Used for short-lived files and data exchange between programs.

```bash
cd /tmp
ls
```

Cleared on reboot or after a set time.

Accessible to everyone but protected by the **sticky bit** so users can’t delete others’ files.

---

/dev — Devices as Files
=======================
Represents hardware and virtual devices as files.

```bash
ls /dev | head
```

Examples:
- `/dev/sda` — first hard drive
- `/dev/null` — data sink (discards anything written)
- `/dev/tty` — current terminal
- `/dev/random` — random data source

Device files enable programs to interact with hardware using normal file operations.

---

/proc — Process and Kernel Info
===============================
A **virtual filesystem** reflecting live system state.

```bash
ls /proc | head
```

Contains pseudo‑files for each running process (`/proc/<PID>/`).

Key files:
- `/proc/cpuinfo` — CPU details
- `/proc/meminfo` — memory usage
- `/proc/uptime` — uptime information

Read‑only for observation; data is generated dynamically.

---

/sys — Kernel and Device Management
===================================
`/sys` is similar to `/proc` but more structured.

Contains live info about devices, drivers, and kernel modules.

Example:

```bash
ls /sys/class
```

Used by udev and other system components to manage devices dynamically.

---

/opt — Optional Software
========================
Holds **add‑on applications** installed outside the package manager.

Example paths:
- `/opt/google/chrome/`
- `/opt/lampp/`

You can place self‑contained programs or third‑party tools here.

---

Must‑Know System Files
======================
| File | Description |
|------|--------------|
| `/etc/passwd` | User account information (username, UID, home, shell) |
| `/etc/shadow` | Encrypted passwords and aging info (root‑only) |
| `/etc/group` | Group membership definitions |
| `/etc/fstab` | Filesystems to mount at boot |
| `/etc/hosts` | Local hostname‑to‑IP mapping |
| `/etc/resolv.conf` | DNS resolver configuration |
| `/etc/sudoers` | sudo access control rules |
| `~/.bashrc` | User‑specific shell customization |
| `~/.profile` | Environment setup on login |

---

/etc/passwd Example
===================
```bash
cat /etc/passwd | head -3
```
Example line:
```
student:x:1000:1000:Student User:/home/student:/bin/bash
```

Fields (colon‑separated):
1. Username  
2. Placeholder (historically password, now stored in `/etc/shadow`)  
3. UID (User ID)  
4. GID (Group ID)  
5. Comment / full name  
6. Home directory  
7. Login shell  

---

/etc/shadow Example
===================
Only readable by root.

```bash
sudo head /etc/shadow
```

Stores encrypted passwords and password aging information.

Never edit this file manually — use `passwd` command instead.

---

/etc/group Example
==================
Defines group memberships.

```bash
cat /etc/group | head
```

Each line: group name, password placeholder, GID, and members.

---

/etc/fstab — Filesystem Table
==============================
Defines which partitions and devices to mount automatically at boot.

Example:

```
UUID=xxxx-xxxx  /  ext4  defaults  0 1
UUID=yyyy-yyyy  /home  ext4  defaults  0 2
```

View safely:

```bash
cat /etc/fstab
```

---

/etc/hosts and /etc/resolv.conf
===============================
`/etc/hosts` — manual hostname resolution.

Example:

```
127.0.0.1   localhost
192.168.1.10 server.local
```

`/etc/resolv.conf` — nameserver (DNS) configuration.

Example:

```
nameserver 1.1.1.1
nameserver 8.8.8.8
```

---

/etc/sudoers
=============
Controls who can run commands as other users (usually root).

Always edit with **visudo** to prevent syntax errors:

```bash
sudo visudo
```

Example rule:

```
alice ALL=(ALL:ALL) ALL
```

Meaning: Alice can run any command as any user.

---

User Configuration Files
========================
`~/.bashrc` — executed for interactive non‑login shells.  
Custom aliases, colors, and shell variables live here.

`~/.profile` — executed for login shells; sets environment variables like PATH and locale.

```bash
cat ~/.bashrc | head
```

Keep personal shell tweaks in `.bashrc`, system‑wide ones in `/etc/bash.bashrc`.

---

Recap
=====
- Linux filesystem is a single tree rooted at `/`.  
- Know what each main directory stores.  
- Learn critical system files under `/etc` and your home.  
- Configuration lives in plain text.  
- Reading these files (not editing them blindly) is key to system literacy.

---


