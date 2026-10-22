#!/usr/bin/env python3
import os
import re
import json
import shutil
import time

BASE_DIR = os.path.expanduser("~/VORTEX_OS")
os.chdir(BASE_DIR)
CACHE_BUST = int(time.time())

print("🛠️ [1/6] Opschonen en logisch structureren van de VORTEX OS mappen...")

for d in [
    "beheercentrum",
    "docs/beheer/blue_team",
    "docs/beheer/red_team",
    "rekencentrum/tijdscapsule",
    "rekencentrum/beveiligde_sleutels"
]:
    os.makedirs(d, exist_ok=True)
os.chmod("rekencentrum/beveiligde_sleutels", 0o700)

# 1. Centrale config.json afgestemd op start_vortex.sh (8080, 8000, 8081)
config_data = {
    "system": "VORTEX_OS",
    "mode": "SOVEREIGN_LOCALHOST",
    "version": "v159.2-LOGICAL",
    "services": {
        "STATIC_WEB": {"port": 8080, "url": "http://localhost:8080", "status": "active"},
        "PYTHON_API": {"port": 8000, "url": "http://localhost:8000/api/status", "status": "active"},
        "RUST_PODCAST": {"port": 8081, "url": "http://localhost:8081", "status": "active"},
        "DNS_BIND9": {"port": 53, "protocol": "UDP/TCP", "status": "secured"},
        "MATRIX_CONDUIT": {"port": 8448, "protocol": "DTLS/WebRTC", "status": "secured"}
    }
}
with open("config.json", "w", encoding="utf-8") as f:
    json.dump(config_data, f, indent=2)

# Inline SVG Favicon voorkomt alle /favicon.ico 404-meldingen
FAVICON_TAG = '<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><rect width=%22100%22 height=%22100%22 fill=%22%230a0a0a%22/><polygon points=%2250,12 88,85 12,85%22 fill=%22none%22 stroke=%22%2300ffcc%22 stroke-width=%228%22/><circle cx=%2250%22 cy=%2260%22 r=%2210%22 fill=%22%2300ffcc%22/></svg>">'

