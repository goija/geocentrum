# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Geautoriseerde Lokale Security Audits op VORTEX OS (`127.0.0.1`)

## 1. Poort- & Service Verificatie
- **Controleer de actieve VORTEX poorten:** `nmap -sV -p 53,8000,8080,8081,8448 127.0.0.1`
- **Inspecteer API-status endpoint:** `curl -i http://localhost:8000/api/status`
- **Inspecteer Podcast RSS feed:** `curl -I http://localhost:8081`

## 2. Lokale Privilege Escalation & Permissie Audit
- **Zoek naar onbedoelde SUID binaries:** `find / -perm -4000 2>/dev/null`
- **Audit op te ruime OTP-sleutelrechten:** `python3 validate_repo.py`
