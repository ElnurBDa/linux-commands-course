---
title: "Permissions & Ownership (Core)"
sub_title: "Linux Commands Course · Section 3"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Why Permissions Matter
======================
Permissions protect your system and data from unauthorized changes.

Each file and directory has:
- **Owner** — the user who owns it.
- **Group** — users sharing the same project/team.
- **Others** — everyone else.

Each of these can have **read**, **write**, or **execute** rights.

---

Viewing Permissions — `ls -l`
=============================
List files with detailed information:

```bash
ls -l
```

Example output:

```bash
-rwxr-xr-- 1 student staff  1024 Oct 22 10:30 script.sh
```

Parts of the first field (`-rwxr-xr--`):

| Symbol | Meaning |
|---------|----------|
| `-` | file type (`-`=file, `d`=directory, `l`=symlink) |
| `r` | read permission |
| `w` | write permission |
| `x` | execute permission |
| `-` | permission missing |

Grouped as: **user / group / others** → `rwx r-x r--`.

---

Basic Permission Categories
===========================
| Entity | Description | Example |
|---------|-------------|----------|
| **User (u)** | The file owner | `rwx` |
| **Group (g)** | Members of the file’s group | `r-x` |
| **Others (o)** | Everyone else | `r--` |

Example string breakdown:

```
-rwxr-xr--
 ↑   ↑   ↑
 u   g   o
```

Each group has three bits — total 9 permission bits.

---

Changing Permissions — `chmod` (symbolic)
=========================================
Change permissions using symbolic notation.

Format:

```
chmod [who][operator][permission] file
```

Examples:

```bash
chmod u+x script.sh     # give user execute permission
chmod g-w file.txt      # remove group write permission
chmod o+r notes.txt     # allow others to read
chmod a-rwx test.log    # remove all access for everyone
```

Who: `u` (user), `g` (group), `o` (others), `a` (all)  
Operators: `+` (add), `-` (remove), `=` (set exactly)

---

Changing Permissions — `chmod` (octal)
======================================
Each permission is represented by a **number**:

| Permission | Binary | Value |
|-------------|---------|-------|
| read (r) | 100 | 4 |
| write (w) | 010 | 2 |
| execute (x) | 001 | 1 |

Sum them per group → **rwx = 7**, **r-x = 5**, **r-- = 4**.

Example:

```bash
chmod 755 script.sh
```

Breakdown:

| User | Group | Others | Mode |
|-------|--------|---------|------|
| rwx | r-x | r-x | 755 |

---

Common Octal Modes
==================
| Mode | Meaning | Use case |
|-------|----------|-----------|
| `644` | rw‑r‑‑r‑‑ | normal text files |
| `600` | rw‑‑‑‑‑‑ | private files |
| `755` | rwx‑r‑x‑r‑x | executable scripts, public dirs |
| `700` | rwx‑‑‑‑‑‑ | private scripts |
| `777` | rwx‑rwx‑rwx | full access (dangerous) |

**Avoid 777** unless in temporary environments.

---

Changing Ownership — `chown`
============================
Set the file’s owner (and optionally group).

```bash
sudo chown alice file.txt
```

Change both owner and group:

```bash
sudo chown alice:developers project/
```

Recursively change everything inside a directory:

```bash
sudo chown -R alice:developers /var/www/
```

Only root or file owners can change ownership.

---

Changing Group Ownership — `chgrp`
==================================
Change only the group part of ownership.

```bash
sudo chgrp staff report.txt
```

Useful when multiple users share access via a group.

---

Default Permissions — `umask`
=============================
`umask` defines what permissions **new files** start with.

Display your current mask:

```bash
umask
```

Example output: `0022` → means remove write for *group* and *others*.

Base defaults:
- Files start as `666` (rw-rw-rw-)
- Directories start as `777` (rwxrwxrwx)

So, `666 - 022 = 644` → normal default for new files.

---

Special Permission Bits — Overview
=======================
Beyond basic read/write/execute, Linux has three **special permission bits** that modify how programs run and how files are managed:

| Bit | Applies to | Symbol | Purpose |
|------|-------------|---------|-----------|
| **setuid** | Executable files | `s` in user field | Execute with file owner's privileges |
| **setgid** | Executables / directories | `s` in group field | Execute with file's group; directories inherit group |
| **sticky bit** | Directories | `t` in others field | Prevent deletion of files by non-owners |

These bits appear in the permission string when set, replacing `x` with `s` or `t`.

---

Understanding setuid (Set User ID)
===================================
**What it does:** When an executable has setuid, it runs with the **owner's privileges**, not the user who executes it.

**Why it matters:** Allows regular users to perform privileged operations safely.

**Real-world example — password change:**

```bash
ls -l /usr/bin/passwd
```

Output:

```
-rwsr-xr-x 1 root root 59976 Jan 12 2023 /usr/bin/passwd
```

Notice the `s` where `x` would normally be in the user field.

**What happens:**
- Regular user `alice` runs `/usr/bin/passwd`
- The program executes as `root` (the file owner)
- Alice can modify `/etc/shadow` (normally root-only)
- After execution, privileges return to Alice

