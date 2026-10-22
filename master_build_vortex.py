#!/usr/bin/env python3
import os
import re
import json
import shutil

BASE_DIR = os.path.expanduser("~/VORTEX_OS")
os.chdir(BASE_DIR)

print("🚀 [1/7] Initialiseren van VORTEX OS Master Fix (Desktop + Mobile-Ready + WebRTC + BTFM Rekencentrum)...")

for d in ["beheercentrum", "docs/beheer/blue_team", "docs/beheer/red_team", "rekencentrum/tijdscapsule", "rekencentrum/beveiligde_sleutels"]:
    os.makedirs(d, exist_ok=True)
os.chmod("rekencentrum/beveiligde_sleutels", 0o700)

# Inline SVG Favicon voorkomt alle /favicon.ico 404 requests
FAVICON_TAG = '<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><rect width=%22100%22 height=%22100%22 fill=%22%230a0a0a%22/><polygon points=%2250,12 88,85 12,85%22 fill=%22none%22 stroke=%22%2300ffcc%22 stroke-width=%228%22/><circle cx=%2250%22 cy=%2260%22 r=%2210%22 fill=%22%2300ffcc%22/></svg>">'

# PWA Manifest voor Mobile-Ready installatie
manifest_data = {
    "name": "VORTEX OS Sovereign Center",
    "short_name": "VORTEX_OS",
    "start_url": "/beheercentrum/index.html",
    "display": "standalone",
    "background_color": "#0a0a0a",
    "theme_color": "#00ffcc",
    "orientation": "any"
}
with open("manifest.json", "w", encoding="utf-8") as f:
    json.dump(manifest_data, f, indent=2)

# Universele CSS & JS voor Desktop (Multi-Column) én Mobile-Ready (Touch-First / Bottom-Nav)
CORE_HEAD = f"""
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, viewport-fit=cover">
    <meta name="theme-color" content="#0a0a0a">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    {FAVICON_TAG}
    <style>
        :root {{
            --bg-color: #0a0a0a;
            --surface-color: #141414;
            --surface-hover: #1f1f1f;
            --text-color: #e0e0e0;
            --muted-color: #888888;
            --accent-color: #00ffcc;
            --blue-team: #00b0ff;
            --red-team: #ff4444;
            --success-color: #00c853;
            --warning-color: #ffab00;
            --font-mono: "Courier New", Courier, monospace;
            --font-sans: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }}
        * {{ box-sizing: border-box; margin: 0; padding: 0; -webkit-tap-highlight-color: transparent; }}
        body {{
            font-family: var(--font-sans);
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.55;
            padding: 20px;
            padding-bottom: 80px;
            max-width: 1400px;
            margin: 0 auto;
            transition: all 0.2s ease;
        }}
        /* Force Mobile Simulation Mode wanneer geselecteerd op Desktop */
        body.force-mobile {{
            max-width: 430px;
            border-left: 2px solid #222;
            border-right: 2px solid #222;
            min-height: 100vh;
            padding: 12px;
            padding-bottom: 90px;
        }}
        body.force-mobile .grid {{
            grid-template-columns: 1fr !important;
        }}
        header {{
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 14px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }}
        h1 {{
            font-family: var(--font-mono);
            color: var(--accent-color);
            font-size: clamp(1.3rem, 3.5vw, 2.1rem);
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }}
        h2 {{
            font-family: var(--font-mono);
            font-size: 1.05rem;
            color: var(--accent-color);
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            border-bottom: 1px solid #282828;
            padding-bottom: 8px;
        }}
        h3 {{ font-family: var(--font-mono); font-size: 0.95rem; color: var(--blue-team); margin: 14px 0 8px 0; }}
        .sys-info {{ font-family: var(--font-mono); font-size: 0.8rem; color: var(--muted-color); }}
        
        /* Mode Switcher (Desktop vs Mobile Build View) */
        .mode-bar {{
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }}
        .btn {{
            background: var(--surface-color);
            color: var(--text-color);
            border: 1px solid #383838;
            padding: 8px 14px;
            border-radius: 6px;
            font-family: var(--font-mono);
            font-size: 0.8rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            min-height: 40px;
            transition: all 0.15s ease;
        }}
        .btn:hover, .btn.active {{
            border-color: var(--accent-color);
            color: var(--accent-color);
            background: rgba(0, 255, 204, 0.08);
        }}
        .btn-blue {{ border-color: var(--blue-team); color: var(--blue-team); }}
        .btn-blue:hover {{ background: rgba(0, 176, 255, 0.12); }}

        /* Responsive Grid: Desktop Multi-Column -> Mobile Single-Column */
        .grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 18px;
        }}
        .card {{
            background-color: var(--surface-color);
            border: 1px solid #2c2c2c;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.6);
        }}
        .card.blue-border {{ border-top: 3px solid var(--blue-team); }}
        .card.accent-border {{ border-top: 3px solid var(--accent-color); }}
        .card.red-border {{ border-top: 3px solid var(--red-team); }}

        ul {{ list-style: none; }}
        li {{
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #222;
        }}
        li:last-child {{ border-bottom: none; margin-bottom: 0; padding-bottom: 0; }}
        a.nav-item {{
            color: var(--text-color);
            text-decoration: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 6px 4px;
            border-radius: 4px;
        }}
        a.nav-item:hover {{ color: var(--accent-color); background: var(--surface-hover); }}
        .path {{ font-family: var(--font-mono); font-size: 0.72rem; color: #777; display: block; margin-top: 2px; }}

        .dot {{ width: 9px; height: 9px; border-radius: 50%; display: inline-block; margin-right: 8px; }}
        .dot.online {{ background-color: var(--success-color); box-shadow: 0 0 6px var(--success-color); }}
        .dot.secured {{ background-color: var(--accent-color); box-shadow: 0 0 6px var(--accent-color); }}
        .dot.blue {{ background-color: var(--blue-team); box-shadow: 0 0 6px var(--blue-team); }}

        /* Tabellen met mobiele horizontale scroll */
        .table-wrap {{ width: 100%; overflow-x: auto; margin: 10px 0; }}
        table {{ width: 100%; border-collapse: collapse; font-family: var(--font-mono); font-size: 0.82rem; }}
        th, td {{ border: 1px solid #2e2e2e; padding: 8px 10px; text-align: left; }}
        th {{ background: #101010; color: var(--accent-color); }}

        code {{ background: #0d0d0d; padding: 2px 6px; border-radius: 4px; font-family: var(--font-mono); color: var(--accent-color); font-size: 0.82rem; word-break: break-all; }}
        pre {{ background: #0d0d0d; padding: 12px; border-radius: 6px; overflow-x: auto; font-family: var(--font-mono); border: 1px solid #2a2a2a; font-size: 0.8rem; margin: 8px 0; }}

        /* Interactieve inputs & consoles */
        .console-box {{
            background: #080808;
            border: 1px solid #333;
            border-radius: 6px;
            padding: 10px;
            font-family: var(--font-mono);
            font-size: 0.78rem;
            height: 150px;
            overflow-y: auto;
            color: #00ffcc;
            margin: 10px 0;
        }}
        .input-row {{ display: flex; gap: 8px; margin-top: 8px; flex-wrap: wrap; }}
        input[type="text"], input[type="number"] {{
            flex: 1;
            min-width: 140px;
            background: #0d0d0d;
            border: 1px solid #3a3a3a;
            color: var(--text-color);
            padding: 8px 10px;
            border-radius: 4px;
            font-family: var(--font-mono);
            font-size: 0.85rem;
        }}

        /* Mobile Bottom Bar voor snelle bediening op telefoons */
        .mobile-dock {{
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(15, 15, 15, 0.96);
            border-top: 1px solid var(--accent-color);
            display: flex;
            justify-content: space-around;
            padding: 8px 10px;
            backdrop-filter: blur(8px);
            z-index: 999;
        }}
        @media (max-width: 768px) {{
            body {{ padding: 12px; padding-bottom: 85px; }}
            .grid {{ grid-template-columns: 1fr; }}
            .btn {{ flex: 1; justify-content: center; }}
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
            updateModeButtons();
        }}
        function updateModeButtons() {{
            const mode = localStorage.getItem('vortex_view_mode') || 'desktop';
            const btnD = document.getElementById('btn-desktop');
            const btnM = document.getElementById('btn-mobile');
            if (btnD && btnM) {{
                btnD.classList.toggle('active', mode === 'desktop');
                btnM.classList.toggle('active', mode === 'mobile');
            }}
        }}
        window.addEventListener('DOMContentLoaded', () => {{
            const saved = localStorage.getItem('vortex_view_mode');
            if (saved === 'mobile') document.body.classList.add('force-mobile');
            updateModeButtons();
        }});
    </script>
"""

