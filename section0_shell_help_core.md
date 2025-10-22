---
title: "Orientation — Shell & Getting Help (Core)"
sub_title: "Linux Commands Course · Section 0"
author: "IDSchool"
theme:
  name: catppuccin-mocha
options:
  # Treat each setext H1/H2 as ending the previous slide
  implicit_slide_ends: true
  list_item_newlines: 1
---

Why this section
================
You’ll get comfortable with the terminal, understand what the **shell** is, and master how to **look up help** quickly.

By the end, you’ll confidently identify commands, read their docs, and keep your session tidy.

---

Terminal vs Shell
=================
A **terminal** is the window where you type.
A **shell** is the program that reads what you type and runs it (e.g., bash, zsh, fish).

You talk to the OS through the shell. This course uses a Bourne‑style shell (bash/zsh).

---

Which shell am I using?
=======================
Print the value of the SHELL environment variable:

```bash
echo $SHELL
```

Typical outputs: `/bin/bash`, `/bin/zsh`.

---

bash and zsh — at a glance
==========================
- bash: ubiquitous default on many distros; great for scripts.
- zsh: interactive niceties (completion, prompts) while staying Bourne‑compatible for most everyday commands.

You can learn one and be productive in both.

---

Prompt anatomy
==============
A common prompt looks like this:

```bash
user@host:~$
```

- `user` — your account name
- `host` — machine name
- `~` — your home directory
- `$` — normal user (`#` means root)

---

Command anatomy
===============
Pattern you’ll see everywhere:

```
command [options] [arguments]
```

Example:

```
echo Hello
```

`echo` is the command; `Hello` is an argument printed to the screen.

---

echo — printing text
====================
Print simple text:

```bash
echo Hello
```

Preserve spaces by quoting:

```bash
echo "Multiple words stay together"
```

Show special characters literally by single‑quoting:

```bash
echo 'Use $ and * literally'
```

---

type vs which — what will run?
==============================
Discover how the shell resolves a name.

`type` (shell builtin) tells if something is a builtin, alias, function, or an external program:

```bash
type echo
```

`which` searches your PATH and shows the path to an external program:

```bash
which echo
```

If `type` says “builtin”, `which` may print nothing for that name.

---

Getting help — quick options
============================
Many programs support a short help message:

```bash
echo --help
```

Bash builtins have builtin help:

```bash
help echo
```

Use these when you just need a brief synopsis and flags.

---

Manual pages (man)
==================
Read full documentation for a command:

```bash
man echo
```

Navigation keys inside `man`:

- Space / Page Down — next page
- b / Page Up — previous page
- /pattern — search forward
- n / N — next / previous match
- q — quit

---

man sections (concept)
======================
Manuals are grouped into sections (1: user cmds, 5: file formats, 8: admin, etc.).

Open a specific section if names clash:

```bash
man 1 printf
man 3 printf
```

(Only use if you encounter multiple entries.)

---

whatis and apropos
==================
Show a one‑line description for a command name:

```bash
whatis echo
```

Search across man page descriptions by keyword:

```bash
apropos print
```

Use `apropos` when you know the task but not the command name.

---

info pages
==========
Some tools use the GNU Info system for their primary docs:

```bash
info coreutils
```

Navigation: Space → next, Backspace → previous, `q` → quit.

---

Session hygiene — history
=========================
List your recent commands with line numbers:

```bash
history
```

Press ↑ or ↓ to scroll through previous commands at the prompt.
You can re‑edit and re‑run them quickly.

---

Session hygiene — clear & reset
===============================
Clear the visible screen contents:

```bash
clear
```

If your terminal display gets garbled (binary noise, weird characters), re‑initialize it:

```bash
reset
```

`reset` is safe; it just redraws and resets modes.

---

Exit the shell
==============
End the current shell session:

```bash
exit
```

Keyboard shortcut: **Ctrl+D** (sends End‑Of‑File to the shell).

---

Keyboard shortcuts (must‑know)
==============================
| Shortcut | What it does |
|---------|---------------|
| Ctrl+C  | Stop current running command |
| Ctrl+D  | Exit shell or end input line |
| Ctrl+L  | Clear screen (like `clear`) |
| ↑ / ↓   | Browse command history |
| Tab     | Auto‑complete names |

---

Quick practice
==============
1) Show which shell you’re using.  
2) Print your name with `echo`.  
3) Find a one‑line description for `echo` using `whatis`.  
4) Use `type` and `which` on `echo`. Compare the outputs.  
5) Open `man echo`, search for the word “escape”, then quit.

---

Summary
=======
- Shell: the interpreter you talk to (`bash`, `zsh`)
- Identify commands with `type` / `which`
- Learn quickly via `--help`, `help`, `man`, `whatis`, `apropos`, `info`
- Keep sessions tidy with `history`, `clear`, `reset`
- Exit cleanly with `exit` or **Ctrl+D**
