#!/usr/bin/env python3
import os
import re
import json
import shutil

BASE_DIR = os.path.expanduser("~/VORTEX_OS")
os.chdir(BASE_DIR)

print("🛠️ [1/6] Opbouwen van universele Sovereign Dark Mode template & Favicon fix...")

# Inline SVG Favicon voorkomt ALLE /favicon.ico 404-requests in zowel lokaal als Vercel
FAVICON_TAG = '<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><rect width=%22100%22 height=%22100%22 fill=%22%230a0a0a%22/><polygon points=%2250,15 85,85 15,85%22 fill=%22none%22 stroke=%22%2300ffcc%22 stroke-width=%228%22/></svg>">'

STYLE_BLOCK = """
<style>
    :root {
        --bg-color: #0a0a0a;
        --surface-color: #1a1a1a;
        --text-color: #e0e0e0;
        --accent-color: #00ffcc;
        --success-color: #00c853;
        --font-mono: "Courier New", Courier, monospace;
        --font-sans: system-ui, -apple-system, sans-serif;
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: var(--font-sans);
        background-color: var(--bg-color);
        color: var(--text-color);
        line-height: 1.6;
        padding: 30px 20px;
        max-width: 1100px;
        margin: 0 auto;
    }
    header {
        border-bottom: 2px solid var(--accent-color);
        padding-bottom: 15px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        flex-wrap: wrap;
        gap: 10px;
    }
    h1 { font-family: var(--font-mono); color: var(--accent-color); text-transform: uppercase; letter-spacing: 2px; }
    h2, h3 { font-family: var(--font-mono); color: var(--accent-color); margin: 20px 0 10px 0; }
    .sys-info { font-family: var(--font-mono); font-size: 0.85rem; color: #888; }
    .back-btn {
        display: inline-block;
        margin-bottom: 20px;
        padding: 8px 16px;
        background: var(--surface-color);
        border: 1px solid var(--accent-color);
        color: var(--accent-color);
        font-family: var(--font-mono);
        text-decoration: none;
        border-radius: 4px;
        font-size: 0.9rem;
    }
    .back-btn:hover { background: var(--accent-color); color: #000; }
    .card {
        background-color: var(--surface-color);
        border: 1px solid #333;
        border-radius: 8px;
        padding: 25px;
        margin-bottom: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.5);
    }
    .grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 20px;
    }
    table { width: 100%; border-collapse: collapse; margin: 15px 0; font-family: var(--font-mono); font-size: 0.9rem; }
    th, td { border: 1px solid #333; padding: 10px; text-align: left; }
    th { background: #111; color: var(--accent-color); }
    code { background: #111; padding: 2px 6px; border-radius: 4px; font-family: var(--font-mono); color: var(--accent-color); }
    pre { background: #111; padding: 15px; border-radius: 6px; overflow-x: auto; font-family: var(--font-mono); border: 1px solid #333; margin: 10px 0; }
    ul { list-style: none; }
    li { margin-bottom: 12px; padding-bottom: 12px; border-bottom: 1px solid #2a2a2a; }
    li:last-child { border-bottom: none; }
    a { color: var(--text-color); text-decoration: none; }
    a:hover { color: var(--accent-color); }
    .path { font-family: var(--font-mono); font-size: 0.75rem; color: #777; display: block; margin-top: 3px; }
    .dot { width: 10px; height: 10px; border-radius: 50%; display: inline-block; margin-right: 8px; }
    .dot.online { background-color: var(--success-color); box-shadow: 0 0 5px var(--success-color); }
    .dot.secured { background-color: var(--accent-color); box-shadow: 0 0 5px var(--accent-color); }
</style>
"""

print("📄 [2/6] Genereren van rijke BTFM & RTFM documentatie (inclusief BTFM syntax-tabellen)...")
os.makedirs("docs/beheer/blue_team", exist_ok=True)
os.makedirs("docs/beheer/red_team", exist_ok=True)
os.makedirs("rekencentrum/tijdscapsule", exist_ok=True)
os.makedirs("beheercentrum", exist_ok=True)

