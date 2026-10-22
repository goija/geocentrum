# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Lokale Netwerk & Systeem Audits (VORTEX OS)
**Status:** SOVEREIGN LOCALHOST - AUTHORIZED TESTING ONLY

## 1. Netwerk Discovery & Poortscans
- **TCP SYN Scan:** `sudo nmap -sS -T4 -p- 127.0.0.1`
- **Service & Versie Detectie:** `nmap -sV -p 22,53,8000,8081,8082,8448 127.0.0.1`

## 2. Web & Header Auditing
- **HTTP Headers inspecteren:** `curl -I http://localhost:8082`
- **Log-ruis onderdrukking:** `/favicon.ico` requests worden met `204 No Content` of inline SVG afgevangen om valse positieven in SIEM/logs te voorkomen.

## 3. Privilege Escalation Checks
- **Zoek SUID binaries:** `find / -perm -4000 2>/dev/null`