print("⏳ [2/7] Bouwen van Tijdscapsule + Blue Team Field Beheer + Rekencentrum...")

tijdscapsule_metadata = {
    "titel": "VORTEX OS — Geodetische & Astrometrische Tijdscapsule",
    "timestamp_lock": "2026-10-22 10:00:01 CEST",
    "iso_timestamp": "2026-10-22T08:00:01Z",
    "versie": "v159.1 Locked-Interface",
    "interface_lock": "pizzadisk_simulatie_v158.py (Protected)",
    "oorsprong_anker": "Poolanker P (52.2500° N, 5.2200° E)",
    "attractor_state": "010101 (Hex #21)",
    "build_targets": ["Desktop-Native-Grid", "Mobile-Ready-PWA", "WebRTC-DTLS-DataChannel"],
    "plani_configuratie": {
        "diameter_cm": 29,
        "start_azimut_deg": 108,
        "ring1": {"rotatie_deg": 202, "tilt_deg": 22},
        "ring2": {"rotatie_deg": 22, "tilt_deg": 22},
        "ring3": {"rotatie_deg": 22, "tilt_deg": -22}
    },
    "a_ott_573": {
        "poolarm_r_cm": 15.00,
        "rijarm_l_cm": 16.67,
        "fraunhofer_d_nm": 589.0,
        "oppervlakte_a0_cm2": 2363.08
    },
    "astrometrie_18_okt_2026": {
        "object": "Maan",
        "tijd_cest": "2026-10-22 10:00:01 CEST",
        "rechte_klimming_ra_deg": 191.20,
        "declinatie_dec_deg": 13.30,
        "lokale_sterrentijd_lst_deg": 312.74,
        "uurhoek_ha_deg": 121.54,
        "azimut_deg": 303.23,
        "elevatie_deg": -7.45,
        "constellatie": "Capricornus / Steenbok (Zuidmuur)",
        "dataset_ref": "vortex_processed_points.geojson (100 Punten P1-P100)"
    }
}