**Common use cases:**
- `passwd` — change passwords (needs root to modify `/etc/shadow`)
- `sudo` — execute commands as another user
- `ping` — send ICMP packets (needs raw socket access)
- `mount` — mount filesystems (needs root privileges)

**Setting setuid:**

```bash
chmod u+s /path/to/program
# or using octal (4xxx)
chmod 4755 /path/to/program
```

**Security warning:** Only set setuid on trusted, well-written programs. Vulnerable setuid programs are major security risks.

---

Understanding setgid (Set Group ID)
===================================
**What it does:** Depends on whether it's set on an executable or directory.

**For executables:**
- Runs with the **file's group privileges**, not the user's group

**For directories:**
- New files created inside inherit the **directory's group**, not the creator's group

**Use case 1: Shared project directory**

Team members need to collaborate on files that should all belong to the same group:

```bash
# Create shared directory
sudo mkdir /var/projects/team-alpha
sudo chgrp developers /var/projects/team-alpha
sudo chmod 2775 /var/projects/team-alpha  # 2 = setgid
```

Check the permissions:

```bash
ls -ld /var/projects/team-alpha
```

Output:

```
drwxrwsr-x 2 root developers 4096 Oct 22 10:00 team-alpha
```

Notice the `s` in the group field.

---

Understanding setgid (Set Group ID)
===================================

**Demonstration:**

```bash
# User alice creates a file
touch /var/projects/team-alpha/report.txt
ls -l /var/projects/team-alpha/report.txt
```

Output:

```
-rw-r--r-- 1 alice developers 0 Oct 22 10:05 report.txt
```

Even though `alice` created it, the group is `developers` (inherited from directory).

**Use case 2: Group-executable programs**

```bash
# Example: a program that needs group-level access
chmod g+s /usr/local/bin/team-tool
chmod 2755 /usr/local/bin/team-tool
```

**Setting setgid:**

```bash
# Symbolic
chmod g+s directory_or_file

# Octal (2xxx)
chmod 2755 directory_or_file
```

---

Understanding Sticky Bit
=========================
**What it does:** On directories, the sticky bit ensures that **only the file owner** (and root) can delete or rename files, even if others have write permission.

**Why it's needed:** In shared writable directories, prevents users from deleting each other's files.

**Classic example — `/tmp` directory:**

```bash
ls -ld /tmp
```

Output:

```
drwxrwxrwt 15 root root 4096 Oct 22 10:30 /tmp
```

Notice the `t` in the others field (replacing `x`).

**What this means:**
- Everyone can read, write, and execute in `/tmp`
- But only the **owner** of a file can delete it
- Prevents malicious deletion of temporary files

**Demonstration:**

```bash
# User alice creates a file in /tmp
echo "Important data" > /tmp/alice-file.txt
chmod 666 /tmp/alice-file.txt  # world-writable

# User bob tries to delete it
rm /tmp/alice-file.txt
```

Result: **Permission denied** (even though bob has write permission to `/tmp`)

---

Understanding Sticky Bit
=========================

**Real-world use cases:**
- `/tmp` — system temporary directory
- `/var/tmp` — persistent temporary files
- Shared upload directories — users can upload but not delete others' files
- Mail spool directories — users can create but only delete their own mail

**Setting sticky bit:**

```bash
# Symbolic
chmod +t /path/to/directory
chmod o+t /path/to/directory

# Octal (1xxx)
chmod 1777 /path/to/directory
```

**Example: Creating a shared upload directory**

```bash
sudo mkdir /var/uploads
sudo chmod 1777 /var/uploads  # rwxrwxrwt
```

Now users can upload files, but only delete their own.

---

Setting Special Bits (Numeric Form)
===================================
Special bits use a **fourth octal digit** before the standard 3-digit mode:

| Bit | Octal Value | Combined Example | Meaning |
|------|-------------|------------------|---------|
| setuid | 4 | `4755` | rwsr-xr-x (executes as owner) |
| setgid | 2 | `2755` | rwxr-sr-x (executes as group / dir inherits group) |
| sticky | 1 | `1777` | rwxrwxrwt (world-writable, sticky protected) |

**Examples:**

```bash
# setuid executable
chmod 4755 /usr/local/bin/myadmin

# setgid directory
chmod 2775 /var/shared

# sticky bit directory
chmod 1777 /var/tmp

# Combined: setgid + sticky
chmod 3777 /var/shared-tmp  # 3 = 2 (setgid) + 1 (sticky)
```

**Checking current special bits:**

```bash
ls -l /usr/bin/passwd    # Check for setuid (s in user field)
ls -ld /var/projects     # Check for setgid (s in group field)
ls -ld /tmp              # Check for sticky (t in others field)
```

---

<!-- end_slide -->
<!-- font_size: 5 -->
<!-- alignment: center -->
<!-- jump_to_middle -->

# Thanks!

<!-- font_size: 1 -->

#### By ElnurBDa


