# 🚨 Incident Response (IR) Playbook
**Systeem:** VORTEX OS (Debian Bookworm) | **Poorten:** Web `8080`, API `8000`, Podcast `8081`, Matrix `8448`

## 1. Directe Triage & Procescontrole
- Controleer actieve luisterende poorten in de VORTEX-stack: `sudo ss -tupnl | grep -E '8000|8080|8081|8448'`
- Bevries een verdacht proces zonder geheugenverlies: `sudo kill -STOP <PID>`
- Controleer integriteit van systeemgebruikers: `grep -E ':0:' /etc/passwd`

## 2. Cryptografische & Archief Isolatie
- Valideer direct de monorepo en FinalCrypt `.otp` permissies: `python3 validate_repo.py`
- Genereer een nood-snapshot in de Tijdscapsule: `./tijdscapsule_backup.sh`
