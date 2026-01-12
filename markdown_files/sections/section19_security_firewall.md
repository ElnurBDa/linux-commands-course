---
title: "Security & Firewall (Plus)"
sub_title: "Linux Commands Course · Section 19"
author: "ElnurBDa"
theme:
  name: gruvbox-dark
options:
  implicit_slide_ends: true
  list_item_newlines: 1
---


Linux Security Layers
=====================
Linux security operates on multiple levels:

1. **Discretionary Access Control (DAC):** standard file permissions and ownership.  
2. **Capabilities:** fine-grained privileges for executables.  
3. **Mandatory Access Control (MAC):** enforced security frameworks (SELinux, AppArmor).  
4. **Network Firewall:** traffic filtering with ufw, firewalld, or nftables.

---

File Capabilities — `getcap`, `setcap`
======================================
Traditionally, privileged actions required root (UID 0).  
Capabilities allow splitting root powers into smaller permissions.

List file capabilities:

```bash
sudo getcap /bin/ping
```

Output example:

```
/bin/ping = cap_net_raw+ep
```

This means `ping` can use raw network sockets without being setuid root.

Assign a capability:

```bash
sudo setcap cap_net_bind_service=+ep /usr/bin/nginx
```

Remove it:

```bash
sudo setcap -r /usr/bin/nginx
```

View all files with capabilities:

```bash
sudo getcap -r / 2>/dev/null
```

---

Mandatory Access Control (MAC)
==============================
Beyond standard ownership and permissions, Linux can enforce additional security through **SELinux** or **AppArmor**.

---

SELinux (Security-Enhanced Linux)
=================================
Developed by the NSA, SELinux enforces strict policy rules for processes and files.

Check mode:

```bash
getenforce
```

Possible modes:
- `Enforcing` — policy actively blocks violations  
- `Permissive` — logs violations but allows actions  
- `Disabled` — inactive

Temporarily change mode (root only):

```bash
sudo setenforce 0   # switch to Permissive
sudo setenforce 1   # back to Enforcing
```

View logs:

```bash
sudo cat /var/log/audit/audit.log | grep denied
```

Permanent configuration is in `/etc/selinux/config`.

---

AppArmor (Ubuntu and Debian)
============================
AppArmor provides per-application confinement via security profiles.

Check AppArmor status:

```bash
sudo aa-status
```

Output example:

```
apparmor module is loaded.
26 profiles are loaded.
22 profiles are in enforce mode.
```

List profiles and modes:

```bash
sudo aa-status | grep enforce
```

Enable or disable specific profiles:

```bash
sudo aa-enforce /etc/apparmor.d/usr.bin.firefox
sudo aa-disable /etc/apparmor.d/usr.bin.firefox
```

AppArmor is easier to manage than SELinux but provides similar isolation.

---

Host Firewalls — Overview
=========================
Linux firewalls filter traffic using the **netfilter** framework.  
There are several user-friendly frontends built on top of it.

---

UFW (Uncomplicated Firewall)
============================
Simplified interface (Ubuntu and derivatives).

Check status:

```bash
sudo ufw status
```

Enable the firewall:

```bash
sudo ufw enable
```

Allow or deny rules:

```bash
sudo ufw allow 22/tcp
sudo ufw deny 23/tcp
```

Delete a rule:

```bash
sudo ufw delete allow 22/tcp
```

View detailed numbered list:

```bash
sudo ufw status numbered
```

Disable firewall:

```bash
sudo ufw disable
```

Reset to default:

```bash
sudo ufw reset
```

---

firewalld and `firewall-cmd`
============================
Used by RHEL, Fedora, and openSUSE.

Start and enable service:

```bash
sudo systemctl enable --now firewalld
```

Check active zones:

```bash
sudo firewall-cmd --get-active-zones
```

Allow a service in the default zone:

```bash
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
```

Add a custom port:

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

List all active rules:

```bash
sudo firewall-cmd --list-all
```

---

nftables and iptables (Conceptual Overview)
===========================================
`nftables` is the **modern packet filter** replacing `iptables`.

- `iptables` — legacy interface (still widely used)  
- `nftables` — unified replacement for IPv4/IPv6

Check active rules:

```bash
sudo nft list ruleset
```

Example nftables rule snippet:

```
table inet filter {
  chain input {
    type filter hook input priority 0;
    policy drop;
    iif "lo" accept
    ct state established,related accept
    tcp dport {22,80,443} accept
  }
}
```

`iptables` equivalent (legacy):

```bash
sudo iptables -L -n -v
```

---

When to Use Which
=================
| Tool | Recommended for | Notes |
|------|------------------|-------|
| **ufw** | Simple desktop/server setups | Easy syntax |
| **firewalld** | Enterprise systems (RHEL/Fedora) | Zone-based rules |
| **nftables** | Advanced configurations | Modern standard |
| **iptables** | Legacy compatibility | Being replaced |

---


<!-- end_slide -->
<!-- font_size: 5 -->
<!-- alignment: center -->
<!-- jump_to_middle -->

# Thanks!

<!-- font_size: 1 -->

#### By ElnurBDa


