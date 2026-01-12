---
title: "Archiving & Compression (Core)"
sub_title: "Linux Commands Course · Section 7"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


What Is Archiving?
==================
Archiving combines multiple files or folders into one container file.  
Compression makes that container smaller.

Common reasons to archive:
- Backup and transfer data
- Package projects or logs
- Preserve directory structures

Linux standard tools: `tar`, `gzip`, `bzip2`, `xz`, `zstd`, `zip`.

---

Creating Tar Archives
=====================
`tar` (tape archive) is the most common archiving utility.

Create an archive from a folder:

```bash
tar -cvf backup.tar project/
```

Options:
- `c` — create
- `v` — verbose (show files)
- `f` — file name

Extract archive:

```bash
tar -xvf backup.tar
```

List contents without extracting:

```bash
tar -tvf backup.tar
```

---

Compressed Tarballs
===================
`tar` can compress directly using `gzip`, `bzip2`, `xz`, or `zstd`.

### Create compressed archive (gzip)

```bash
tar -czvf project.tar.gz project/
```

### Extract it

```bash
tar -xzvf project.tar.gz
```

You can also use different extensions to choose the compression algorithm automatically.

---

bzip2 and xz Examples
=====================
### Create bzip2 tarball

```bash
tar -cjvf data.tar.bz2 data/
```

Extract it:

```bash
tar -xjvf data.tar.bz2
```

### Create xz tarball

```bash
tar -cJvf data.tar.xz data/
```

Extract it:

```bash
tar -xJvf data.tar.xz
```

| Flag | Algorithm | Extension |
|-------|------------|------------|
| `z` | gzip | `.gz` |
| `j` | bzip2 | `.bz2` |
| `J` | xz | `.xz` |

---

Modern Compression — zstd
=========================
`zstd` (Zstandard) is a fast modern compressor with excellent ratios.

```bash
tar -I zstd -cvf project.tar.zst project/
```

Extract:

```bash
tar -I zstd -xvf project.tar.zst
```

You can also use the standalone tools:

```bash
zstd file.txt        # creates file.txt.zst
unzstd file.txt.zst  # decompresses it
```

---

gzip and gunzip (Classic Pair)
==============================
### Compress

```bash
gzip notes.txt
```

This replaces `notes.txt` with `notes.txt.gz`.

### Decompress

```bash
gunzip notes.txt.gz
```

Or with `gzip -d notes.txt.gz`.

You can test compression ratio with:

```bash
gzip -l notes.txt.gz
```

---

bzip2 and bunzip2
=================
Better compression, slower speed.

### Compress

```bash
bzip2 report.txt
```

Creates `report.txt.bz2` and removes original.

### Decompress

```bash
bunzip2 report.txt.bz2
```

### Keep original file

```bash
bzip2 -k report.txt
```

---

xz and unxz
============
High compression ratio; often used for distributing software packages.

### Compress

```bash
xz archive.tar
```

Produces `archive.tar.xz`.

### Decompress

```bash
unxz archive.tar.xz
```

To view progress while compressing:

```bash
xz -v archive.tar
```

---

Cross‑Platform Archives — `zip` and `unzip`
===========================================
ZIP is widely supported across operating systems.

### Create zip archive

```bash
zip -r project.zip project/
```

### Extract zip file

```bash
unzip project.zip
```

### Extract to specific folder

```bash
unzip project.zip -d /tmp/project
```

List contents:

```bash
unzip -l project.zip
```

---

Choosing the Right Tool
=======================
| Tool | Format | Speed | Compression | Portability | Use case |
|-------|---------|--------|--------------|--------------|-----------|
| `gzip` | .gz | Fast | Medium | High | Everyday backups |
| `bzip2` | .bz2 | Medium | Higher | Medium | Logs, archives |
| `xz` | .xz | Slow | Very High | Medium | Software packaging |
| `zstd` | .zst | Very Fast | High | Medium | Modern systems |
| `zip` | .zip | Fast | Medium | Very High | Cross-platform |

---

Inspecting Archive Contents
===========================
List files in an archive without extracting:

```bash
tar -tvf archive.tar
unzip -l project.zip
```

Test integrity (for `.zip`):

```bash
unzip -t project.zip
```

---

Combine with Pipelines
======================
Create and compress on the fly:

```bash
tar -czf - project/ | ssh backup@server "cat > /backups/project.tgz"
```

Or decompress remotely:

```bash
ssh backup@server "cat /backups/project.tgz" | tar -xz
```

This allows archiving without intermediate files.

---

<!-- end_slide -->
<!-- font_size: 5 -->
<!-- alignment: center -->
<!-- jump_to_middle -->

# Thanks!

<!-- font_size: 1 -->

#### By ElnurBDa


