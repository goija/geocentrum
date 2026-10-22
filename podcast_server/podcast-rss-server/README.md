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