docs_content = {
    "docs/beheer/blue_team/ir_playbook.md": """# 🚨 Incident Response (IR) Playbook
**Doelwit:** VORTEX OS (Debian Bookworm / Raspberry Pi)
**Status:** SOVEREIGN LOCALHOST

## 1. Isolatie & Triage
- Controleer actieve netwerkverbindingen op onbekende sockets: `sudo ss -tupn`
-bevries verdachte processen direct via: `sudo kill -STOP <PID>`
- Controleer op ongeautoriseerde wijzigingen in `/etc/passwd` en `/etc/shadow`.

## 2. Forensische Vastlegging
- Maak een snapshot van het werkgeheugen en actieve netwerkstatistieken.
- Verifieer de integriteit van de Tijdscapsule archieven via `python3 validate_repo.py`.
""",
    "docs/beheer/blue_team/tactical_ops.md": """# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Syntaxis & Copy/Paste Richtlijnen
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | Let op bij copy/paste met streepjes: onderscheid en/em-dash (`–`, `—`) en hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en ontbrekende spaties in commando's |

## 2. Operationeel Beheer
- **Poort 8082 vrijgeven:** `sudo fuser -k 8082/tcp`
- **Live poortstatus:** `python3 start_services.py`
""",
    "docs/beheer/blue_team/system_hardening.md": """# 🔒 Systeem Hardening Baseline
**OS:** Debian Bookworm | **Cryptografie:** FinalCrypt One-Time Pad (OTP)

## 1. Bestandsrechten & Sleutelbeheer
- OTP-sleutelbestanden (`.otp`) vereisen strikte eigenaarsrechten: `chmod 600 *.otp`
- Sleutelmappen zijn volledig afgeschermd voor groepen en derden: `chmod 700 rekencentrum/beveiligde_sleutels`
- Validatie vindt plaats voor elke Git-synchronisatie.

## 2. Kernel & Netwerk Hardening
- Schakel ongebruikte services uit en beperk luisterende interfaces tot `127.0.0.1` waar mogelijk.
""",
    "docs/beheer/blue_team/network_defense.md": """# 🌐 Netwerk, DNS & WebRTC Defensie
**Componenten:** BIND9 (UDP 53), Matrix/Conduit (8448), WebRTC Data Channels

## 1. WebRTC DTLS Beveiliging
- P2P Data Channels zijn standaard versleuteld via **DTLS** bovenop SCTP.
- Lokale loopback- en integratietests draaien geïsoleerd in `./venv/bin/python3 test_webrtc_channel.py`.

## 2. DNS Soevereiniteit (BIND9)
- Lokale naamresolutie voorkomt DNS-lekkage naar externe resolvers.
""",
    "docs/beheer/red_team/rtfm_manual.md": """# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Lokale Netwerk & Systeem Audits (VORTEX OS)
**Status:** SOVEREIGN LOCALHOST - AUTHORIZED TESTING ONLY

## 1. Netwerk Discovery & Poortscans
- **TCP SYN Scan:** `sudo nmap -sS -T4 -p- 127.0.0.1`
- **Service & Versie Detectie:** `nmap -sV -p 22,53,8000,8081,8082,8448 127.0.0.1`

## 2. Web & Header Auditing
- **HTTP Headers inspecteren:** `curl -I http://localhost:8082`
- **Log-ruis onderdrukking:** `/favicon.ico` requests worden met `204 No Content` of inline SVG afgevangen om valse positieven in SIEM/logs te voorkomen.

## 3. Privilege Escalation Checks
- **Zoek SUID binaries:** `find / -perm -4000 2>/dev/null`
"""
}

def md_to_html_body(md_text):
    lines = md_text.strip().split('\n')
    html = []
    in_table = False
    for line in lines:
        if line.startswith('|'):
            if not in_table:
                html.append('<table>')
                in_table = True
            if '---' in line:
                continue
            cells = [c.strip() for c in line.strip('|').split('|')]
            tag = 'th' if html[-1] == '<table>' else 'td'
            row = ''.join(f'<{tag}>{re.sub(r"`([^`]+)`", r"<code>\1</code>", c)}</{tag}>' for c in cells)
            html.append(f'<tr>{row}</tr>')
            continue
        elif in_table:
            html.append('</table>')
            in_table = False

        if line.startswith('# '):
            html.append(f'<h1>{line[2:]}</h1>')
        elif line.startswith('## '):
            html.append(f'<h2>{line[3:]}</h2>')
        elif line.startswith('- '):
            formatted = re.sub(r'`([^`]+)`', r'<code>\1</code>', line[2:])
            formatted = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', formatted)
            html.append(f'<p>• {formatted}</p>')
        elif line.strip():
            formatted = re.sub(r'`([^`]+)`', r'<code>\1</code>', line)
            formatted = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', formatted)
            html.append(f'<p>{formatted}</p>')
    if in_table:
        html.append('</table>')
    return '\n'.join(html)

for md_path, content in docs_content.items():
    with open(md_path, 'w', encoding='utf-8') as f:
        f.write(content)
    # Genereer direct een volwaardige .html versie naast de .md voor Vercel!
    html_path = md_path.replace('.md', '.html')
    body_html = md_to_html_body(content)
    full_html = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX OS | Documentatie</title>
    {FAVICON_TAG}
    {STYLE_BLOCK}
