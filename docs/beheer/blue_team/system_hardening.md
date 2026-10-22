# 🔒 Systeem Hardening Baseline
**OS:** Debian Bookworm | **Cryptografie:** FinalCrypt One-Time Pad (OTP)

## 1. Bestandsrechten & Sleutelbeheer
- OTP-sleutelbestanden (`.otp`) vereisen strikte eigenaarsrechten: `chmod 600 *.otp`
- Sleutelmappen zijn volledig afgeschermd voor groepen en derden: `chmod 700 rekencentrum/beveiligde_sleutels`
- Validatie vindt plaats voor elke Git-synchronisatie.

## 2. Kernel & Netwerk Hardening
- Schakel ongebruikte services uit en beperk luisterende interfaces tot `127.0.0.1` waar mogelijk.
