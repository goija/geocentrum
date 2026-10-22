#!/bin/bash

TARGET_DIR="$HOME/VORTEX_OS/beheercentrum"
FILE_PATH="$TARGET_DIR/actuele_structuur.md"

echo "🔄 Genereren van actuele mappenstructuur in Markdown..."

cat << 'EOF_INNER' > "$FILE_PATH"
# 📂 VORTEX OS - Actuele Mappenstructuur
*Laatst bijgewerkt: $(date '+%Y-%m-%d %H:%M:%S')*

Dit document beschrijft de officiële mappenstructuur binnen `~/VORTEX_OS` voor het soevereine lokale systeem.

## Hoofdonderdelen

1. **`beheercentrum/`**
   - Centrale dashboards en beheerinterfaces.
   - `index.html` — Het hoofd-beheerdashboard (mobile-ready, native UI).
   - `actuele_structuur.md` — Dit overzicht van de repository-architectuur.

2. **`docs/beheer/blue_team/`** (Blue Team Field Manual - BTFM)
   - `0_preparation/` — Voorbereiding en key documents.
   - `1_identify/` — Netwerk discovery, vulnerability scanning, host monitoring.
   - `2_protect/` — Hardening, firewall configuratie, service-isolatie.

3. **`rekencentrum/`**
   - `tijdscapsule/` — Archiefopslag en eerdere werkende staten.
   - Lokale dataopslag en versleutelde back-ups via FinalCrypt (OTP).

4. **Kernapplicaties & Scripts (Root)**
   - API-services, Python/Rust backends en opstartscripts.

---
*Automatisch gegenereerd via VORTEX_OS beheer-script.*
EOF_INNER

echo "✅ Markdown-bestand succesvol bijgewerkt op: $FILE_PATH"
