---
title: "Packages & Software Management (Core)"
sub_title: "Linux Commands Course · Section 13"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


What Are Packages?
==================
A **package** is a compressed bundle that contains:
- Program files (binaries, libraries, icons)
- Configuration files
- Metadata (version, dependencies, maintainer info)

Instead of manually copying files, the **package manager** handles installation, updates, and removal automatically.

---

Where Packages Come From — Repositories
=======================================
Linux distributions host packages on remote **repositories (repos)** — organized servers containing signed software.

Each system has a list of repositories stored in config files, such as:
- `/etc/apt/sources.list` (Debian/Ubuntu)
- `/etc/yum.repos.d/` (RHEL/Fedora)
- `/etc/pacman.conf` (Arch)
- `/etc/zypp/repos.d/` (openSUSE)

The package manager connects to these servers to download and verify packages.

---

APT (Advanced Package Tool) — Debian/Ubuntu
===========================================
APT is the package manager used by **Debian**, **Ubuntu**, and their derivatives (Mint, Kali, etc.).

---

Updating Package Information
============================
Before installing anything, update your local list of available software:

```bash
sudo apt update
```

This syncs your system with the repository metadata — names, versions, and dependencies.

Then upgrade installed software:

```bash
sudo apt upgrade
```

- `apt update` → refreshes the list  
- `apt upgrade` → installs newer versions of already-installed packages  

To upgrade all packages and remove obsolete ones:

```bash
sudo apt full-upgrade
```

---

Installing Packages
===================
Install one or multiple packages:

```bash
sudo apt install curl vim git
```

APT automatically downloads dependencies and installs them.

Install a specific version:

```bash
sudo apt install nginx=1.18.0-0ubuntu1
```

---

Removing Packages
=================
Remove a package but keep its config files:

```bash
sudo apt remove nginx
```

Remove a package **and** its configs:

```bash
sudo apt purge nginx
```

Clean up unnecessary packages and cache:

```bash
sudo apt autoremove
sudo apt clean
```

---

Inspecting Packages
===================
Check if a package is installed:

```bash
dpkg -l | grep nginx
```

Show detailed info:

```bash
apt show nginx
```

List files installed by a package:

```bash
dpkg -L nginx
```

Find which package a file belongs to:

```bash
dpkg -S /usr/bin/ls
```

---

Installing Local `.deb` Files — `dpkg`
=====================================
Install a `.deb` file manually (downloaded from a website):

```bash
sudo dpkg -i package.deb
```

If dependencies are missing, fix them with:

```bash
sudo apt -f install
```

This tells APT to install the required packages automatically.

---

RHEL/Fedora — `dnf` and `rpm`
==============================
`dnf` (successor to `yum`) is used on **RHEL**, **Fedora**, and **CentOS**.

Install software:

```bash
sudo dnf install nginx
```

Remove software:

```bash
sudo dnf remove nginx
```

Update all packages:

```bash
sudo dnf update
```

Query package info:

```bash
dnf info nginx
```

Manual package management via RPM:

```bash
sudo rpm -qi nginx    # info
sudo rpm -ql nginx    # list files
sudo rpm -ivh file.rpm  # install
sudo rpm -e package    # remove
```

---

Arch Linux — `pacman`
=====================
The **pacman** package manager uses `.pkg.tar.zst` packages from Arch repositories.

Update repository and system in one command:

```bash
sudo pacman -Syu
```

Install a package:

```bash
sudo pacman -S firefox
```

Remove a package:

```bash
sudo pacman -R firefox
```

Search for packages:

```bash
pacman -Ss python
```

View info:

```bash
pacman -Qi firefox
```

---

openSUSE — `zypper`
===================
`zypper` is the package tool for **openSUSE** and **SLE** systems.

Refresh repositories:

```bash
sudo zypper refresh
```

Install packages:

```bash
sudo zypper in vim
```

Remove packages:

```bash
sudo zypper rm vim
```

Update system:

```bash
sudo zypper up
```

Show package info:

```bash
zypper info vim
```

---

Universal Package Systems
=========================
Some distributions support **universal formats** — portable across distros.

### Snap
Developed by Canonical, runs sandboxed applications.

List installed snaps:

```bash
snap list
```

Install a snap package:

```bash
sudo snap install code --classic
```

Remove a snap:

```bash
sudo snap remove code
```

### Flatpak
Another universal, sandboxed format.

Install a Flatpak application:

```bash
flatpak install flathub org.gimp.GIMP
```

Run a Flatpak app:

```bash
flatpak run org.gimp.GIMP
```

List installed Flatpaks:

```bash
flatpak list
```

---

Comparing Package Managers
===========================
| Distro | Tool | Install Example | Notes |
|---------|------|------------------|--------|
| Debian/Ubuntu | `apt` | `apt install nginx` | Most common; uses `.deb` |
| RHEL/Fedora | `dnf` | `dnf install nginx` | Uses `.rpm` |
| Arch | `pacman` | `pacman -S nginx` | Very fast, rolling updates |
| openSUSE | `zypper` | `zypper in nginx` | Enterprise‑grade |
| Universal | `snap`, `flatpak` | Cross‑platform apps | Great for desktop software |

---

Recap
=====
- **APT** — update, install, remove, purge, inspect packages  
- **Repositories** — centralized sources of verified software  
- **dpkg** — for manual `.deb` installs  
- **dnf / rpm**, **pacman**, **zypper** — alternatives for other distros  
- **snap / flatpak** — universal sandboxed packages

Mastering package management makes system maintenance fast, secure, and reliable.

---


