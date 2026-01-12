---
title: "Linux Command Line Practice"
sub_title: "Hands-on Tasks · Core Linux Skills"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---

Lab Setup (Run Once)
=====

🎯 Goal: Create a predictable workspace for all students

Run this to generate the full lab environment:

```bash
# this file is also shared with you
bash thescript.sh
````

✅ Verify and enter the lab:

```bash
ls ~/lab
cd ~/lab
pwd
```

---

Section 1 — Where Am I?
=====

🎯 Goal: Understand where you are and what exists around you

Tasks:

* Show your current directory
* List files in the current directory
* List files one per line
* List files including hidden ones
* Move into your home directory
* Move back into `~/lab`
* Move one directory up, then return to `~/lab`
* Display the directory structure (2 levels deep) from inside `~/lab`

---

Section 2 — Building Your Workspace
=====

🎯 Goal: Create and organize directories inside the lab

Tasks:

* Inside `~/lab/tmp`, create a directory called `sandbox`
* Inside `sandbox`, create:

  * `docs`
  * `data`
  * `backup`
* Verify the structure visually
* Remove only the empty directories inside `sandbox`
* Recreate them again
* Remove `sandbox` completely (only if it is empty)

---

Section 3 — Creating Files
=====

🎯 Goal: Create and inspect files in a controlled place

Tasks:

* Inside `~/lab/tmp/sandbox`, create empty files:

  * `notes.txt`
  * `todo.txt`
  * `log.txt`
* Add at least 5 lines of text into `notes.txt`
* Display the full file
* View it using a pager
* Show only the first 3 lines
* Show only the last 2 lines

---

Section 4 — Moving & Copying
=====

🎯 Goal: Control file movement using the sandbox

Tasks:

* Copy `~/lab/notes.txt` into `~/lab/backup`
* Copy `~/lab/todo.txt` into `~/lab/backup/daily`
* Rename `~/lab/todo.txt` to `~/lab/tasks.txt`
* Move `~/lab/log.txt` into `~/lab/data/raw`
* Copy multiple files at once from `~/lab/docs` into `~/lab/backup`
* Remove a file safely from `~/lab/trash`
* Remove an empty directory inside `~/lab/tmp` (if any)

---

Section 5 — Understanding Files
=====

🎯 Goal: Inspect file metadata using real lab files

Tasks:

* Identify the type of:

  * `~/lab/notes.txt`
  * `~/lab/projects/web/index.html`
  * `~/lab/data/json/users.json`
  * `~/lab/projects/app` (directory)
* Display detailed file statistics for `~/lab/notes.txt`
* Compare file sizes between:

  * `~/lab/notes.txt`
  * `~/lab/log.txt`
  * `~/lab/data/raw/access.log`
* Check modification timestamps on at least 3 different files

---

Section 6 — Permissions Playground
=====

🎯 Goal: Control access (practice safely inside ~/lab/tmp)

Tasks:

* Check permissions of files in `~/lab`
* Make `~/lab/script.sh` executable
* Remove write permission for others on `~/lab/notes.txt`
* Check your current umask
* Inside `~/lab/tmp`, create a new file and observe default permissions
* If permitted, change group ownership of one file inside `~/lab/tmp`
* If permitted, change file owner of one file inside `~/lab/tmp`
* Re-check permissions to confirm changes

---

Section 7 — Finding Things
=====

🎯 Goal: Locate files and commands using the lab structure

Tasks:

* Find where these commands live:

  * `ls`
  * `grep`
  * `tar`
* Discover whether `echo` is a built-in or an external command
* Search inside `~/lab` for:

  * all `.log` files
  * all `.json` files
  * directories named `logs`
* Find files modified today inside `~/lab`
* Count how many `.txt` files exist inside `~/lab`

---

Section 8 — Reading & Counting Text
=====

🎯 Goal: Use counting + sorting on real datasets

Tasks:

* Count lines in:

  * `~/lab/data/raw/names.txt`
  * `~/lab/data/raw/colors.txt`
* Count words only in `~/lab/README.txt`
* Sort `~/lab/data/raw/names.txt` alphabetically into a new file in `~/lab/data/clean`
* Remove duplicate names and save the unique list in `~/lab/data/clean`
* Count unique values in `~/lab/data/raw/colors.txt`
* Build a pipeline that shows the top repeated name(s) with their counts

---

Section 9 — Pipes & Redirection
=====

🎯 Goal: Chain commands and save results

Tasks:

* Redirect the long listing of `~/lab` into `~/lab/tmp/lab_listing.txt`
* Append the listing of `~/lab/data/raw` to the same file
* Redirect an intentional error into `~/lab/tmp/errors.txt` (hint: try listing a non-existent path)
* Redirect both output and errors of a command into one file in `~/lab/tmp`
* Use input redirection to sort a file from `~/lab/data/raw`
* Build a pipeline that:

  * filters `ERROR` lines from `~/lab/log.txt`
  * sorts them
  * removes duplicates
  * saves the result in `~/lab/data/clean/errors_only.txt`

---

Section 10 — Editing Streams
=====

🎯 Goal: Modify text safely using files in ~/lab/tmp

Tasks:

* Copy `~/lab/data/raw/errors.log` into `~/lab/tmp/errors_work.log`
* Replace `ERROR` with `ERROR:` in the copied file (stream output)
* Replace globally and save into a new file in `~/lab/tmp`
* Delete the lines containing `INFO` from the copied file (save into a new file)
* Modify `~/lab/tmp/errors_work.log` in-place to uppercase `warn` → `WARN` (only if present)

---

Section 11 — JSON & Web Data
=====

🎯 Goal: Practice jq with local lab JSON + curl

Tasks:

* Pretty-print:

  * `~/lab/data/json/users.json`
  * `~/lab/data/json/device.json`
* Extract all user names from `~/lab/data/json/users.json`
* Extract only active users from `~/lab/data/json/users.json`
* Extract the hostname field from `~/lab/data/json/device.json`
* Use `curl` to download JSON from a public API and pretty-print it with `jq`
* Save one filtered JSON output into `~/lab/data/json/filtered.json`

---

Section 12 — Archiving & Compression
=====

🎯 Goal: Package lab artifacts

Tasks:

* Create a tar archive of `~/lab/docs` into `~/lab/archives/docs.tar`
* List archive contents without extracting
* Extract it into `~/lab/tmp/extract_docs`
* Compress `~/lab/archives/docs.tar` using gzip
* Decompress it back
* Create a zip archive of `~/lab/data/json` into `~/lab/archives/json.zip`
* Verify zip contents without extracting

---

Section 13 — Users & Identity
=====

🎯 Goal: Understand who you are and who is on the system

Tasks:

* Display your username
* Display your user ID and group IDs
* List your groups
* See who is logged in
* Compare outputs of `who` and `w`
* Check login history with `last` (observe what it shows)

---

Section 14 — User Management (Admin)
=====

🎯 Goal: Manage accounts (admin)

Tasks:

* Create a new user `labuser`
* Set a password for `labuser`
* Create a group `labteam`
* Add `labuser` to `labteam`
* Verify membership using identity commands
* Remove `labuser` safely when finished

⚠ Requires sudo access

---

Section 15 — Processes
=====

🎯 Goal: Control running programs

Tasks:

* List all running processes
* Find processes related to your shell
* Monitor processes live using `top` (and `htop` if available)
* Start a background process (use a long sleep)
* Find its PID using process-search tools
* Stop it gracefully
* Force stop it
* Kill by name using a name-based tool (only for a process you started)

---

Section 16 — Cleanup Mission 🧹
=====

🎯 Goal: Clean your workspace (without deleting the main lab)

Tasks:

* Find and remove files inside `~/lab/trash`
* Remove `~/lab/tmp/extract_docs` if it exists
* Remove any empty directories inside `~/lab/tmp`
* Verify the lab is still intact:

  * list `~/lab`
  * show the tree (2 levels deep)

---
