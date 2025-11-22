---
title: "Quality-of-Life & Modern CLI Helpers (Optional)"
sub_title: "Linux Commands Course · Section 20"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Quick References — `tldr`
=========================
`tldr` provides concise, example-driven help pages for common commands.

Install it:

```bash
sudo apt install tldr
# or
pip install tldr
```

Usage:

```bash
tldr tar
tldr grep
```

Example output for `tldr tar`:

```
tar — Archiving utility
Examples:
  - Create a gzip-compressed archive:
      tar -czvf archive.tar.gz directory/
  - Extract an archive:
      tar -xzvf archive.tar.gz
```

Fast, clean, and easy to read — great for quick reminders.

---

Faster File Searching — `fd`
============================
`fd` is a simple, fast, user-friendly alternative to `find`.

Install (Debian/Ubuntu):

```bash
sudo apt install fd-find
```

Basic usage:

```bash
fd main
fd -e txt -e md
```

- Ignores `.gitignore`-excluded files by default  
- Colorful output  
- Much faster than `find` for interactive use

You might need to symlink for convenience:

```bash
ln -s $(which fdfind) ~/.local/bin/fd
```

---

Faster Grep — `ripgrep (rg)`
=============================
`ripgrep` (`rg`) is a blazing-fast alternative to `grep` that respects `.gitignore` and highlights matches.

Install:

```bash
sudo apt install ripgrep
```

Search recursively for text:

```bash
rg "TODO"
```

Limit by file type:

```bash
rg "error" --type py
```

Count matches per file:

```bash
rg -c "pattern"
```

Faster than both `grep` and `ack`.

---

Better Cat — `bat`
==================
`bat` enhances `cat` with syntax highlighting, line numbers, and paging.

Install:

```bash
sudo apt install bat
```

Usage:

```bash
bat script.sh
bat /etc/passwd
```

You can also use it like `cat` in pipelines:

```bash
bat --plain file.txt | grep keyword
```

Alias it for convenience:

```bash
alias cat='batcat'
```

---

Monitoring Tools — `btop`, `nload`, `iftop`
===========================================
### `btop`
A colorful and interactive resource monitor.

```bash
sudo apt install btop
btop
```

Features:
- CPU, memory, disk, and network usage graphs
- Process viewer with search and sorting
- Mouse support and theme customization

### `nload`
Real-time network bandwidth monitor (per interface).

```bash
sudo apt install nload
nload
```

Displays incoming and outgoing traffic separately.

### `iftop`
Interactive bandwidth usage by connection.

```bash
sudo apt install iftop
sudo iftop
```

Shows which hosts are consuming bandwidth — great for network debugging.

---

Comparisons and Recommendations
===============================
| Classic Tool | Modern Alternative | Benefit |
|---------------|--------------------|----------|
| `man` | `tldr` | Quick, example-focused help |
| `find` | `fd` | Faster, simpler syntax |
| `grep` | `ripgrep (rg)` | Fast recursive search with colors |
| `cat` | `bat` | Pretty printing and highlighting |
| `top` | `btop` | Graphical monitoring |
| `iftop` | (modern already) | Network inspection |
| `nload` | (modern already) | Lightweight bandwidth view |

---

Bonus Tips
==========
You can create an **alias group** for modern replacements:

```bash
alias cat='batcat'
alias grep='rg'
alias find='fd'
alias top='btop'
```

Store them in `~/.bashrc` to persist.

---

Recap
=====
- **tldr** — short and friendly command reference  
- **fd** — faster file search  
- **ripgrep (rg)** — next-gen grep  
- **bat** — colorful file viewer  
- **btop**, **nload**, **iftop** — intuitive performance monitors  

These tools make everyday terminal work faster, clearer, and more enjoyable.

---


Congratulations!
================
You’ve completed the **Linux Commands Course** — from fundamentals to modern workflow tools.

Next: combine your skills to create your own shell utilities and automation scripts!
