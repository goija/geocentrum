# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Geautoriseerde Lokale Audits (VORTEX OS)

## 1. Netwerk Recon & Poort verificatie
- **Snelle lokale SYN scan:** `sudo nmap -sS -T4 -p- 127.0.0.1`
- **Service fingerprinting op VORTEX poorten:** `nmap -sV -p 53,8000,8081,8082,8448 127.0.0.1`

## 2. Web & P2P Audit
- **HTTP Header inspectie:** `curl -I http://localhost:8082/beheercentrum/index.html`
- **Controleer SUID binaries:** `find / -perm -4000 2>/dev/null`
- **Zoek onbeveiligde sleutels:** `python3 validate_repo.py`
