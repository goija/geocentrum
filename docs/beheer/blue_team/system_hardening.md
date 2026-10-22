# 🔒 Systeem Hardening & FinalCrypt OTP
**OS:** Debian Bookworm | **Encryptie:** FinalCrypt One-Time Pad (OTP)

## 1. One-Time Pad (OTP) Sleutelbeheer
- Sleutelbestanden (`.otp`) zijn even groot als de bronbestanden en wiskundig onkraakbaar bij eenmalig gebruik.
- Pas altijd strikte bestandsrechten toe: `chmod 600 rekencentrum/beveiligde_sleutels/*.otp`
- Scherm de sleutelmap volledig af: `chmod 700 rekencentrum/beveiligde_sleutels`

## 2. Python PEP 668 Isolatie
- Alle externe netwerkbibliotheken (`aiortc`) draaien strikt geïsoleerd binnen `./venv` om het Debian-basissysteem schoon te houden.