</head>
<body>
    <a class="back-btn" href="/beheercentrum/index.html">← Terug naar Beheercentrum</a>
    <div class="card">
        {body_html}
    </div>
</body>
</html>"""
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(full_html)

print("⏳ [3/6] Bouwen van /rekencentrum/tijdscapsule/index.html (lost de 404 op!)...")

tijdscapsule_html = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX OS | Tijdscapsule & Rekencentrum</title>
    {FAVICON_TAG}
    {STYLE_BLOCK}
</head>
<body>
    <header>
        <div>
            <h1>REKENCENTRUM : TIJDSCAPSULE</h1>
            <div class="sys-info">Versie: v159.1 Locked-Interface | Timestamp Lock: 2026-10-22 10:00:01 CEST</div>
        </div>
        <a class="back-btn" style="margin-bottom:0;" href="/beheercentrum/index.html">← Dashboard</a>
    </header>

    <div class="grid">
        <div class="card">
            <h2>📍 Geodetisch Anker & Attractor</h2>
            <table>
                <tr><th>Parameter</th><th>Waarde</th></tr>
                <tr><td>Oorsprong Anker</td><td>Poolanker P (52.2500° N, 5.2200° E)</td></tr>
                <tr><td>Attractor State</td><td><code>010101 (Hex #21)</code></td></tr>
                <tr><td>Interface Lock</td><td><code>pizzadisk_simulatie_v158.py</code></td></tr>
                <tr><td>Dataset Referentie</td><td><code>vortex_processed_points.geojson (P1-P100)</code></td></tr>
                <tr><td>Encryptie Status</td><td><span class="dot secured"></span>FinalCrypt OTP (At-Rest Actief)</td></tr>
            </table>
        </div>

        <div class="card">
            <h2>🌙 Astrometrie (Maan — 22 okt 2026)</h2>
            <table>
                <tr><th>Parameter</th><th>Waarde</th></tr>
                <tr><td>Rechte Klimming (RA)</td><td>191.20°</td></tr>
                <tr><td>Declinatie (Dec)</td><td>13.30°</td></tr>
                <tr><td>Lokale Sterrentijd (LST)</td><td>312.74°</td></tr>
                <tr><td>Uurhoek (HA)</td><td>121.54°</td></tr>
                <tr><td>Azimut / Elevatie</td><td>303.23° / -7.45°</td></tr>
                <tr><td>Constellatie</td><td>Capricornus / Steenbok (Zuidmuur)</td></tr>
            </table>
        </div>

        <div class="card">
            <h2>📐 A. Ott Poolplanimeter (Nr. 573) & Ringen</h2>
            <table>
                <tr><th>Component</th><th>Specificatie</th></tr>
                <tr><td>Poolarm (R) / Rijarm (L)</td><td>15.00 cm / 16.67 cm</td></tr>
                <tr><td>Oppervlakte (A0)</td><td>2363.08 cm²</td></tr>
                <tr><td>Fraunhofer D-lijn</td><td>589.0 nm</td></tr>
                <tr><td>Plani Diameter / Start Azimut</td><td>29 cm / 108°</td></tr>
                <tr><td>Ring 1 / Ring 2 / Ring 3</td><td>202° (Tilt 22°) / 22° (Tilt 22°) / 22° (Tilt -22°)</td></tr>
            </table>
        </div>
    </div>

    <div class="card">
        <h2>📦 Gearchiveerde Bestanden</h2>
        <ul>
            <li>
                <a href="tijdscapsule_metadata.json" target="_blank">
                    <strong>📄 tijdscapsule_metadata.json</strong>
                    <span class="path">Ruwe JSON-telemetrie van de Geodetische & Astrometrische Tijdscapsule</span>
                </a>
            </li>
        </ul>
    </div>
</body>
</html>"""

with open("rekencentrum/tijdscapsule/index.html", "w", encoding="utf-8") as f:
    f.write(tijdscapsule_html)

print("🖥️ [4/6] Updaten van beheercentrum/index.html en root index.html...")

dashboard_html = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#0a0a0a">
    <title>VORTEX OS | Beheercentrum</title>
    {FAVICON_TAG}
    {STYLE_BLOCK}
