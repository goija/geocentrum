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
