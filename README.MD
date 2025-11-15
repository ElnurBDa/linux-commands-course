# Linux Commands Course

This repository contains a **complete presentation-based course** covering essential and advanced Linux command-line skills.  
Each section (`sectionX_*.md`) is designed for use with [Presenterm](https://github.com/mfontanini/presenterm), a terminal presentation tool.

## 📘 Course Structure

- **Core Concepts:** Shell, Navigation, Files, Permissions, Processes, Networking, Packages  
- **System Administration:** Services, Boot, Disks, Scheduling, Users & Security  
- **Plus Topics:** Bash Scripting, Environment Customization, Troubleshooting, Firewalls  
- **Optional:** Modern CLI tools and workflow enhancers

## 🧩 Highlights

- 20 structured modules (0–20) with examples and practice tasks  
- Clean syntax-highlighted Markdown for Presenterm  
- Mix of practical and conceptual Linux topics  
- Suitable for both teaching and self-paced learning

## 🚀 How to Run

Install [Presenterm](https://github.com/mfontanini/presenterm), then run:

```bash
cd markdown_files/
presenterm section0_shell_help_core.md
```

## 🛠 Requirements
- Linux environment
- Basic terminal knowledge

## PDF Convert
```bash
for f in *.md; do presenterm -e "$f"; done
```

## PDF to cut
```bash
pdftk practice.pdf cat 1 2 3 4 5 6 7 8 9 11 13 15 47 output selected_slides.pdf
```

## PDF to unite
```bash
pdfunite section*.pdf combined_manual.pdf
```