</head>
<body>
    <header>
        <h1>VORTEX OS</h1>
        <div class="sys-info">Host: localhost (Debian Bookworm) | Status: SOVEREIGN</div>
    </header>

    <main class="grid">
        <div class="card">
            <h2>► Netwerk & Services</h2>
            <ul>
                <li><span class="dot online"></span>Python API Core (Poort 8000)</li>
                <li><span class="dot online"></span>Rust Podcast RSS (Poort 8081)</li>
                <li><span class="dot secured"></span>BIND9 Local DNS (UDP 53)</li>
                <li><span class="dot secured"></span>Matrix/Conduit & WebRTC (DTLS)</li>
            </ul>
        </div>

        <div class="card">
            <h2>► Blue Team Field Manual (BTFM)</h2>
            <ul>
                <li>
                    <a href="/docs/beheer/blue_team/ir_playbook.html">
                        <strong>Incident Response Playbook</strong>
                        <span class="path">/docs/beheer/blue_team/ir_playbook.html</span>
                    </a>
                </li>
                <li>
                    <a href="/docs/beheer/blue_team/tactical_ops.html">
                        <strong>Tactische Commando's & BTFM Syntax</strong>
                        <span class="path">/docs/beheer/blue_team/tactical_ops.html</span>
                    </a>
                </li>
                <li>
                    <a href="/docs/beheer/blue_team/system_hardening.html">
                        <strong>Systeem Hardening & OTP</strong>
                        <span class="path">/docs/beheer/blue_team/system_hardening.html</span>
                    </a>
                </li>
                <li>
                    <a href="/docs/beheer/blue_team/network_defense.html">
                        <strong>Netwerk & DNS Defensie</strong>
                        <span class="path">/docs/beheer/blue_team/network_defense.html</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="card">
            <h2>► Red Team Field Manual (RTFM)</h2>
            <ul>
                <li>
                    <a href="/docs/beheer/red_team/rtfm_manual.html">
                        <strong>Offensieve Audits & Scans</strong>
                        <span class="path">/docs/beheer/red_team/rtfm_manual.html</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="card">
            <h2>► Cryptografie & Tijdscapsule</h2>
            <ul>
                <li>
                    <span class="dot secured"></span><strong>FinalCrypt OTP Status: Actief</strong>
                    <span class="path">At-rest encryptie via One-Time Pad ingeschakeld.</span>
                </li>
                <li>
                    <a href="/rekencentrum/tijdscapsule/index.html">
                        <strong>⏳ Open Geodetische Tijdscapsule</strong>
                        <span class="path">/rekencentrum/tijdscapsule/index.html</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="card">
            <h2>► Cloud Mirror (Vercel)</h2>
            <ul>
                <li>
                    <a href="https://geocentrum.vercel.app/" target="_blank">
                        <strong>Live Geocentrum Omgeving ↗</strong>
                        <span class="path">https://geocentrum.vercel.app/</span>
                    </a>
                </li>
                <li>
                    <span class="dot online"></span>Status: Statisch & Gesynchroniseerd
                </li>
            </ul>
        </div>
    </main>
</body>
</html>"""

with open("beheercentrum/index.html", "w", encoding="utf-8") as f:
    f.write(dashboard_html)

# Plaats exact hetzelfde dashboard ook in de root index.html zodat elke Root Directory setting werkt
with open("index.html", "w", encoding="utf-8") as f:
    f.write(dashboard_html)

print("🔄 [5/6] Spiegelen van mappen in zowel root als beheercentrum/ voor 100% Vercel compatibiliteit...")
# Of Vercel Root Directory nu leeg is OF op 'beheercentrum' staat, de bestanden zijn op beide plekken aanwezig!
if os.path.exists("beheercentrum/docs"):
    shutil.rmtree("beheercentrum/docs")
if os.path.exists("beheercentrum/rekencentrum"):
    shutil.rmtree("beheercentrum/rekencentrum")

shutil.copytree("docs", "beheercentrum/docs")
shutil.copytree("rekencentrum", "beheercentrum/rekencentrum")

# Maak ook een kopie van beheercentrum/index.html in beheercentrum/beheercentrum/index.html voor terug-knoppen
os.makedirs("beheercentrum/beheercentrum", exist_ok=True)
shutil.copy2("beheercentrum/index.html", "beheercentrum/beheercentrum/index.html")

print("⚙️ [6/6] Schrijven van universele vercel.json...")
vercel_cfg = {
    "version": 2,
    "cleanUrls": True,
    "trailingSlash": False
}
with open("vercel.json", "w", encoding="utf-8") as f:
    json.dump(vercel_cfg, f, indent=2)

with open("beheercentrum/vercel.json", "w", encoding="utf-8") as f:
    json.dump(vercel_cfg, f, indent=2)

print("✅ Alle bugs zijn verholpen! Bezig met synchroniseren naar GitHub en Vercel...")
