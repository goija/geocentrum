# 🔒 Systeem Hardening & FinalCrypt OTP
**OS:** Debian Bookworm | **At-Rest Beveiliging:** FinalCrypt One-Time Pad (OTP)

## 1. Strikte One-Time Pad (OTP) Regels
- Elke `.otp` sleutel is wiskundig uniek, exact zo groot als de payload, en wordt eenmalig gebruikt.
- Sleutelrechten afdwingen: `chmod 600 rekencentrum/beveiligde_sleutels/*.otp`
- Sleutelmap isoleren: `chmod 700 rekencentrum/beveiligde_sleutels`

## 2. PEP 668 Virtuele Omgeving Isolatie
- Python netwerkpakketten zoals `aiortc` draaien uitsluitend binnen `./venv` om de Debian systeembibliotheken onaangetast te laten.
