---
title: "Bash Scripting (Core → Plus)"
sub_title: "Linux Commands Course · Section 16"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Your First Script — Shebang
===========================
A **shebang** tells the system which interpreter to run.

```bash
#!/usr/bin/env bash
echo "Hello from a script"
```

Save as `hello.sh`, make executable, then run:

```bash
chmod +x hello.sh
./hello.sh
```

`/usr/bin/env bash` finds `bash` via your PATH.

---

Safer Defaults for Scripts
==========================
Use defensive options to catch errors early.

```bash
#!/usr/bin/env bash
set -Eeu -o pipefail
IFS=$'
	'
```

- `-e` → exit on error  
- `-u` → treat unset variables as errors  
- `-o pipefail` → fail a pipeline if any command fails  
- `IFS` set to safe defaults for word-splitting

---

Variables and Expansion
=======================
Assign and use variables:

```bash
name="Alice"
echo "Hello, $name"
```

Braced expansion avoids ambiguity:

```bash
echo "File: ${name}.txt"
```

Length of a variable:

```bash
echo "Name length: ${#name}"
```

Default values and replacement:

```bash
echo "${user:-anonymous}"       # default if unset/empty
echo "${path//:/ }"             # replace all ':' with space
```

Command substitution:

```bash
today="$(date +%F)"
echo "Today is $today"
```

---

Quoting Rules
=============
Single quotes **prevent** expansion; double quotes **allow** it.

```bash
echo '$HOME literally'
echo "HOME is $HOME"
```

Use quotes to keep whitespace intact and avoid globbing surprises.

---

Arithmetic
==========
Use `(( ))` for integer arithmetic.

```bash
a=5; b=7
(( sum = a + b ))
echo "$sum"
```

Exit status of arithmetic context:

```bash
if (( sum > 10 )); then echo "big"; fi
```

---

If / Elif / Else
================
```bash
read -r score
if (( score >= 90 )); then
  echo "A"
elif (( score >= 80 )); then
  echo "B"
else
  echo "Keep going"
fi
```

Test files/strings with `[[ ]]`:

```bash
file="report.txt"
if [[ -f "$file" && -s "$file" ]]; then
  echo "File exists and is non-empty"
fi
```

---

Case Statements
===============
```bash
read -r ans
case "$ans" in
  yes|y|Y) echo "proceed" ;;
  no|n|N)  echo "abort" ;;
  *)       echo "unknown" ;;
esac
```

Great for parsing modes and flags.

---

Loops — for / while / until
===========================
```bash
for i in 1 2 3; do echo "$i"; done
```

Read a file line-by-line safely:

```bash
while IFS= read -r line; do
  printf '%s
' "$line"
done < input.txt
```

Repeat until condition becomes true:

```bash
count=0
until (( count >= 3 )); do
  echo "$count"
  ((count++))
done
```

---

Functions, Scope, and Exit Codes
================================
Define functions and return statuses.

```bash
greet() { printf 'Hi, %s
' "$1"; }

greet "Alice"
```

Check exit codes via `$?` or with `||` and `&&`:

```bash
cp source.txt dest.txt && echo "ok" || echo "copy failed"
```

Local variables:

```bash
sum() { local a="$1" b="$2"; echo $((a+b)); }
```

---

Positional Parameters and `$@`
==============================
```bash
# script.sh
echo "Script: $0"
echo "Arg count: $#"
for arg in "$@"; do
  echo "-> $arg"
done
```

Quote `"$@"` to preserve args with spaces.

---

Reading Input — `read` and `getopts`
====================================
Read a line from stdin:

```bash
read -r name
echo "Hello, $name"
```

Parse flags with `getopts`:

```bash
#!/usr/bin/env bash
while getopts ":f:n:" opt; do
  case "$opt" in
    f) file="$OPTARG" ;;
    n) name="$OPTARG" ;;
    *) echo "Usage: $0 -f FILE -n NAME" >&2; exit 2 ;;
  esac
done
echo "file=$file name=$name"
```

---

Arrays and Associative Arrays
=============================
Indexed arrays:

```bash
nums=(10 20 30)
echo "${nums[1]}"
echo "${#nums[@]}"      # length
echo "${nums[@]}"       # iterate values
```

Associative arrays (Bash 4+):

```bash
declare -A user=( [name]="Alice" [role]="admin" )
echo "${user[name]}"
for k in "${!user[@]}"; do echo "$k=${user[$k]}"; done
```

---

`printf` — Safer Output
=======================
Prefer `printf` over `echo` for predictable formatting.

```bash
printf 'User: %s  Score: %03d
' "Alice" 7
```

---

Traps and Cleanup
=================
Run code on exit or on specific signals.

```bash
tmp="$(mktemp -d)"
cleanup(){ rm -rf "$tmp"; }
trap cleanup EXIT INT TERM

echo "Working in $tmp"
sleep 1
```

This ensures resources are cleaned up even if interrupted.

---

Here-Docs and Process Substitution
==================================
Here-doc to create files inline:

```bash
cat <<'EOF' > script.sh
#!/usr/bin/env bash
echo "inline"
EOF
```

Process substitution to compare streams without temp files:

```bash
diff <(sort a.txt) <(sort b.txt)
```

---

Subshells vs Current Shell
==========================
Subshell inherits environment but not variable changes back to parent.

```bash
pwd; (cd /tmp; pwd); pwd
```

Use `{ }` for grouping without subshell:

```bash
{ echo one; echo two; } > out.txt
```

---

Error Handling Patterns
=======================
Immediate exit on failure (already enabled via `set -e`).  
For guarded steps, use `||` with messages:

```bash
mkdir -p /data || { echo "cannot create /data" >&2; exit 1; }
```

Time a block:

```bash
start=$(date +%s); sleep 1; end=$(date +%s); echo "took $((end-start))s"
```

---

Reusable Script Template
========================
```bash
#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'
	'

usage(){ echo "Usage: $0 -i INPUT -o OUTPUT"; }

input="" output=""
while getopts ":i:o:" opt; do
  case "$opt" in
    i) input="$OPTARG" ;;
    o) output="$OPTARG" ;;
    *) usage; exit 2 ;;
  esac
done

[[ -f "$input" && -n "$output" ]] || { usage; exit 2; }

tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
cp "$input" "$tmp"
printf 'Processed %s -> %s
' "$input" "$output"
mv "$tmp" "$output"
```

---

Testing and Formatting
======================
Lint scripts with **shellcheck**:

```bash
shellcheck script.sh
```

Auto-format with **shfmt**:

```bash
shfmt -w script.sh
```

Install via your package manager or from upstream releases.

---


<!-- end_slide -->
<!-- font_size: 5 -->
<!-- alignment: center -->
<!-- jump_to_middle -->

# Thanks!

<!-- font_size: 1 -->

#### By ElnurBDa

