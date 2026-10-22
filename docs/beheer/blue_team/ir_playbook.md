# 🚨 Incident Response (IR) Playbook
**Doelwit:** VORTEX OS (Debian Bookworm / Raspberry Pi)
**Status:** SOVEREIGN LOCALHOST

## 1. Isolatie & Triage
- Controleer actieve netwerkverbindingen op onbekende sockets: `sudo ss -tupn`
-bevries verdachte processen direct via: `sudo kill -STOP <PID>`
- Controleer op ongeautoriseerde wijzigingen in `/etc/passwd` en `/etc/shadow`.

## 2. Forensische Vastlegging
- Maak een snapshot van het werkgeheugen en actieve netwerkstatistieken.
- Verifieer de integriteit van de Tijdscapsule archieven via `python3 validate_repo.py`.
