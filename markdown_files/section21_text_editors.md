---
title: "Text Editors (Core) — Nano & Vi"
sub_title: "Linux Commands Course · Section 21"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Nano — The Beginner-Friendly Editor
===================================
Nano is simple and intuitive, ideal for quick file edits.

Open or create a file:

```bash
nano filename.txt
```

You’ll see the file contents and a list of commands at the bottom.

Commands use the **Ctrl (^)** and **Meta (M or Alt)** keys.

---

Common Nano Shortcuts
=====================
| Command | Action |
|----------|---------|
| `Ctrl + O` | Write (save) file |
| `Ctrl + X` | Exit (prompts to save if needed) |
| `Ctrl + G` | Help |
| `Ctrl + K` | Cut selected text or line |
| `Ctrl + U` | Paste (after cut) |
| `Ctrl + W` | Search text |
| `Alt + W` | Repeat search |
| `Ctrl + \` | Replace text |
| `Ctrl + A` | Move to start of line |
| `Ctrl + E` | Move to end of line |
| `Ctrl + Y` | Page up |
| `Ctrl + V` | Page down |
| `Alt + A` | Start selecting text |
| `Ctrl + C` | Show cursor position |

---

Nano Configuration Tips
=======================
Enable line numbers and syntax highlighting by default:

Edit or create your `~/.nanorc` file:

```bash
set linenumbers
set tabsize 4
set autoindent
set mouse
```

Exit and restart Nano to apply changes.

---

Vi / Vim — The Power User’s Editor
==================================
`vi` (or its enhanced version `vim`) is a **modal editor** — it operates in different modes.

Modes:
- **Normal mode** — navigation and commands
- **Insert mode** — text editing
- **Command-line mode** — executing editor commands

Open or create a file:

```bash
vi filename.txt
```

---

Basic Vi Workflow
=================
When Vi starts, it opens in **Normal mode**.

1. Press `i` → enter **Insert mode** to type text  
2. Write or edit your content  
3. Press `Esc` → return to **Normal mode**  
4. Save and quit (see below)

---

Essential Vi Commands
=====================
| Mode | Command | Description |
|------|----------|-------------|
| Normal | `i` | Insert mode before cursor |
| Normal | `a` | Insert mode after cursor |
| Normal | `o` | New line below and insert |
| Normal | `O` | New line above and insert |
| Normal | `x` | Delete character under cursor |
| Normal | `dd` | Delete entire line |
| Normal | `yy` | Copy (yank) current line |
| Normal | `p` | Paste below |
| Normal | `P` | Paste above |
| Normal | `u` | Undo |
| Normal | `Ctrl + r` | Redo |
| Normal | `/text` | Search for text |
| Normal | `n` | Next search result |
| Normal | `N` | Previous search result |
| Normal | `:%s/old/new/g` | Replace all occurrences |

---

Saving and Quitting in Vi
=========================
Enter **Command mode** (press `:` while in Normal mode).

| Command | Action |
|----------|---------|
| `:w` | Save (write) file |
| `:q` | Quit (fails if unsaved changes) |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:w newfile.txt` | Save as a new file |

---

Navigation in Vi
================
| Key | Action |
|------|---------|
| `h` | Move left |
| `l` | Move right |
| `j` | Move down |
| `k` | Move up |
| `0` | Beginning of line |
| `$` | End of line |
| `gg` | Beginning of file |
| `G` | End of file |
| `Ctrl + f` | Page down |
| `Ctrl + b` | Page up |
| `:set number` | Show line numbers |
| `:set nonumber` | Hide line numbers |

---

Visual Selection (Highlighting Text)
====================================
Enter **Visual mode** from Normal mode:

- `v` — character-wise selection  
- `V` — line-wise selection  
- `Ctrl + v` — block (column) selection

After selecting, you can:
- `y` — yank (copy)
- `d` — delete
- `p` — paste

---

Vi Configuration File
=====================
Customize Vim behavior via `~/.vimrc` (create if missing).

Example settings:

```bash
set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
syntax on
```

Reload Vim to apply these settings.

---

Quick Comparison — Nano vs Vi
==============================
| Feature | Nano | Vi / Vim |
|----------|------|-----------|
| Ease of use | Very easy | Steeper learning curve |
| Modes | None | Modal (Normal, Insert, Command) |
| Highlighting | Yes (with config) | Yes (default in Vim) |
| Mouse support | Yes | Optional |
| Best for | Quick edits | Power editing, scripting |
| Exit confusion | Rare | Frequent :) |

---

Recap
=====
- **Nano** — simple editor with intuitive shortcuts.  
- **Vi/Vim** — modal editor with powerful commands.  
- Both are preinstalled on nearly all Linux systems.  
- Knowing both ensures you can edit files on any Linux machine.

---

