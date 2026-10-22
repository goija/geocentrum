#!/bin/bash
set -e

echo "📝 VORTEX - Genereren van documentatie..."

# ==========================================
# DEEL 1: README.md (Voor GitHub)
# ==========================================
cat << 'README_EOF' > README.md
# 🎙️ VORTEX Sovereign Podcast RSS Server

Een lichtgewicht, snelle en soevereine RSS-podcastserver, geschreven in **Rust** (Axum framework). Deze server scant een lokale map op `.mp3`-bestanden en genereert dynamisch een valide RSS 2.0-feed voor podcast-clients.

## 🚀 Kenmerken
- **Bare-Metal & Snel:** Gebouwd in Rust voor maximale performance.
- **Automatische RSS:** Directe conversie van mp3-bestanden naar XML (`/rss.xml`).
- **Soeverein:** Geen cloud-afhankelijkheid; ontworpen voor lokale Tiny Servers of Debian/Raspberry Pi via systemd.

## 🛠️ Starten
\`\`\`bash
cargo run --release
\`\`\`
De feed is bereikbaar op \`http://localhost:8080/rss.xml\`.
README_EOF
echo "✅ README.md aangemaakt."

# ==========================================
# DEEL 2: NOTION EXPORT (Voor interne Wiki)
# ==========================================
cat << 'NOTION_EOF' > docs/notion_documentatie.md
# 🧠 VORTEX RSS Server - Systeem Architectuur

Dit document beschrijft de architectuur en de operationele inrichting van de VORTEX Podcast Server.

## 1. Doelstelling
Het bieden van een soevereine, lokaal gehoste podcast-oplossing zonder afhankelijkheid van externe partijen zoals Vercel of cloud-providers.

## 2. Technische Stack
- **Taal:** Rust (edition 2021)
- **Web Framework:** Axum 0.7
- **Runtime:** Tokio (Asynchroon)
- **Hosting:** Systemd service op Debian/Ubuntu (Bare-metal)

## 3. Mapstructuur
- \`src/main.rs\`: De core server logica en XML-generatie.
- \`podcasts/\`: De fysieke map waar \`.mp3\` bestanden worden uitgelezen.
- \`docs/\`: Interne documentatie.

## 4. Systemd Configuratie
De server draait als een achtergrondproces. Handige commando's voor beheer:
- **Status bekijken:** \`sudo systemctl status podcast-rss.service\`
- **Herstarten:** \`sudo systemctl restart podcast-rss.service\`
- **Logs inzien:** \`journalctl -u podcast-rss.service -f\`

## 5. Endpoints
| Endpoint | Functie |
| :--- | :--- |
| \`/rss.xml\` | Genereert de dynamische RSS 2.0 feed voor de podcast speler. |
| \`/podcasts/...\` | Levert de fysieke audiobestanden (static file server). |
NOTION_EOF
echo "✅ Notion documentatie (notion_documentatie.md) aangemaakt in de docs/ map."

echo "🎉 Documentatie succesvol gegenereerd!"
