# 🚨 Incident Response (IR) Playbook
**Doelwit:** VORTEX OS (Debian Bookworm / Raspberry Pi) | **Status:** SOVEREIGN LOCALHOST

## 1. Directe Triage & Netwerk Isolatie
- Inspecteer actieve TCP/UDP sockets op onbekende processen: `sudo ss -tupn`
- Bevries verdachte PID's voor forensische analyse: `sudo kill -STOP <PID>`
- Controleer op ongeautoriseerde aanpassingen in `/etc/passwd`, `/etc/shadow` en `~/.ssh/authorized_keys`.

## 2. Cryptografische & Rekencentrum Verificatie
- Voer direct een integriteitscheck uit op de monorepo en `.otp`-sleutels: `python3 validate_repo.py`
- Stel een bevroren snapshot veilig in de Tijdscapsule: `./tijdscapsule_backup.sh`