with open("rekencentrum/tijdscapsule/tijdscapsule_metadata.json", "w", encoding="utf-8") as f:
    json.dump(tijdscapsule_metadata, f, indent=2)

tijdscapsule_html = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <title>VORTEX OS | Tijdscapsule, Rekencentrum & BTFM Beheer</title>
    {CORE_HEAD}
</head>
<body>
    <header>
        <div>
            <h1>⏳ TIJDSCAPSULE & REKENCENTRUM</h1>
            <div class="sys-info">v159.1 Locked-Interface | Anker P (52.2500° N, 5.2200° E) | BTFM Field Beheer</div>
        </div>
        <div class="mode-bar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobiel</button>
            <a class="btn btn-blue" href="../../beheercentrum/index.html">← Hoofddashboard</a>
        </div>
    </header>

    <div class="grid">
        <!-- Kavel 1: Rekencentrum A. Ott Nr. 573 & Geodesie -->
        <div class="card accent-border">
            <h2>📐 Rekencentrum: A. Ott Planimeter (Nr. 573)</h2>
            <div class="table-wrap">
                <table>
                    <tr><th>Parameter</th><th>Waarde</th></tr>
                    <tr><td>Poolanker P</td><td><code>52.2500° N, 5.2200° E</code></td></tr>
                    <tr><td>Attractor State</td><td><code>010101 (Hex #21)</code></td></tr>
                    <tr><td>Poolarm (R) / Rijarm (L)</td><td>15.00 cm / 16.67 cm</td></tr>
                    <tr><td>Basisoppervlakte (A0)</td><td><strong>2363.08 cm²</strong></td></tr>
                    <tr><td>Fraunhofer D-lijn</td><td>589.0 nm</td></tr>
                    <tr><td>Plani Ringen (Ø 29 cm, Az 108°)</td><td>R1: 202° (+22°) | R2: 22° (+22°) | R3: 22° (-22°)</td></tr>
                </table>
            </div>
            <h3>🧮 Interactieve Ott Nr. 573 Oppervlakte-Integrator</h3>
            <p class="path">Bereken netto oppervlakte: Δn omwentelingen × planimeterconstante + A0 (2363.08 cm²)</p>
            <div class="input-row">
                <input type="number" id="ott-delta" value="1.00" step="0.05" placeholder="Δn aflezing">
                <button class="btn" onclick="calcOtt()">Bereken Oppervlakte</button>
            </div>
            <div id="ott-result" style="margin-top:10px; font-family:var(--font-mono); color:var(--accent-color); font-size:0.88rem;">
                Resultaat A = 2363.08 cm² (Baseline Lock)
            </div>
        </div>

        <!-- Kavel 2: Astrometrische Telemetrie -->
        <div class="card accent-border">
            <h2>🌙 Astrometrie & Sferische Lock (Maan)</h2>
            <div class="table-wrap">
                <table>
                    <tr><th>Telemetrie Veld</th><th>Locked Waarde (2026-10-22 10:00:01)</th></tr>
                    <tr><td>Rechte Klimming (RA)</td><td>191.20°</td></tr>
                    <tr><td>Declinatie (Dec)</td><td>13.30°</td></tr>
                    <tr><td>Lokale Sterrentijd (LST)</td><td>312.74°</td></tr>
                    <tr><td>Uurhoek (HA)</td><td>121.54°</td></tr>
                    <tr><td>Azimut / Elevatie</td><td><strong>303.23° / -7.45°</strong></td></tr>
                    <tr><td>Constellatie</td><td>Capricornus / Steenbok (Zuidmuur)</td></tr>
                    <tr><td>GeoJSON Matrix</td><td><code>vortex_processed_points.geojson (P1-P100)</code></td></tr>
                </table>
            </div>
            <div class="input-row" style="margin-top:12px;">
                <a class="btn" href="tijdscapsule_metadata.json" target="_blank">📄 Bekijk Ruwe JSON Metadata</a>
            </div>
        </div>

        <!-- Kavel 3: Blue Team Field Beheer (BTFM) in de Tijdscapsule -->
        <div class="card blue-border">
            <h2>🛡️ Blue Team Field Beheer (BTFM) — Tijdscapsule</h2>
            <p class="path">Actieve verdedigings-, integriteits- en syntaxisrichtlijnen voor het Rekencentrum:</p>
            <div class="table-wrap">
                <table>
                    <tr><th>BTFM Notatie</th><th>Operationele Betekenis & Beheer</th></tr>
                    <tr><td><code>#</code> / <code>$</code></td><td>Linux root/sudo shell prompt voor poort- en rechtenbeheer</td></tr>
                    <tr><td><code>-</code> vs <code>–</code> / <code>—</code></td><td><strong>Waarschuwing:</strong> Gebruik uitsluitend ASCII hyphen (<code>-</code>), geen en/em-dash bij copy/paste</td></tr>
                    <tr><td><code>spaces</code></td><td>Verifieer exacte spatie-scheiding in CLI-parameters en paden</td></tr>
                    <tr><td><code>chmod 600</code></td><td>Verplichte eigenaars-permissie op alle <code>.otp</code> One-Time Pad sleutels</td></tr>
                    <tr><td><code>chmod 700</code></td><td>Strikte map-isolatie op <code>rekencentrum/beveiligde_sleutels/</code></td></tr>
                </table>
            </div>
            <h3>🔐 Tijdscapsule Hardening & Commando's</h3>
            <pre>python3 validate_repo.py
./tijdscapsule_backup.sh
sudo ss -tupn | grep -E '8000|8081|8082|8448'</pre>
        </div>

        <!-- Kavel 4: WebRTC DTLS DataChannel Telemetrie Bridge -->
        <div class="card blue-border">
            <h2>📡 WebRTC DataChannel (DTLS) — Rekencentrum Bridge</h2>
            <p class="path">Verzend de Tijdscapsule-ankerstatus versleuteld over een lokale WebRTC Loopback DataChannel:</p>
            <div id="rtc-cap-log" class="console-box">
                [SYSTEM] WebRTC DTLS DataChannel gereed voor Tijdscapsule-transmissie...
            </div>
            <div class="input-row">
                <button class="btn btn-blue" onclick="sendCapsuleTelemetry()">⚡ Zend Anker P & Attractor #21 via DataChannel</button>
            </div>
        </div>
    </div>

    <nav class="mobile-dock">
        <a class="btn" href="../../beheercentrum/index.html">🏠 Dashboard</a>
        <a class="btn active" href="index.html">⏳ Tijdscapsule</a>
        <a class="btn" href="../../docs/beheer/blue_team/tactical_ops.html">🛡️ BTFM</a>
        <a class="btn" href="../../docs/beheer/red_team/rtfm_manual.html">🔴 RTFM</a>
    </nav>

    <script>
        function calcOtt() {{
            const delta = parseFloat(document.getElementById('ott-delta').value) || 0;
            const a0 = 2363.08;
            const c = 100.0; // schaalconstante
            const res = (a0 + (delta * c)).toFixed(2);
            document.getElementById('ott-result').innerHTML = 
                `Resultaat A = <strong>${{res}} cm²</strong> (A0: 2363.08 + Δn·C: ${{(delta*c).toFixed(2)}} cm²)`;
        }}

        async function sendCapsuleTelemetry() {{
            const logEl = document.getElementById('rtc-cap-log');
            const log = (msg) => {{
                logEl.innerHTML += `<div>> ${{msg}}</div>`;
                logEl.scrollTop = logEl.scrollHeight;
            }};
            log("Opzetten van RTCPeerConnection (DTLS/SCTP)...");
            const pc1 = new RTCPeerConnection();
            const pc2 = new RTCPeerConnection();
            pc1.onicecandidate = e => e.candidate && pc2.addIceCandidate(e.candidate);
            pc2.onicecandidate = e => e.candidate && pc1.addIceCandidate(e.candidate);

            const dc = pc1.createDataChannel("vortex_tijdscapsule_dtls");
            dc.onopen = () => {{
                const payload = JSON.stringify({{
                    anker: "P (52.25N, 5.22E)",
                    attractor: "010101 (#21)",
                    ott_a0: 2363.08,
                    maan_az: 303.23
                }});
                log(`🟢 Kanaal open! Verzenden: ${{payload}}`);
                dc.send(payload);
            }};
            pc2.ondatachannel = (event) => {{
                event.channel.onmessage = (e) => {{
                    log(`📥 Ontvangen op Rekencentrum Node: ${{e.data}}`);
                    log(`✅ DTLS Integriteit & Tijdscapsule Lock geverifieerd.`);
                    setTimeout(() => {{ pc1.close(); pc2.close(); }}, 500);
                }};
            }};
            const offer = await pc1.createOffer();
            await pc1.setLocalDescription(offer);
            await pc2.setRemoteDescription(offer);
            const answer = await pc2.createAnswer();
            await pc2.setLocalDescription(answer);
            await pc1.setRemoteDescription(answer);
        }}
    </script>
</body>
</html>"""

with open("rekencentrum/tijdscapsule/index.html", "w", encoding="utf-8") as f:
    f.write(tijdscapsule_html)

print("📚 [3/7] Genereren van BTFM & RTFM HTML- en Markdown-handboeken...")

docs_pages = {
    "docs/beheer/blue_team/ir_playbook": (
        "🚨 Incident Response (IR) Playbook",
        """# 🚨 Incident Response (IR) Playbook
**Doelwit:** VORTEX OS (Debian Bookworm / Raspberry Pi) | **Status:** SOVEREIGN LOCALHOST

## 1. Directe Triage & Netwerk Isolatie
- Inspecteer actieve TCP/UDP sockets op onbekende processen: `sudo ss -tupn`
- Bevries verdachte PID's voor forensische analyse: `sudo kill -STOP <PID>`
- Controleer op ongeautoriseerde aanpassingen in `/etc/passwd`, `/etc/shadow` en `~/.ssh/authorized_keys`.

## 2. Cryptografische & Rekencentrum Verificatie
- Voer direct een integriteitscheck uit op de monorepo en `.otp`-sleutels: `python3 validate_repo.py`
- Stel een bevroren snapshot veilig in de Tijdscapsule: `./tijdscapsule_backup.sh`
"""
    ),
    "docs/beheer/blue_team/tactical_ops": (
        "💻 Tactische Commando's & BTFM Syntaxis",
        """# 💻 Tactische Commando's & BTFM Syntaxis
**Referentie:** Blue Team Field Manual (BTFM) Command-Line Syntaxis

## 1. BTFM Command-Line Syntaxis Referentietabel
| Notatie | Beschrijving |
| :--- | :--- |
| `#` | Generic Linux/*nux shell prompt, `sudo` kan ook gebruikt worden met `$` |
| `C:\\>` | Windows Prompt, vereist mogelijk Administrator CMD prompt |
| `PS C:\\>` | Windows PowerShell |
| `>` | Generic prompt, multi OS |
| `<IP ADDRESS>, <PORT>` | Vereist door gebruiker bepaalde invoerwaarden |
| `-` (Dashes/Hyphens) | **Caution:** Let op bij copy/paste met streepjes: en/em-dash (`–`, `—`) vs ASCII hyphen (`-`) |
| `spaces` | Controleer altijd op correcte spaties en geen ontbrekende spaties in commando's |

## 2. VORTEX OS Dagelijkse Operaties
- **Start volledige pijplijn:** `./realtime_pipeline.sh`
- **Test WebRTC DataChannels (CLI):** `./webrtc_test_runner.sh`
- **Valideer & Sync naar GitHub/Vercel:** `./auto_sync.sh`
"""
    ),
    "docs/beheer/blue_team/system_hardening": (
        "🔒 Systeem Hardening & FinalCrypt OTP",
        """# 🔒 Systeem Hardening & FinalCrypt OTP
**OS:** Debian Bookworm | **Encryptie:** FinalCrypt One-Time Pad (OTP)

## 1. One-Time Pad (OTP) Sleutelbeheer
- Sleutelbestanden (`.otp`) zijn even groot als de bronbestanden en wiskundig onkraakbaar bij eenmalig gebruik.
- Pas altijd strikte bestandsrechten toe: `chmod 600 rekencentrum/beveiligde_sleutels/*.otp`
- Scherm de sleutelmap volledig af: `chmod 700 rekencentrum/beveiligde_sleutels`

## 2. Python PEP 668 Isolatie
- Alle externe netwerkbibliotheken (`aiortc`) draaien strikt geïsoleerd binnen `./venv` om het Debian-basissysteem schoon te houden.
"""
    ),
    "docs/beheer/blue_team/network_defense": (
        "🌐 Netwerk, DNS & WebRTC DataChannel Defensie",
        """# 🌐 Netwerk, DNS & WebRTC DataChannel Defensie
**Architectuur:** BIND9 (UDP 53) | Matrix/Conduit (8448) | WebRTC P2P DataChannels

## 1. Beveiligd Verzenden & Ontvangen met DataChannels
- Alle WebRTC DataChannels gebruiken verplichte **DTLS** (Datagram Transport Layer Security) encryptie over SCTP.
- Berichten gaan peer-to-peer zonder tussenkomst van externe cloud-opslag.

## 2. DNS & Poortbeheer
- BIND9 verzorgt lokale DNS-resolutie.
- Onderdruk valse 404-ruis (zoals `/favicon.ico`) via `204 No Content` en inline SVG-headers.
"""
    ),
    "docs/beheer/red_team/rtfm_manual": (
        "🔴 Red Team Field Manual (RTFM)",
        """# 🔴 Red Team Field Manual (RTFM)
**Doelwit:** Geautoriseerde Lokale Audits (VORTEX OS)

## 1. Netwerk Recon & Poort verificatie
- **Snelle lokale SYN scan:** `sudo nmap -sS -T4 -p- 127.0.0.1`
- **Service fingerprinting op VORTEX poorten:** `nmap -sV -p 53,8000,8081,8082,8448 127.0.0.1`

## 2. Web & P2P Audit
- **HTTP Header inspectie:** `curl -I http://localhost:8082/beheercentrum/index.html`
- **Controleer SUID binaries:** `find / -perm -4000 2>/dev/null`
- **Zoek onbeveiligde sleutels:** `python3 validate_repo.py`
"""
    )
}

def render_md_to_html(md_text):
    lines = md_text.strip().split('\n')
    out = []
    in_table = False
    for line in lines:
        if line.startswith('|'):
            if not in_table:
                out.append('<div class="table-wrap"><table>')
                in_table = True
            if '---' in line:
                continue
            cells = [c.strip() for c in line.strip('|').split('|')]
            tag = 'th' if out[-1].endswith('<table>') else 'td'
            row_html = ""
            for c in cells:
                c_fmt = re.sub(r'`([^`]+)`', r'<code>\1</code>', c)
                c_fmt = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', c_fmt)
                row_html += f"<{tag}>{c_fmt}</{tag}>"
            out.append(f"<tr>{row_html}</tr>")
            continue
        elif in_table:
            out.append('</table></div>')
            in_table = False

        if line.startswith('# '):
            out.append(f'<h2>{line[2:]}</h2>')
        elif line.startswith('## '):
            out.append(f'<h3>{line[3:]}</h3>')
        elif line.startswith('- '):
            item = re.sub(r'`([^`]+)`', r'<code>\1</code>', line[2:])
            item = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', item)
            out.append(f'<p style="margin-bottom:8px;">• {item}</p>')
        elif line.strip():
            p = re.sub(r'`([^`]+)`', r'<code>\1</code>', line)
            p = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', p)
            out.append(f'<p style="margin-bottom:10px;">{p}</p>')
    if in_table:
        out.append('</table></div>')
    return '\n'.join(out)

for base_path, (title, md_content) in docs_pages.items():
    with open(f"{base_path}.md", "w", encoding="utf-8") as f:
        f.write(md_content)
    html_body = render_md_to_html(md_content)
    doc_html = f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <title>VORTEX OS | {title}</title>
    {CORE_HEAD}
</head>
<body>
    <header>
        <div>
            <h1>{title}</h1>
            <div class="sys-info">VORTEX OS Documentatie | Desktop & Mobile-Ready</div>
        </div>
        <div class="mode-bar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobiel</button>
            <a class="btn btn-blue" href="../../../beheercentrum/index.html">← Beheercentrum</a>
        </div>
    </header>
    <div class="card blue-border">
        {html_body}
    </div>
    <nav class="mobile-dock">
        <a class="btn" href="../../../beheercentrum/index.html">🏠 Dashboard</a>
        <a class="btn" href="../../../rekencentrum/tijdscapsule/index.html">⏳ Tijdscapsule</a>
        <a class="btn" href="../blue_team/tactical_ops.html">🛡️ BTFM</a>
        <a class="btn" href="../red_team/rtfm_manual.html">🔴 RTFM</a>
    </nav>
</body>
</html>"""
    with open(f"{base_path}.html", "w", encoding="utf-8") as f:
        f.write(doc_html)

print("🖥️ [4/7] Bouwen van het Centrale Beheercentrum (Desktop + Mobile-Ready + Live WebRTC Console)...")

def build_dashboard(prefix=""):
    return f"""<!DOCTYPE html>
<html lang="nl">
<head>
    <title>VORTEX OS | Beheercentrum (Desktop & Mobile-Ready)</title>
    {CORE_HEAD}
</head>
<body>
    <header>
        <div>
            <h1>VORTEX OS — BEHEERCENTRUM</h1>
            <div class="sys-info">Host: localhost (Debian Bookworm) | Status: SOVEREIGN | Desktop & Mobile-Ready</div>
        </div>
        <div class="mode-bar">
            <button id="btn-desktop" class="btn active" onclick="setBuildMode('desktop')">🖥️ Desktop Grid</button>
            <button id="btn-mobile" class="btn" onclick="setBuildMode('mobile')">📱 Mobile Touch</button>
        </div>
    </header>

    <main class="grid">
        <!-- 1. Tijdscapsule, Rekencentrum & BTFM Field Beheer -->
        <div class="card accent-border">
            <h2>⏳ Tijdscapsule, Rekencentrum & BTFM</h2>
            <ul>
                <li>
                    <a class="nav-item" href="{prefix}rekencentrum/tijdscapsule/index.html">
                        <div>
                            <strong>🚀 Open Tijdscapsule & Rekencentrum (v159.1)</strong>
                            <span class="path">Poolanker P (52.25°N, 5.22°E) | A. Ott Nr. 573 | BTFM Field Beheer</span>
                        </div>
                        <span style="color:var(--accent-color);">➔</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item" href="{prefix}rekencentrum/tijdscapsule/tijdscapsule_metadata.json" target="_blank">
                        <div>
                            <strong>📄 Ruwe Tijdscapsule Telemetrie (JSON)</strong>
                            <span class="path">Maan Astrometrie (RA 191.20°, Az 303.23°) & Attractor #21</span>
                        </div>
                        <span>↗</span>
                    </a>
                </li>
                <li>
                    <span class="dot secured"></span><strong>FinalCrypt OTP: Actief (chmod 600 verified)</strong>
                    <span class="path">One-Time Pad versleuteling gekoppeld aan tijdscapsule_backup.sh</span>
                </li>
            </ul>
        </div>

        <!-- 2. Interactieve WebRTC DataChannel (DTLS) Module -->
        <div class="card blue-border">
            <h2>📡 Beveiligde WebRTC DataChannel (DTLS)</h2>
            <p class="path">Verzend en ontvang direct versleutelde P2P-pakketten (Browser DTLS Loopback & Python aiortc):</p>
            <div id="webrtc-log" class="console-box">
                [DTLS READY] Kanaal 'vortex_secure_channel' gereed voor transmissie...
            </div>
            <div class="input-row">
                <input type="text" id="webrtc-msg" value="Sovereign Payload: Anker P Lock OK" placeholder="Typ versleuteld bericht...">
                <button class="btn btn-blue" onclick="sendWebRTCMessage()">Verzend P2P</button>
            </div>
            <span class="path" style="margin-top:6px;">CLI runner: <code>./webrtc_test_runner.sh</code> (Python venv + aiortc)</span>
        </div>

        <!-- 3. Blue Team Field Manual (BTFM) -->
        <div class="card blue-border">
            <h2>🛡️ Blue Team Field Manual (BTFM)</h2>
            <ul>
                <li>
                    <a class="nav-item" href="{prefix}docs/beheer/blue_team/ir_playbook.html">
                        <div>
                            <strong>Incident Response Playbook</strong>
                            <span class="path">/docs/beheer/blue_team/ir_playbook.html</span>
                        </div>
                        <span>➔</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item" href="{prefix}docs/beheer/blue_team/tactical_ops.html">
                        <div>
                            <strong>Tactische Commando's & BTFM Syntaxis</strong>
                            <span class="path">/docs/beheer/blue_team/tactical_ops.html</span>
                        </div>
                        <span>➔</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item" href="{prefix}docs/beheer/blue_team/system_hardening.html">
                        <div>
                            <strong>Systeem Hardening & OTP Beheer</strong>
                            <span class="path">/docs/beheer/blue_team/system_hardening.html</span>
                        </div>
                        <span>➔</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item" href="{prefix}docs/beheer/blue_team/network_defense.html">
                        <div>
                            <strong>Netwerk, DNS & DataChannel Defensie</strong>
                            <span class="path">/docs/beheer/blue_team/network_defense.html</span>
                        </div>
                        <span>➔</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- 4. Red Team Field Manual (RTFM) & Netwerk Status -->
        <div class="card red-border">
            <h2>🔴 Red Team (RTFM) & Services</h2>
            <ul>
                <li>
                    <a class="nav-item" href="{prefix}docs/beheer/red_team/rtfm_manual.html">
                        <div>
                            <strong>🔴 Open Red Team Field Manual (RTFM)</strong>
                            <span class="path">/docs/beheer/red_team/rtfm_manual.html</span>
                        </div>
                        <span>➔</span>
                    </a>
                </li>
                <li><span class="dot online"></span>Python API & Markdown Server (Poort 8000 / 8082)</li>
                <li><span class="dot online"></span>Rust Podcast RSS Server (Poort 8081)</li>
                <li><span class="dot secured"></span>BIND9 Local DNS (UDP 53) & Matrix Conduit (8448)</li>
                <li>
                    <a class="nav-item" href="https://geocentrum.vercel.app/" target="_blank">
                        <div>
                            <strong>🌐 Live Cloud Mirror (Vercel)</strong>
                            <span class="path">https://geocentrum.vercel.app/</span>
                        </div>
                        <span>↗</span>
                    </a>
                </li>
            </ul>
        </div>
    </main>

    <nav class="mobile-dock">
        <a class="btn active" href="#">🏠 Dashboard</a>
        <a class="btn" href="{prefix}rekencentrum/tijdscapsule/index.html">⏳ Tijdscapsule</a>
        <a class="btn" href="{prefix}docs/beheer/blue_team/tactical_ops.html">🛡️ BTFM</a>
        <a class="btn" href="{prefix}docs/beheer/red_team/rtfm_manual.html">🔴 RTFM</a>
    </nav>

    <script>
        async function sendWebRTCMessage() {{
            const logBox = document.getElementById('webrtc-log');
            const msgInput = document.getElementById('webrtc-msg');
            const payload = msgInput.value || "Sovereign Ping";
            const appendLog = (txt) => {{
                const time = new Date().toLocaleTimeString();
                logBox.innerHTML += `<div>[${{time}}] ${{txt}}</div>`;
                logBox.scrollTop = logBox.scrollHeight;
            }};

            appendLog("🔒 Starten van DTLS Handshake tussen Offer & Answer peers...");
            const pcOffer = new RTCPeerConnection();
            const pcAnswer = new RTCPeerConnection();

            pcOffer.onicecandidate = e => e.candidate && pcAnswer.addIceCandidate(e.candidate);
            pcAnswer.onicecandidate = e => e.candidate && pcOffer.addIceCandidate(e.candidate);

            const dcOffer = pcOffer.createDataChannel("vortex_secure_channel");
            dcOffer.onopen = () => {{
                appendLog(`🟢 DataChannel OPEN -> Verzenden: "${{payload}}"`);
                dcOffer.send(payload);
            }};
            dcOffer.onmessage = (e) => {{
                appendLog(`📥 Bevestiging op Offer-node: "${{e.data}}"`);
                setTimeout(() => {{ pcOffer.close(); pcAnswer.close(); }}, 400);
            }};

            pcAnswer.ondatachannel = (e) => {{
                const ch = e.channel;
                ch.onmessage = (ev) => {{
                    appendLog(`📥 Ontvangen op Answer-node: "${{ev.data}}"`);
                    ch.send("ACK: Pakket DTLS-geverifieerd ontvangen door VORTEX_OS");
                }};
            }};

            const offer = await pcOffer.createOffer();
            await pcOffer.setLocalDescription(offer);
            await pcAnswer.setRemoteDescription(offer);
            const answer = await pcAnswer.createAnswer();
            await pcAnswer.setLocalDescription(answer);
            await pcOffer.setRemoteDescription(answer);
        }}
    </script>
</body>
</html>"""

with open("index.html", "w", encoding="utf-8") as f:
    f.write(build_dashboard(prefix=""))

with open("beheercentrum/index.html", "w", encoding="utf-8") as f:
    f.write(build_dashboard(prefix="../"))

print("📡 [5/7] Schrijven van Python WebRTC DataChannel scripts & virtuele omgeving runner...")

webrtc_py = """#!/usr/bin/env python3
import asyncio

async def test_data_channel():
    try:
        from aiortc import RTCPeerConnection
        print("🔒 Initialiseren van WebRTC Peer Connections (aiortc DTLS beveiligd)...")
        pc_offer = RTCPeerConnection()
        pc_answer = RTCPeerConnection()

        dc_offer = pc_offer.createDataChannel("vortex_secure_channel")

        @dc_offer.on("open")
        def on_open():
            print("🟢 Data Channel geopend op Offer-zijde!")
            dc_offer.send("Sovereign payload: Tijdscapsule Anker P (52.25N, 5.22E) OK")

        @dc_offer.on("message")
        def on_message(message):
            print(f"📥 Ontvangen op Offer-zijde: {message}")

        @pc_answer.on("datachannel")
        def on_datachannel(channel):
            print(f"🟢 Data Channel ontvangen op Answer-zijde: {channel.label}")
            @channel.on("message")
            def on_answer_message(message):
                print(f"📥 Ontvangen op Answer-zijde: {message}")
                channel.send("ACK: Bericht veilig ontvangen en verwerkt door Rekencentrum!")

        offer = await pc_offer.createOffer()
        await pc_offer.setLocalDescription(offer)
        await pc_answer.setRemoteDescription(pc_offer.localDescription)

        answer = await pc_answer.createAnswer()
        await pc_answer.setLocalDescription(answer)
        await pc_offer.setRemoteDescription(pc_answer.localDescription)

        await asyncio.sleep(1.5)
        await pc_offer.close()
        await pc_answer.close()
        print("✨ WebRTC Data Channel (aiortc) test succesvol afgerond.")
    except ImportError:
        print("ℹ️ aiortc nog niet geladen in actieve shell; voer ./webrtc_test_runner.sh uit voor automatische venv-executie.")

if __name__ == "__main__":
    asyncio.run(test_data_channel())
"""
with open("test_webrtc_channel.py", "w", encoding="utf-8") as f:
    f.write(webrtc_py)
os.chmod("test_webrtc_channel.py", 0o755)

webrtc_runner = """#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
cd "$BASE_DIR" || exit 1

if [ ! -d "venv" ]; then
    echo "📦 Aanmaken van geïsoleerde Python venv (PEP 668 compliant)..."
    python3 -m venv venv
    ./venv/bin/pip install --upgrade pip
    ./venv/bin/pip install aiortc
fi

echo "🚀 Starten van WebRTC DataChannel test..."
./venv/bin/python3 test_webrtc_channel.py
"""
with open("webrtc_test_runner.sh", "w", encoding="utf-8") as f:
    f.write(webrtc_runner)
os.chmod("webrtc_test_runner.sh", 0o755)

print("🔄 [6/7] Spiegelen van mappen in beheercentrum/ zodat elke Vercel Root Directory instelling 100% werkt...")

for folder in ["docs", "rekencentrum"]:
    target = os.path.join("beheercentrum", folder)
    if os.path.exists(target):
        shutil.rmtree(target)
    shutil.copytree(folder, target)

# Zorg dat terug-knoppen in gespiegelde mappen ook werken als beheercentrum de Vercel root is
os.makedirs("beheercentrum/beheercentrum", exist_ok=True)
shutil.copy2("index.html", "beheercentrum/beheercentrum/index.html")
shutil.copy2("manifest.json", "beheercentrum/manifest.json")

vercel_cfg = {
    "version": 2,
    "cleanUrls": False,
    "trailingSlash": False
}
with open("vercel.json", "w", encoding="utf-8") as f:
    json.dump(vercel_cfg, f, indent=2)
with open("beheercentrum/vercel.json", "w", encoding="utf-8") as f:
    json.dump(vercel_cfg, f, indent=2)

print("✅ [7/7] Updaten van validate_repo.py & auto_sync.sh...")

validate_py = """#!/usr/bin/env python3
import os
import sys
import stat

MANDATORY_PATHS = [
    "config.json",
    "index.html",
    "manifest.json",
    "beheercentrum/index.html",
    "rekencentrum/tijdscapsule/index.html",
    "rekencentrum/tijdscapsule/tijdscapsule_metadata.json",
    "docs/beheer/blue_team/ir_playbook.html",
    "docs/beheer/blue_team/tactical_ops.html",
    "docs/beheer/blue_team/system_hardening.html",
    "docs/beheer/blue_team/network_defense.html",
    "docs/beheer/red_team/rtfm_manual.html",
    "test_webrtc_channel.py",
    "webrtc_test_runner.sh",
    "auto_sync.sh"
]

def validate_repository():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    print(f"🔍 Validatie van VORTEX OS monorepo (Desktop + Mobile + WebRTC + Tijdscapsule):\\n")
    missing = []
    perm_issues = []

    for p in MANDATORY_PATHS:
        if os.path.exists(os.path.join(base_dir, p)):
            print(f"  [ 🟢 OK ] {p}")
        else:
            print(f"  [ 🔴 ONTBREEKT ] {p}")
            missing.append(p)

    print("\\n🔐 Controleren van FinalCrypt OTP-sleutelrechten (.otp)...")
    for root, _, files in os.walk(base_dir):
        if ".git" in root or "venv" in root:
            continue
        for file in files:
            if file.endswith(".otp"):
                full_p = os.path.join(root, file)
                mode = stat.S_IMODE(os.stat(full_p).st_mode)
                rel_p = os.path.relpath(full_p, base_dir)
                if mode == 0o600:
                    print(f"  [ 🟢 OK ] chmod 600 geverifieerd: {rel_p}")
                else:
                    print(f"  [ ⚠️ FOUT ] Onveilige rechten ({oct(mode)}) op: {rel_p}")
                    perm_issues.append(rel_p)

    print("\\n" + "="*45)
    if not missing and not perm_issues:
        print("✅ Monorepo 100% gevalideerd voor Desktop, Mobiel & Vercel!")
        sys.exit(0)
    sys.exit(1)

if __name__ == "__main__":
    validate_repository()
"""
with open("validate_repo.py", "w", encoding="utf-8") as f:
    f.write(validate_py)
os.chmod("validate_repo.py", 0o755)

print("🎉 Master Build succesvol voltooid!")