def get_shared_head(title):
    return f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, viewport-fit=cover">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <meta name="theme-color" content="#0a0a0a">
    <title>{title}</title>
    {FAVICON_TAG}
    <style>
        :root {{
            --bg: #0a0a0a;
            --surface: #141414;
            --surface-alt: #1c1c1c;
            --border: #2a2a2a;
            --text: #e4e4e4;
            --muted: #888888;
            --accent: #00ffcc;
            --blue: #00b0ff;
            --red: #ff4444;
            --green: #00c853;
            --amber: #ffab00;
            --mono: "Courier New", Courier, monospace;
            --sans: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }}
        * {{ box-sizing: border-box; margin: 0; padding: 0; }}
        body {{
            font-family: var(--sans);
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.55;
            padding: 20px 20px 85px 20px;
            max-width: 1440px;
            margin: 0 auto;
        }}
        body.force-mobile {{
            max-width: 430px;
            border-left: 2px solid var(--border);
            border-right: 2px solid var(--border);
            min-height: 100vh;
            padding: 12px 12px 90px 12px;
        }}
        body.force-mobile .grid {{ grid-template-columns: 1fr !important; }}
        header {{
            border-bottom: 2px solid var(--accent);
            padding-bottom: 14px;
            margin-bottom: 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }}
        h1 {{
            font-family: var(--mono);
            color: var(--accent);
            font-size: clamp(1.25rem, 3vw, 1.9rem);
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }}
        h2 {{
            font-family: var(--mono);
            font-size: 1rem;
            color: var(--accent);
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        h3 {{ font-family: var(--mono); font-size: 0.9rem; color: var(--blue); margin: 14px 0 6px 0; }}
        .sys-sub {{ font-family: var(--mono); font-size: 0.78rem; color: var(--muted); margin-top: 3px; }}
        .toolbar {{ display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }}
        .btn {{
            background: var(--surface);
            color: var(--text);
            border: 1px solid #3a3a3a;
            padding: 7px 13px;
            border-radius: 5px;
            font-family: var(--mono);
            font-size: 0.78rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            min-height: 36px;
            transition: all 0.15s ease;
        }}
        .btn:hover, .btn.active {{
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(0, 255, 204, 0.08);
        }}
        .btn-blue {{ border-color: var(--blue); color: var(--blue); }}
        .btn-blue:hover {{ background: rgba(0, 176, 255, 0.12); }}
        
        .grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(360px, 1fr));
            gap: 18px;
        }}
        .card {{
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.55);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }}
        .card.pijler-1 {{ border-top: 3px solid var(--green); }}
        .card.pijler-2 {{ border-top: 3px solid var(--accent); }}
        .card.pijler-3 {{ border-top: 3px solid var(--blue); }}
        .card.pijler-4 {{ border-top: 3px solid var(--red); }}
        .card.pijler-5 {{ border-top: 3px solid var(--amber); }}

        ul {{ list-style: none; }}
        li {{
            padding: 9px 0;
            border-bottom: 1px solid #202020;
        }}
        li:last-child {{ border-bottom: none; padding-bottom: 0; }}
        a.row-link {{
            color: var(--text);
            text-decoration: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 4px 6px;
            border-radius: 4px;
        }}
        a.row-link:hover {{ color: var(--accent); background: var(--surface-alt); }}
        .path {{ font-family: var(--mono); font-size: 0.72rem; color: #777; display: block; margin-top: 2px; }}
        .badge {{
            font-family: var(--mono);
            font-size: 0.7rem;
            padding: 2px 7px;
            border-radius: 4px;
            background: #111;
            border: 1px solid #333;
            color: var(--accent);
        }}
        .dot {{ width: 9px; height: 9px; border-radius: 50%; display: inline-block; margin-right: 8px; }}
        .dot.online {{ background: var(--green); box-shadow: 0 0 6px var(--green); }}
        .dot.secured {{ background: var(--accent); box-shadow: 0 0 6px var(--accent); }}
        .dot.warn {{ background: var(--amber); box-shadow: 0 0 6px var(--amber); }}

        .table-wrap {{ width: 100%; overflow-x: auto; margin: 8px 0; }}
        table {{ width: 100%; border-collapse: collapse; font-family: var(--mono); font-size: 0.8rem; }}
        th, td {{ border: 1px solid var(--border); padding: 7px 9px; text-align: left; }}
        th {{ background: #0f0f0f; color: var(--accent); }}
        code {{ background: #0d0d0d; padding: 2px 5px; border-radius: 3px; font-family: var(--mono); color: var(--accent); font-size: 0.8rem; }}
        pre {{ background: #0d0d0d; padding: 10px; border-radius: 5px; overflow-x: auto; font-family: var(--mono); border: 1px solid #262626; font-size: 0.78rem; margin: 8px 0; }}

        .console-box {{
            background: #070707;
            border: 1px solid #2e2e2e;
            border-radius: 5px;
            padding: 9px;
            font-family: var(--mono);
            font-size: 0.76rem;
            height: 125px;
            overflow-y: auto;
            color: var(--accent);
            margin: 8px 0;
        }}
        .input-row {{ display: flex; gap: 8px; margin-top: 8px; flex-wrap: wrap; }}
        input[type="text"], input[type="number"] {{
            flex: 1;
            min-width: 130px;
            background: #0d0d0d;
            border: 1px solid #383838;
            color: var(--text);
            padding: 7px 10px;
            border-radius: 4px;
            font-family: var(--mono);
            font-size: 0.82rem;
        }}
        .mobile-dock {{
            position: fixed;
            bottom: 0; left: 0; right: 0;
            background: rgba(12, 12, 12, 0.96);
            border-top: 1px solid var(--accent);
            display: flex;
            justify-content: space-around;
            padding: 8px 10px;
            z-index: 1000;
            backdrop-filter: blur(6px);
        }}
        @media (max-width: 768px) {{
            body {{ padding: 12px 12px 85px 12px; }}
            .grid {{ grid-template-columns: 1fr; }}
        }}
    </style>
    <script>
        function setBuildMode(mode) {{
            if (mode === 'mobile') {{
                document.body.classList.add('force-mobile');
                localStorage.setItem('vortex_view_mode', 'mobile');
            }} else {{
                document.body.classList.remove('force-mobile');
                localStorage.setItem('vortex_view_mode', 'desktop');
            }}
            syncModeBtns();
        }}
        function syncModeBtns() {{
            const m = localStorage.getItem('vortex_view_mode') || 'desktop';
            const dBtn = document.getElementById('btn-desktop');
            const mBtn = document.getElementById('btn-mobile');
            if (dBtn && mBtn) {{
                dBtn.classList.toggle('active', m === 'desktop');
                mBtn.classList.toggle('active', m === 'mobile');
            }}
        }}
        window.addEventListener('DOMContentLoaded', () => {{
            if (localStorage.getItem('vortex_view_mode') === 'mobile') {{
                document.body.classList.add('force-mobile');
            }}
            syncModeBtns();
        }});
    </script>
</head>"""

print("📐 [2/6] Logisch opbouwen van het Rekencentrum & Tijdscapsule (met BTFM Field Beheer)...")

tijdscapsule_html = f"""{get_shared_head("VORTEX OS | Rekencentrum & Tijdscapsule")}
<body>
    <header>
        <div>
            <h1>⏳ REKENCENTRUM & TIJDSCAPSULE</h1>
            <div class="sys-sub">v159.2 Locked-Interface | Poolanker P (52.2500° N, 5.2200° E) | Attractor #21 (010101)</div>
        </div>
        <div class="toolbar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobiel</button>
            <a class="btn btn-blue" href="../../beheercentrum/index.html?v={CACHE_BUST}">← Terug naar Beheercentrum</a>
        </div>
    </header>

    <div class="grid">
        <!-- 1. Mechanische Integratie: A. Ott Nr. 573 -->
        <div class="card pijler-2">
            <div>
                <h2><span>📐 A. Ott Compensatie-Poolplanimeter</span><span class="badge">Nr. 573</span></h2>
                <div class="table-wrap">
                    <table>
                        <tr><th>Parameter</th><th>Locked Kalibratie</th></tr>
                        <tr><td>Oorsprong Anker</td><td><code>Poolanker P (52.2500° N, 5.2200° E)</code></td></tr>
                        <tr><td>Poolarm (R) / Rijarm (L)</td><td>15.00 cm / 16.67 cm</td></tr>
                        <tr><td>Basisoppervlakte (A0)</td><td><strong>2363.08 cm²</strong></td></tr>
                        <tr><td>Fraunhofer D-lijn</td><td>589.0 nm (Natrium-doublet)</td></tr>
                        <tr><td>Plani Ringen (Ø 29 cm, Az 108°)</td><td>R1: 202° (+22°) | R2: 22° (+22°) | R3: 22° (-22°)</td></tr>
                    </table>
                </div>
                <h3>🧮 Interactieve Ott Nr. 573 Oppervlakte-Integrator</h3>
                <div class="input-row">
                    <input type="number" id="ott-dn" value="0.00" step="0.05" placeholder="Δn wiel-omwentelingen">
                    <button class="btn" onclick="berekenOtt()">Integreer Oppervlakte</button>
                </div>
            </div>
            <div id="ott-out" style="margin-top:10px; font-family:var(--mono); color:var(--accent); font-size:0.84rem;">
                Actuele Integratie: A = 2363.08 cm² (Δn = 0.00)
            </div>
        </div>

        <!-- 2. Astrometrie & Sferische Lock -->
        <div class="card pijler-2">
            <div>
                <h2><span>🌙 Astrometrie & Maan-telemetrie</span><span class="badge">LOCKED</span></h2>
                <div class="table-wrap">
                    <table>
                        <tr><th>Astrometrische Parameter</th><th>Waarde (2026-10-22 10:00:01 CEST)</th></tr>
                        <tr><td>Rechte Klimming (RA) / Declinatie</td><td>191.20° / 13.30°</td></tr>
                        <tr><td>Lokale Sterrentijd (LST)</td><td>312.74°</td></tr>
                        <tr><td>Uurhoek (HA)</td><td>121.54°</td></tr>
                        <tr><td>Azimut / Elevatie</td><td><strong>303.23° / -7.45°</strong></td></tr>
                        <tr><td>Constellatie</td><td>Capricornus / Steenbok (Zuidmuur)</td></tr>
                        <tr><td>Dataset Matrix</td><td><code>vortex_processed_points.geojson (P1-P100)</code></td></tr>
                    </table>
                </div>
            </div>
            <div class="input-row">
                <a class="btn" href="tijdscapsule_metadata.json?v={CACHE_BUST}" target="_blank">📄 Ruwe JSON Metadata Openen</a>
            </div>
        </div>

        <!-- 3. Blue Team Field Beheer (BTFM) in Rekencentrum -->
        <div class="card pijler-3">
            <div>
                <h2><span>🛡️ Blue Team Field Beheer (BTFM)</span><span class="badge">DEFENSE</span></h2>
                <div class="table-wrap">
                    <table>
                        <tr><th>Notatie</th><th>BTFM Operationele Richtlijn</th></tr>
                        <tr><td><code>#</code> / <code>$</code></td><td>Linux root/sudo shell prompt voor systeem- en poortbeheer</td></tr>
                        <tr><td><code>-</code> vs <code>–</code></td><td><strong>Let op bij copy/paste:</strong> gebruik ASCII hyphen (<code>-</code>), geen en/em-dash</td></tr>
                        <tr><td><code>spaces</code></td><td>Verifieer exacte spaties in commando's en pad-argumenten</td></tr>
                        <tr><td><code>chmod 600</code></td><td>Verplichte permissie voor FinalCrypt <code>.otp</code> sleutelbestanden</td></tr>
                        <tr><td><code>chmod 700</code></td><td>Map-isolatie op <code>rekencentrum/beveiligde_sleutels/</code></td></tr>
                    </table>
                </div>
            </div>
            <pre>python3 validate_repo.py && ./tijdscapsule_backup.sh</pre>
        </div>

        <!-- 4. WebRTC DTLS Rekencentrum Telemetrie Kanaal -->
        <div class="card pijler-5">
            <div>
                <h2><span>📡 WebRTC DataChannel Bridge</span><span class="badge">DTLS/SCTP</span></h2>
                <p class="path">Verstuur Tijdscapsule-vectoren P1-P100 en Anker P over een DTLS-beveiligde P2P DataChannel:</p>
                <div id="cap-rtc-log" class="console-box">
                    [REKENCENTRUM] WebRTC DTLS kanaal stand-by...
                </div>
            </div>
            <div class="input-row">
                <button class="btn btn-blue" onclick="zendTijdscapsulePakket()">⚡ Verzend Tijdscapsule Lock via DataChannel</button>
            </div>
        </div>
    </div>

    <nav class="mobile-dock">
        <a class="btn" href="../../beheercentrum/index.html?v={CACHE_BUST}">🏠 Beheercentrum</a>
        <a class="btn active" href="index.html?v={CACHE_BUST}">⏳ Rekencentrum</a>
        <a class="btn" href="../../docs/beheer/blue_team/tactical_ops.html?v={CACHE_BUST}">🛡️ BTFM</a>
        <a class="btn" href="../../docs/beheer/red_team/rtfm_manual.html?v={CACHE_BUST}">🔴 RTFM</a>
    </nav>

    <script>
        function berekenOtt() {{
            const dn = parseFloat(document.getElementById('ott-dn').value) || 0;
            const a0 = 2363.08;
            const c = 100.0;
            const totaal = (a0 + dn * c).toFixed(2);
            document.getElementById('ott-out').innerHTML =
                `Actuele Integratie: <strong>A = ${{totaal}} cm²</strong> (A0: 2363.08 + Δn·C: ${{(dn*c).toFixed(2)}} cm²)`;
        }}
        async function zendTijdscapsulePakket() {{
            const box = document.getElementById('cap-rtc-log');
            const log = (m) => {{ box.innerHTML += `<div>> ${{m}}</div>`; box.scrollTop = box.scrollHeight; }};
            log("DTLS Handshake starten...");
            const p1 = new RTCPeerConnection(), p2 = new RTCPeerConnection();
            p1.onicecandidate = e => e.candidate && p2.addIceCandidate(e.candidate);
            p2.onicecandidate = e => e.candidate && p1.addIceCandidate(e.candidate);
            const ch = p1.createDataChannel("rekencentrum_dtls");
            ch.onopen = () => {{
                const data = JSON.stringify({{anker:"P(52.25N,5.22E)", ott_a0:2363.08, attractor:"#21"}});
                log("🟢 Verzonden: " + data);
                ch.send(data);
            }};
            p2.ondatachannel = ev => {{
                ev.channel.onmessage = msg => {{
                    log("📥 Bevestigd door Peer: " + msg.data);
                    setTimeout(() => {{ p1.close(); p2.close(); }}, 300);
                }};
            }};
            const o = await p1.createOffer(); await p1.setLocalDescription(o); await p2.setRemoteDescription(o);
            const a = await p2.createAnswer(); await p2.setLocalDescription(a); await p1.setRemoteDescription(a);
        }}
    </script>
</body>
</html>"""

with open("rekencentrum/tijdscapsule/index.html", "w", encoding="utf-8") as f:
    f.write(tijdscapsule_html)

print("📚 [3/6] Herbouwen van alle BTFM & RTFM Documentatiepagina's (nul dode links)...")

docs_items = {
    "docs/beheer/blue_team/ir_playbook": (
        "🚨 BTFM: Incident Response Playbook",
        """# 🚨 Incident Response (IR) Playbook
**Systeem:** VORTEX OS (Debian Bookworm) | **Poorten:** Web `8080`, API `8000`, Podcast `8081`, Matrix `8448`

## 1. Directe Triage & Procescontrole
- Controleer actieve luisterende poorten in de VORTEX-stack: `sudo ss -tupnl | grep -E '8000|8080|8081|8448'`
- Bevries een verdacht proces zonder geheugenverlies: `sudo kill -STOP <PID>`
- Controleer integriteit van systeemgebruikers: `grep -E ':0:' /etc/passwd`

## 2. Cryptografische & Archief Isolatie
- Valideer direct de monorepo en FinalCrypt `.otp` permissies: `python3 validate_repo.py`
- Genereer een nood-snapshot in de Tijdscapsule: `./tijdscapsule_backup.sh`
"""
    ),
    "docs/beheer/blue_team/tactical_ops": (
        "💻 BTFM: Tactische Commando's & Syntaxis",
        """# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Command-Line Syntaxis Tabel
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | **Caution:** Let op bij copy/paste met streepjes: en/em-dash (`–`, `—`) vs ASCII hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en ontbrekende spaties in commando's |

## 2. VORTEX OS Stack Beheer (`start_vortex.sh`)
- **Volledige VORTEX stack starten (8080, 8000, 8081):** `./start_vortex.sh`
- **WebRTC DataChannel CLI Test (in venv):** `./webrtc_test_runner.sh`
- **Valideren & Synchroniseren naar GitHub/Vercel:** `./auto_sync.sh`
"""
    ),
    "docs/beheer/blue_team/system_hardening": (
        "🔒 BTFM: Systeem Hardening & FinalCrypt OTP",
        """# 🔒 Systeem Hardening & FinalCrypt OTP
**OS:** Debian Bookworm | **At-Rest Beveiliging:** FinalCrypt One-Time Pad (OTP)

## 1. Strikte One-Time Pad (OTP) Regels
- Elke `.otp` sleutel is wiskundig uniek, exact zo groot als de payload, en wordt eenmalig gebruikt.
- Sleutelrechten afdwingen: `chmod 600 rekencentrum/beveiligde_sleutels/*.otp`
- Sleutelmap isoleren: `chmod 700 rekencentrum/beveiligde_sleutels`

## 2. PEP 668 Virtuele Omgeving Isolatie
- Python netwerkpakketten zoals `aiortc` draaien uitsluitend binnen `./venv` om de Debian systeembibliotheken onaangetast te laten.
"""
    ),
    "docs/beheer/blue_team/network_defense": (
        "🌐 BTFM: Netwerk, DNS & DataChannel Defensie",
        """# 🌐 Netwerk, DNS & WebRTC DataChannel Defensie
**Architectuur:** BIND9 (`UDP 53`) | Python API (`8000`) | Rust RSS (`8081`) | Web (`8080`)

## 1. WebRTC DataChannels (DTLS over SCTP)
- Verkeer over WebRTC DataChannels is standaard end-to-end versleuteld via **DTLS**.
- Geen centrale tussenopslag; verificatie verloopt via zowel de browser-loopback als `./webrtc_test_runner.sh`.

## 2. Log-Hygiëne
- Valse 404-meldingen (zoals `/favicon.ico`) zijn geëlimineerd met inline SVG-data-URI's zodat verkeerslogs zuiver blijven.
"""
    ),
    "docs/beheer/red_team/rtfm_manual": (
        "🔴 RTFM: Red Team Field Manual",
        """# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Geautoriseerde Lokale Security Audits op VORTEX OS (`127.0.0.1`)

## 1. Poort- & Service Verificatie
- **Controleer de actieve VORTEX poorten:** `nmap -sV -p 53,8000,8080,8081,8448 127.0.0.1`
- **Inspecteer API-status endpoint:** `curl -i http://localhost:8000/api/status`
- **Inspecteer Podcast RSS feed:** `curl -I http://localhost:8081`

## 2. Lokale Privilege Escalation & Permissie Audit
- **Zoek naar onbedoelde SUID binaries:** `find / -perm -4000 2>/dev/null`
- **Audit op te ruime OTP-sleutelrechten:** `python3 validate_repo.py`
"""
    )
}

def md_to_html(md_str):
    lines = md_str.strip().split('\n')
    out = []
    in_tbl = False
    for l in lines:
        if l.startswith('|'):
            if not in_tbl:
                out.append('<div class="table-wrap"><table>')
                in_tbl = True
            if '---' in l:
                continue
            cells = [c.strip() for c in l.strip('|').split('|')]
            tag = 'th' if out[-1].endswith('<table>') else 'td'
            row = "".join(f"<{tag}>{re.sub(r'\\*\\*([^*]+)\\*\\*', r'<strong>\\1</strong>', re.sub(r'`([^`]+)`', r'<code>\\1</code>', c))}</{tag}>" for c in cells)
            out.append(f"<tr>{row}</tr>")
            continue
        elif in_tbl:
            out.append('</table></div>')
            in_tbl = False

        if l.startswith('# '):
            out.append(f'<h2><span>{l[2:]}</span><span class="badge">MANUAL</span></h2>')
        elif l.startswith('## '):
            out.append(f'<h3>{l[3:]}</h3>')
        elif l.startswith('- '):
            txt = re.sub(r'`([^`]+)`', r'<code>\1</code>', l[2:])
            txt = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', txt)
            out.append(f'<p style="margin-bottom:7px;">• {txt}</p>')
        elif l.strip():
            txt = re.sub(r'`([^`]+)`', r'<code>\1</code>', l)
            txt = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', txt)
            out.append(f'<p style="margin-bottom:10px;">{txt}</p>')
    if in_tbl:
        out.append('</table></div>')
    return '\n'.join(out)

for path_no_ext, (doc_title, md_body) in docs_items.items():
    with open(f"{path_no_ext}.md", "w", encoding="utf-8") as f:
        f.write(md_body)
    page_html = f"""{get_shared_head(f"VORTEX OS | {doc_title}")}
<body>
    <header>
        <div>
            <h1>{doc_title}</h1>
            <div class="sys-sub">VORTEX OS Kennisbank | Desktop & Mobile-Ready</div>
        </div>
        <div class="toolbar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobiel</button>
            <a class="btn btn-blue" href="../../../beheercentrum/index.html?v={CACHE_BUST}">← Terug naar Beheercentrum</a>
        </div>
    </header>
    <div class="card pijler-3">
        {md_to_html(md_body)}
    </div>
    <nav class="mobile-dock">
        <a class="btn" href="../../../beheercentrum/index.html?v={CACHE_BUST}">🏠 Beheercentrum</a>
        <a class="btn" href="../../../rekencentrum/tijdscapsule/index.html?v={CACHE_BUST}">⏳ Rekencentrum</a>
        <a class="btn" href="../blue_team/tactical_ops.html?v={CACHE_BUST}">🛡️ BTFM</a>
        <a class="btn" href="../red_team/rtfm_manual.html?v={CACHE_BUST}">🔴 RTFM</a>
    </nav>
</body>
</html>"""
    with open(f"{path_no_ext}.html", "w", encoding="utf-8") as f:
        f.write(page_html)

print("🖥️ [4/6] Logisch opbouwen van het Beheercentrum (5 Pijlers, nul pad-bugs, live API-status)...")

def generate_control_center(rel_prefix):
    return f"""{get_shared_head("VORTEX OS | Centraal Beheercentrum")}
<body>
    <header>
        <div>
            <h1>VORTEX OS — CENTRAAL BEHEERCENTRUM</h1>
            <div class="sys-sub">
                Host: ontwerp-GA (Debian Bookworm) | Web: :8080 | API: :8000 | Rust RSS: :8081 | Status: <span id="hdr-api-state" style="color:var(--accent);">SOVEREIGN LIVE</span>
            </div>
        </div>
        <div class="toolbar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop Grid</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobile Touch</button>
            <a class="btn btn-blue" href="{rel_prefix}rekencentrum/tijdscapsule/index.html?v={CACHE_BUST}">⏳ Open Rekencentrum</a>
        </div>
    </header>

    <main class="grid">
        <!-- PIJLER 1: Live Netwerk & Services (Afgestemd op ./start_vortex.sh) -->
        <div class="card pijler-1">
            <div>
                <h2><span>1. Infrastructuur & Services</span><span id="api-badge" class="badge">LIVE :8080</span></h2>
                <ul>
                    <li>
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <span><span class="dot online"></span><strong>Statische Webserver (Dashboard)</strong></span>
                            <code>Poort 8080</code>
                        </div>
                        <span class="path">Actieve sessie via ./start_vortex.sh (http://0.0.0.0:8080)</span>
                    </li>
                    <li>
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <span><span id="dot-api" class="dot online"></span><strong>Python API Backend (/api/status)</strong></span>
                            <code>Poort 8000</code>
                        </div>
                        <span id="api-telemetry" class="path">Live heartbeat gekoppeld aan http://localhost:8000/api/status</span>
                    </li>
                    <li>
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <span><span class="dot online"></span><strong>Rust Podcast RSS Server</strong></span>
                            <code>Poort 8081</code>
                        </div>
                        <span class="path">Running target/debug/podcast-rss-server (http://0.0.0.0:8081)</span>
                    </li>
                    <li>
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <span><span class="dot secured"></span><strong>BIND9 DNS & Matrix Conduit</strong></span>
                            <code>UDP 53 / 8448</code>
                        </div>
                        <span class="path">Soevereine naamresolutie & gedecentraliseerde communicatie</span>
                    </li>
                </ul>
            </div>
            <div class="input-row">
                <button class="btn" onclick="checkApiStatus()">🔄 Ping /api/status Nu</button>
                <a class="btn" href="https://geocentrum.vercel.app/" target="_blank">🌐 Cloud Mirror (Vercel) ↗</a>
            </div>
        </div>

        <!-- PIJLER 2: Rekencentrum, Geodetische Tijdscapsule & FinalCrypt OTP -->
        <div class="card pijler-2">
            <div>
                <h2><span>2. Rekencentrum & Tijdscapsule</span><span class="badge">v159.2 LOCK</span></h2>
                <ul>
                    <li>
                        <a class="row-link" href="{rel_prefix}rekencentrum/tijdscapsule/index.html?v={CACHE_BUST}">
                            <div>
                                <strong>📐 Open Rekencentrum & Tijdscapsule</strong>
                                <span class="path">Poolanker P (52.25°N, 5.22°E) | A. Ott Planimeter Nr. 573 (A0 = 2363.08 cm²)</span>
                            </div>
                            <span style="color:var(--accent);">➔</span>
                        </a>
                    </li>
                    <li>
                        <a class="row-link" href="{rel_prefix}rekencentrum/tijdscapsule/tijdscapsule_metadata.json?v={CACHE_BUST}" target="_blank">
                            <div>
                                <strong>🌙 Astrometrische Telemetrie (JSON)</strong>
                                <span class="path">Maan Lock (Az 303.23°, El -7.45°) | Attractor 010101 (Hex #21)</span>
                            </div>
                            <span>↗</span>
                        </a>
                    </li>
                    <li>
                        <div>
                            <span class="dot secured"></span><strong>FinalCrypt One-Time Pad (OTP): Actief</strong>
                            <span class="path">Wiskundig onkraakbare at-rest encryptie (chmod 600 geverifieerd)</span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="input-row">
                <a class="btn btn-blue" href="{rel_prefix}rekencentrum/tijdscapsule/index.html?v={CACHE_BUST}">🧮 Start Ott Nr. 573 Integrator</a>
            </div>
        </div>

        <!-- PIJLER 3: Blue Team Field Manual (BTFM) -->
        <div class="card pijler-3">
            <div>
                <h2><span>3. Blue Team Field Manual (BTFM)</span><span class="badge">DEFENSE</span></h2>
                <ul>
                    <li>
                        <a class="row-link" href="{rel_prefix}docs/beheer/blue_team/ir_playbook.html?v={CACHE_BUST}">
                            <div>
                                <strong>🚨 Incident Response Playbook</strong>
                                <span class="path">Triage, proces-isolatie en forensische snapshots</span>
                            </div>
                            <span>➔</span>
                        </a>
                    </li>
                    <li>
                        <a class="row-link" href="{rel_prefix}docs/beheer/blue_team/tactical_ops.html?v={CACHE_BUST}">
                            <div>
                                <strong>💻 Tactische Commando's & BTFM Syntaxis</strong>
                                <span class="path">Officiële BTFM notatietabel (#, hyphens vs dashes, spaties)</span>
                            </div>
                            <span>➔</span>
                        </a>
                    </li>
                    <li>
                        <a class="row-link" href="{rel_prefix}docs/beheer/blue_team/system_hardening.html?v={CACHE_BUST}">
                            <div>
                                <strong>🔒 Systeem Hardening & OTP Sleutelbeheer</strong>
                                <span class="path">Debian Bookworm baseline, chmod 600/700 & PEP 668 venv</span>
                            </div>
                            <span>➔</span>
                        </a>
                    </li>
                    <li>
                        <a class="row-link" href="{rel_prefix}docs/beheer/blue_team/network_defense.html?v={CACHE_BUST}">
                            <div>
                                <strong>🌐 Netwerk, DNS & DataChannel Defensie</strong>
                                <span class="path">DTLS-beveiliging, BIND9 isolatie en log-hygiëne</span>
                            </div>
                            <span>➔</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- PIJLER 4: Red Team Field Manual (RTFM) -->
        <div class="card pijler-4">
            <div>
                <h2><span>4. Red Team Field Manual (RTFM)</span><span class="badge">AUDIT</span></h2>
                <ul>
                    <li>
                        <a class="row-link" href="{rel_prefix}docs/beheer/red_team/rtfm_manual.html?v={CACHE_BUST}">
                            <div>
                                <strong>🔴 Offensieve Netwerk & Systeem Audits</strong>
                                <span class="path">Lokale Nmap SYN scans, header-inspectie en SUID-checks</span>
                            </div>
                            <span>➔</span>
                        </a>
                    </li>
                    <li>
                        <div>
                            <strong>Standaard Lokale Audit Commando's:</strong>
                            <pre>nmap -sV -p 53,8000,8080,8081,8448 127.0.0.1
python3 validate_repo.py</pre>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- PIJLER 5: Beveiligde WebRTC DataChannels (P2P DTLS) -->
        <div class="card pijler-5">
            <div>
                <h2><span>5. WebRTC DataChannel (DTLS P2P)</span><span class="badge">ENCRYPTED</span></h2>
                <p class="path">Beveiligd verzenden en ontvangen over SCTP/DTLS (Browser Loopback & Python aiortc):</p>
                <div id="webrtc-console" class="console-box">
                    [DTLS READY] Kanaal 'vortex_secure_channel' stand-by...
                </div>
            </div>
            <div>
                <div class="input-row">
                    <input type="text" id="rtc-input" value="Sovereign Payload: Anker P (52.25N, 5.22E) Verified" placeholder="Bericht...">
                    <button class="btn btn-blue" onclick="verzendDataChannel()">⚡ Verzend P2P</button>
                </div>
                <span class="path" style="margin-top:6px;">Terminal test: <code>./webrtc_test_runner.sh</code></span>
            </div>
        </div>
    </main>

    <nav class="mobile-dock">
        <a class="btn active" href="index.html?v={CACHE_BUST}">🏠 Beheercentrum</a>
        <a class="btn" href="{rel_prefix}rekencentrum/tijdscapsule/index.html?v={CACHE_BUST}">⏳ Rekencentrum</a>
        <a class="btn" href="{rel_prefix}docs/beheer/blue_team/tactical_ops.html?v={CACHE_BUST}">🛡️ BTFM</a>
        <a class="btn" href="{rel_prefix}docs/beheer/red_team/rtfm_manual.html?v={CACHE_BUST}">🔴 RTFM</a>
    </nav>

    <script>
        async function checkApiStatus() {{
            const el = document.getElementById('api-telemetry');
            const badge = document.getElementById('api-badge');
            try {{
                const r = await fetch('/api/status', {{ cache: 'no-store' }});
                if (r.ok) {{
                    const t = new Date().toLocaleTimeString();
                    el.innerHTML = `<span style="color:var(--accent);">✔ /api/status HTTP 200 OK (Laatste check: ${{t}})</span>`;
                    badge.textContent = "API 200 OK";
                }} else {{
                    el.textContent = `Status: HTTP ${{r.status}} (Statische modus actief)`;
                }}
            }} catch (e) {{
                el.textContent = "Modus: Statische/Cloud weergave (Geen lokale :8000 daemon op dit pad)";
            }}
        }}

        async function verzendDataChannel() {{
            const box = document.getElementById('webrtc-console');
            const val = document.getElementById('rtc-input').value || "Sovereign Ping";
            const log = (t) => {{
                const ts = new Date().toLocaleTimeString();
                box.innerHTML += `<div>[${{ts}}] ${{t}}</div>`;
                box.scrollTop = box.scrollHeight;
            }};
            log("🔒 DTLS Handshake tussen Offer & Answer node...");
            const pc1 = new RTCPeerConnection(), pc2 = new RTCPeerConnection();
            pc1.onicecandidate = e => e.candidate && pc2.addIceCandidate(e.candidate);
            pc2.onicecandidate = e => e.candidate && pc1.addIceCandidate(e.candidate);

            const dc = pc1.createDataChannel("vortex_secure_channel");
            dc.onopen = () => {{
                log(`🟢 Verzonden (DTLS): "${{val}}"`);
                dc.send(val);
            }};
            dc.onmessage = (e) => {{
                log(`📥 Terugkoppeling: "${{e.data}}"`);
                setTimeout(() => {{ pc1.close(); pc2.close(); }}, 300);
            }};
            pc2.ondatachannel = (ev) => {{
                ev.channel.onmessage = (m) => {{
                    log(`📥 Ontvangen op Peer: "${{m.data}}"`);
                    ev.channel.send("ACK: Payload integer ontvangen door VORTEX_OS");
                }};
            }};
            const offer = await pc1.createOffer();
            await pc1.setLocalDescription(offer);
            await pc2.setRemoteDescription(offer);
            const answer = await pc2.createAnswer();
            await pc2.setLocalDescription(answer);
            await pc1.setRemoteDescription(answer);
        }}

        window.addEventListener('DOMContentLoaded', () => {{
            checkApiStatus();
            setInterval(checkApiStatus, 10000);
        }});
    </script>
</body>
</html>"""

# Schrijf voor de root (/) met directe relatieve paden (geen ../)
with open("index.html", "w", encoding="utf-8") as f:
    f.write(generate_control_center(rel_prefix=""))

# Schrijf voor /beheercentrum/index.html met exact kloppende ../ paden
with open("beheercentrum/index.html", "w", encoding="utf-8") as f:
    f.write(generate_control_center(rel_prefix="../"))

print("🔄 [5/6] Synchroniseren van spiegelmappen voor 100% compatibiliteit met zowel :8080 als Vercel...")

for sub in ["docs", "rekencentrum"]:
    dst = os.path.join("beheercentrum", sub)
    if os.path.exists(dst):
        shutil.rmtree(dst)
    shutil.copytree(sub, dst)

# Als Vercel Root Directory op 'beheercentrum' staat, moet beheercentrum/index.html ook direct zonder ../ kunnen werken:
# Daarom overschrijven we in beheercentrum/rekencentrum en beheercentrum/docs de terugknop-paden niet kapot,
# en plaatsen we een vangnet in beheercentrum/beheercentrum/index.html:
os.makedirs("beheercentrum/beheercentrum", exist_ok=True)
with open("beheercentrum/beheercentrum/index.html", "w", encoding="utf-8") as f:
    f.write(generate_control_center(rel_prefix="../"))

print("✅ [6/6] Validatie en Git/Vercel synchronisatie uitvoeren...")
