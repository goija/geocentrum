cat << 'EOF' > ~/Bureaublad/geocentrum/vortex_fundamentele_ordening_v155.html
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX // DASHBOARD FUNDAMENTELE ORDENING v155.0 — 8 Geocentrum Assets, Multi-As & Ott Nr. 573</title>
    <!-- Laadt automatisch jouw gegenereerde ./assets/assets_manifest.js -->
    <script src="assets/assets_manifest.js" onerror="window.VORTEX_ASSETS_MANIFEST = [];"></script>
    <style>
        :root {
            --bg: #050608;
            --panel: #0a0d11;
            --border: #1a2228;
            --main: #00ffcc;
            --mg-glow: #50ffb0;      /* Fraunhofer Mg-b Triplet (517.3 nm) */
            --mg-white: #e6fff7;
            --neg-glow: #ff3385;     /* Antipodale Negatieve Pariteit */
            --ai-glow: #00a2ff;
            --accent: #ff9900;
            --gold: #ffcc33;
            --purple: #a855f7;
            --brass: #d4af37;
            --danger: #ef4444;
            --text: #cbd5e1;
            --grid-fine: rgba(0, 210, 255, 0.12);
            --grid-major: rgba(0, 210, 255, 0.28);
            --font-mono: 'Fira Code', 'Courier New', monospace;
        }

        * { box-sizing: border-box; }
        ::-webkit-scrollbar { width: 4px; height: 4px; }
        ::-webkit-scrollbar-thumb { background: var(--ai-glow); border-radius: 10px; }

        body {
            margin: 0; padding: 0; height: 100vh;
            background: var(--bg); color: var(--text);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            overflow: hidden; user-select: none;
        }

        header {
            height: 44px; border-bottom: 1px solid var(--border); background: var(--panel);
            display: flex; align-items: center; padding: 0 18px; justify-content: space-between;
            box-shadow: 0 2px 15px rgba(0,0,0,0.5); z-index: 30; position: relative;
        }

        main {
            display: grid; height: calc(100vh - 44px); gap: 1px; background: var(--border);
            grid-template-columns: 27vw 21vw 52vw;
        }

        @media (max-width: 1200px) {
            main { grid-template-columns: 38vw 62vw; }
            .column:nth-child(2) { display: none; }
        }

        .column { background: var(--bg); display: flex; flex-direction: column; overflow: hidden; }
        .col-header {
            padding: 8px 12px; font-size: 0.62rem; font-weight: bold; text-transform: uppercase;
            border-bottom: 1px solid var(--border); background: rgba(0,0,0,0.55); letter-spacing: 1.3px;
            color: var(--ai-glow); display: flex; justify-content: space-between; align-items: center;
        }

        .left-scroll { flex: 1; overflow-y: auto; padding: 7px; display: flex; flex-direction: column; gap: 6px; }

        .hud-box {
            background: rgba(10, 16, 28, 0.92); border: 1px solid var(--border);
            border-radius: 4px; padding: 7px 9px; font-family: var(--font-mono); font-size: 0.6rem;
        }
        .hud-title {
            color: var(--gold); font-size: 0.6rem; font-weight: bold; text-transform: uppercase;
            border-bottom: 1px solid rgba(255, 204, 51, 0.25); padding-bottom: 3px; margin-bottom: 5px;
            letter-spacing: 0.6px; display: flex; justify-content: space-between; align-items: center;
        }
        .kv { display: flex; justify-content: space-between; margin: 2px 0; }
        .kv span:first-child { color: #94a3b8; }
        .kv span:last-child { color: var(--main); font-weight: bold; }

        /* Fundamentele Ordening Kaarten voor de 8 Assets */
        .order-card {
            background: rgba(6, 12, 24, 0.85); border: 1px solid #1e3a5f; border-left: 3px solid var(--ai-glow);
            border-radius: 3px; padding: 5px 7px; margin-bottom: 4px; cursor: pointer; transition: 0.15s;
        }
        .order-card:hover { background: rgba(0, 255, 204, 0.08); border-color: var(--main); }
        .order-card.active { background: rgba(80, 255, 176, 0.12); border-color: var(--mg-glow); border-left: 4px solid var(--gold); }
        .order-card-top { display: flex; justify-content: space-between; font-weight: bold; font-size: 0.59rem; color: #fff; }
        .order-card-sub { display: flex; justify-content: space-between; font-size: 0.54rem; color: #94a3b8; margin-top: 2px; }
        .order-law-badge {
            display: inline-block; padding: 1px 4px; border-radius: 2px; font-size: 0.52rem;
            background: rgba(255, 204, 51, 0.15); color: var(--gold); border: 1px solid rgba(255, 204, 51, 0.4);
        }

        .wheel-ctrl-row {
            background: rgba(4, 9, 18, 0.7); border: 1px solid #1e293b; border-radius: 3px;
            padding: 4px 6px; margin-bottom: 4px;
        }
        .wheel-ctrl-head {
            display: flex; justify-content: space-between; font-size: 0.57rem; font-weight: bold; margin-bottom: 2px;
        }
        .dual-sliders { display: grid; grid-template-columns: 1fr 1fr; gap: 6px; align-items: center; }
        .mini-lbl { font-size: 0.53rem; color: #94a3b8; display: flex; justify-content: space-between; }

        .btn-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 4px; margin-top: 4px; }
        .btn-grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 4px; margin-top: 4px; }
        .btn {
            background: #101c30; color: var(--text); border: 1px solid #233b63;
            border-radius: 3px; padding: 4.5px 5px; font-size: 0.56rem; font-family: var(--font-mono);
            cursor: pointer; transition: 0.14s; text-align: center; font-weight: bold;
        }
        .btn:hover { border-color: var(--main); color: #fff; background: #162a4a; }
        .btn-home { background: rgba(255, 204, 51, 0.18); border-color: var(--gold); color: var(--gold); }
        .btn-stop { background: rgba(239, 68, 68, 0.22); border-color: #ef4444; color: #fca5a5; }
        .btn-start { background: rgba(16, 185, 129, 0.22); border-color: #10b981; color: #6ee7b7; }
        .btn-neg { background: rgba(255, 51, 133, 0.22); border-color: var(--neg-glow); color: #ff99c2; }
        .btn-mg {
            background: rgba(80, 255, 176, 0.16); border-color: var(--mg-glow); color: var(--mg-white);
            box-shadow: inset 0 0 8px rgba(80, 255, 176, 0.25);
        }

        .chk-row { display: flex; align-items: center; gap: 6px; margin: 2px 0; cursor: pointer; font-size: 0.58rem; }
        .chk-row input { accent-color: var(--main); cursor: pointer; margin: 0; }

        .hex-box {
            display: flex; justify-content: space-around; text-align: center;
            margin-top: 5px; padding-top: 4px; border-top: 1px dashed var(--border);
        }
        .bit-bar { width: 22px; height: 3.5px; margin: 2px auto; background: var(--gold); }
        .bit-0 {
            background: linear-gradient(90deg, var(--gold) 0%, var(--gold) 40%, transparent 40%, transparent 60%, var(--gold) 60%, var(--gold) 100%);
        }

        /* Column 2: AI Synth & Fundamentele Ordening Analyse */
        .ai-engine { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
        .ai-terminal { flex: 1; overflow-y: auto; padding: 10px; font-size: 0.69rem; line-height: 1.48; font-family: var(--font-mono); }
        .ai-response {
            margin-bottom: 8px; padding: 8px 9px; border: 1px solid rgba(0, 162, 255, 0.22);
            background: rgba(0, 162, 255, 0.04); border-radius: 4px;
        }
        .input-bar { padding: 9px 10px; background: #000; border-top: 1px solid var(--border); display: flex; gap: 8px; align-items: center; }
        .v-input { flex: 1; background: transparent; border: none; color: var(--main); font-family: var(--font-mono); outline: none; font-size: 0.72rem; }

        /* Column 3: Omni-Bridge Viewport */
        .viewport-frame { flex: 1; background: #04070d; position: relative; display: flex; flex-direction: column; overflow: hidden; }
        #svg-stage {
            flex: 1; width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;
            overflow: hidden; position: relative; perspective: 1200px;
            background: radial-gradient(circle at center, #101a2e 0%, #050811 100%);
        }
        #geo-svg {
            width: 100%; height: 100%; max-width: 100%; max-height: 100%;
            cursor: crosshair; transition: transform 0.06s ease-out;
        }

        .viewport-hud-overlay {
            position: absolute; top: 10px; left: 12px; pointer-events: none;
            font-family: var(--font-mono); font-size: 0.61rem; color: var(--main);
            background: rgba(5, 8, 15, 0.88); border: 1px solid var(--border);
            padding: 7px 10px; border-radius: 4px; line-height: 1.42; z-index: 5;
        }

        .viewport-QuickActions {
            position: absolute; top: 10px; right: 12px; display: flex; gap: 4px; z-index: 6; flex-wrap: wrap;
        }

        /* ZWEVEND VENSTER MET FUNDAMENTELE ORDENING & PLANO-ARM RESULTATEN */
        #plano-results-window {
            position: absolute;
            top: 44px;
            right: 12px;
            width: 390px;
            background: rgba(5, 11, 20, 0.95);
            backdrop-filter: blur(12px);
            border: 1px solid var(--mg-glow);
            border-radius: 6px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.88), 0 0 16px rgba(80, 255, 176, 0.16);
            font-family: var(--font-mono);
            font-size: 0.59rem;
            color: var(--text);
            z-index: 15;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: height 0.2s ease;
        }
        #plano-results-window.minimized { height: 29px !important; }
        .win-header {
            background: linear-gradient(90deg, rgba(80, 255, 176, 0.22), rgba(0, 162, 255, 0.15));
            border-bottom: 1px solid rgba(80, 255, 176, 0.45);
            padding: 6px 10px; font-weight: bold; color: var(--mg-white);
            display: flex; justify-content: space-between; align-items: center;
            cursor: move; letter-spacing: 0.5px;
        }
        .win-body {
            padding: 7px 9px; overflow-y: auto; max-height: 68vh;
            display: flex; flex-direction: column; gap: 5px;
        }
        .win-section {
            background: rgba(11, 19, 33, 0.9); border: 1px solid #1e3a5f;
            border-radius: 4px; padding: 5px 7px;
        }
        .win-sec-title {
            color: var(--mg-glow); font-size: 0.58rem; font-weight: bold; text-transform: uppercase;
            margin-bottom: 3px; border-bottom: 1px solid rgba(80, 255, 176, 0.2);
            padding-bottom: 2px; display: flex; justify-content: space-between;
        }

        .parity-bar-bg {
            width: 100%; height: 5px; background: #0f172a; border-radius: 3px;
            overflow: hidden; margin-top: 3px; border: 1px solid #334155;
        }
        .parity-bar-fill {
            height: 100%; background: linear-gradient(90deg, var(--neg-glow), var(--mg-glow));
            width: 100%; transition: width 0.08s;
        }

        .trace-table-wrap {
            max-height: 85px; overflow-y: auto; border: 1px solid #1e293b;
            border-radius: 3px; background: #040810;
        }
        table.trace-table { width: 100%; border-collapse: collapse; font-size: 0.54rem; text-align: right; }
        table.trace-table th {
            position: sticky; top: 0; background: #0f1d33; color: var(--gold);
            padding: 2px 4px; border-bottom: 1px solid #2b4c7e; text-align: right;
        }
        table.trace-table th:first-child, table.trace-table td:first-child { text-align: left; }
        table.trace-table td { padding: 2px 4px; border-bottom: 1px solid rgba(255,255,255,0.05); color: #e2e8f0; }
        table.trace-table tr:hover { background: rgba(80, 255, 176, 0.12); cursor: pointer; }

        .key-bar {
            position: absolute; bottom: 7px; left: 50%; transform: translateX(-50%);
            display: flex; gap: 4px; align-items: center; z-index: 10;
            background: rgba(5, 8, 15, 0.93); border: 1px solid var(--border);
            padding: 4px 8px; border-radius: 6px; font-family: var(--font-mono); font-size: 0.55rem;
            white-space: nowrap;
        }
        .kbd-key {
            display: inline-flex; align-items: center; justify-content: center;
            min-width: 21px; height: 20px; padding: 0 5px;
            background: #0f172a; border: 1px solid #334155; border-bottom: 2px solid #475569;
            border-radius: 4px; color: #e2e8f0; font-weight: bold; font-size: 0.54rem;
            cursor: pointer; transition: 0.08s;
        }
        .kbd-key:hover { border-color: var(--main); color: var(--main); }
        .kbd-key.pressed { background: var(--main); color: #000; border-color: #fff; transform: translateY(1px); }
        .kbd-key.stop-active { background: var(--danger); color: #fff; border-color: #fca5a5; }
        .kbd-key.run-active { background: #10b981; color: #000; border-color: #a7f3d0; }
        .kbd-key.mg-active { background: var(--mg-glow); color: #000; border-color: #ffffff; }
        .kbd-key.neg-active { background: var(--neg-glow); color: #fff; border-color: #ffc2dd; }

        .cockpit-controls {
            padding: 8px 14px; background: rgba(10, 13, 17, 0.96);
            border-top: 1px solid var(--border);
            display: grid; grid-template-columns: 1fr 1fr 1.15fr 1fr; gap: 12px;
        }
        .slider-box { display: flex; flex-direction: column; gap: 3px; }
        .slider-info { display: flex; justify-content: space-between; font-size: 0.55rem; color: var(--main); font-family: var(--font-mono); }
        input[type="range"] { width: 100%; accent-color: var(--main); height: 4px; cursor: pointer; }
    </style>
</head>
<body>

<header>
    <div style="font-weight: bold; letter-spacing: 1px;">
        VORTEX <span style="color:var(--main)">FUNDAMENTELE_ORDENING</span>
        <span style="color:var(--mg-glow); font-size: 0.63rem;">v155.0 // 8 GEOCENTRUM ASSETS MATRIX (64³ | 5625 | √3 | R=355px)</span>
    </div>
    <div style="display:flex; gap:8px; align-items:center;">
        <span id="asset-badge" style="font-family:var(--font-mono); font-size:0.6rem; padding:2px 7px; border:1px solid var(--gold); color:var(--gold); border-radius:3px;">ORDENING: 5 TRAP-PIRAMIDE (8 FILES)</span>
        <span id="origin-badge" style="font-family:var(--font-mono); font-size:0.6rem; padding:2px 7px; border:1px solid var(--mg-glow); color:var(--mg-glow); border-radius:3px;">AS-PROJECTIE: +1.00</span>
        <span id="arm-badge" style="font-family:var(--font-mono); font-size:0.6rem; padding:2px 7px; border:1px solid var(--main); color:var(--main); border-radius:3px;">BEGINSTAND: 0.0° [0]</span>
        <div id="clock" style="font-family: var(--font-mono); color: var(--main); font-size: 0.74rem;">00:00:00</div>
    </div>
</header>

<main>
    <!-- KOLOM 1: FUNDAMENTELE ORDENING VAN DE 8 BESTANDEN, OORSPRONG-INVERSIE & WIELEN -->
    <section class="column">
        <div class="col-header">
            <span>Fundamentele Ordening (8 Assets)</span>
            <span style="color:var(--gold)">Ott Nr. 573</span>
        </div>
        <div class="left-scroll">

            <!-- 1. FUNDAMENTELE ORDENING MATRIX (GESORTEERD OP HARMONISCHE SCHAAL-HIËRARCHIE) -->
            <div class="hud-box" style="border-color: var(--gold);">
                <div class="hud-title">
                    <span>🏛️ Fundamentele Ordening (Van Kern → 64³)</span>
                    <span style="color:var(--mg-glow); cursor:pointer;" onclick="toggleFootprintPyramid()" title="Toon/Verberg alle 8 kaders tegelijk [F]">[Piramide F]</span>
                </div>
                <div id="fundamental-order-list"></div>

                <div class="dual-sliders" style="margin-top:5px; padding-top:4px; border-top:1px dashed var(--border);">
                    <div>
                        <div class="mini-lbl"><span>Overlay Schaal</span><span id="lbl-img-scale">Pas Cirkel</span></div>
                        <input type="range" min="15" max="150" value="42" id="sl-img-scale" oninput="updateActiveAssetOverlay()">
                    </div>
                    <div>
                        <div class="mini-lbl"><span>Overlay Dekking</span><span id="lbl-img-op">65%</span></div>
                        <input type="range" min="0" max="100" value="65" id="sl-img-op" oninput="updateActiveAssetOverlay()">
                    </div>
                </div>
                <div class="btn-grid">
                    <button class="btn btn-home" onclick="fitAssetToKompasCircle()">📐 Pas op 363cm² Cirkel [B]</button>
                    <button class="btn btn-start" onclick="setTrue1to1Scale()">📏 Echte 1:1 Schaal (40px/cm)</button>
                </div>
            </div>

            <!-- 2. BEGINSTAND OP DE CIRKELS & PLAT NAAR NEGATIEF DOOR DE OORSPRONG -->
            <div class="hud-box" style="border-color: var(--mg-glow);">
                <div class="hud-title" style="color:var(--mg-glow);">
                    <span>🎯 Beginstand & Wiel door Oorsprong (0,0)</span>
                    <span id="lbl-sigma-state" style="color:var(--gold)">σ = +1.00</span>
                </div>
                <div class="btn-grid">
                    <button class="btn btn-home" onclick="resetToBeginstand()">🎯 Beginstand Cirkels [0]</button>
                    <button class="btn btn-neg" id="btn-fold-anim" onclick="toggleOriginFoldAnimation()">🌀 Vouw door (0,0) [X]</button>
                </div>
                <div class="btn-grid-3">
                    <button class="btn btn-start" onclick="setGlobalAxisFlatten(1.0)">➕ Positief [7]</button>
                    <button class="btn btn-home" onclick="setGlobalAxisFlatten(0.0)">➖ Plat (0,0) [8]</button>
                    <button class="btn btn-neg" onclick="setGlobalAxisFlatten(-1.0)">🔄 Negatief [9]</button>
                </div>
                <div style="margin-top:4px;">
                    <div class="mini-lbl">
                        <span>Globale Wiel-As Kanteling Door Oorsprong (σ_Y: [-] / [+])</span>
                        <span id="lbl-global-sigma" style="color:var(--gold)">+1.00 (Rond)</span>
                    </div>
                    <input type="range" min="-1" max="1" step="0.01" value="1" id="slider-global-sigma" oninput="setGlobalAxisFlatten(this.value)">
                </div>
            </div>

            <!-- 3. ONAFHANKELIJK DRAAIENDE WIELEN IN VERSCHILLENDE ASSEN -->
            <div class="hud-box" style="border-color: var(--ai-glow);">
                <div class="hud-title" style="color:var(--ai-glow);">
                    <span>⚙️ Onafhankelijke Wielen & Assen</span>
                    <span style="cursor:pointer; color:var(--gold);" onclick="syncAllWheelsToZero()">[Sync 0°]</span>
                </div>

                <div class="wheel-ctrl-row">
                    <div class="wheel-ctrl-head" style="color:var(--main);">
                        <span>1. I Ching Buitenwiel (64) [Q / E]</span>
                        <span id="lbl-w64">Draai: 0.0° | As: +1.00</span>
                    </div>
                    <div class="dual-sliders">
                        <div>
                            <div class="mini-lbl"><span>Rotatie φ_64</span><span>0..360°</span></div>
                            <input type="range" min="0" max="360" step="0.5" value="0" id="sl-rot-64" oninput="setWheelParam(64, 'rot', this.value)">
                        </div>
                        <div>
                            <div class="mini-lbl"><span>As-Kanteling σ_64</span><span>-1..+1</span></div>
                            <input type="range" min="-1" max="1" step="0.02" value="1" id="sl-tilt-64" oninput="setWheelParam(64, 'tilt', this.value)">
                        </div>
                    </div>
                </div>

                <div class="wheel-ctrl-row">
                    <div class="wheel-ctrl-head" style="color:var(--purple);">
                        <span>2. Jiazi Middenwiel (60 | R=355px) [Z / C]</span>
                        <span id="lbl-w60">Draai: 0.0° | As: +1.00</span>
                    </div>
                    <div class="dual-sliders">
                        <div>
                            <div class="mini-lbl"><span>Rotatie φ_60</span><span>0..360°</span></div>
                            <input type="range" min="0" max="360" step="0.5" value="0" id="sl-rot-60" oninput="setWheelParam(60, 'rot', this.value)">
                        </div>
                        <div>
                            <div class="mini-lbl"><span>As-Kanteling σ_60</span><span>-1..+1</span></div>
                            <input type="range" min="-1" max="1" step="0.02" value="1" id="sl-tilt-60" oninput="setWheelParam(60, 'tilt', this.value)">
                        </div>
                    </div>
                </div>

                <div class="wheel-ctrl-row" style="margin-bottom:0;">
                    <div class="wheel-ctrl-head" style="color:var(--gold);">
                        <span>3. Binnenwiel 16 & N² Kern [U / I]</span>
                        <span id="lbl-w16">Draai: 0.0° | As: +1.00</span>
                    </div>
                    <div class="dual-sliders">
                        <div>
                            <div class="mini-lbl"><span>Rotatie φ_16</span><span>0..360°</span></div>
                            <input type="range" min="0" max="360" step="0.5" value="0" id="sl-rot-16" oninput="setWheelParam(16, 'rot', this.value)">
                        </div>
                        <div>
                            <div class="mini-lbl"><span>As-Kanteling σ_16</span><span>-1..+1</span></div>
                            <input type="range" min="-1" max="1" step="0.02" value="1" id="sl-tilt-16" oninput="setWheelParam(16, 'tilt', this.value)">
                        </div>
                    </div>
                </div>
            </div>

            <!-- 4. MAGNESIUM OVERTREK CONTROLE -->
            <div class="hud-box">
                <div class="hud-title" style="color:var(--mg-glow);">
                    <span>✨ Magnesium Overtrek & Piramide</span>
                    <span id="lbl-mg-status">ACTIEF [K]</span>
                </div>
                <div class="btn-grid">
                    <button class="btn btn-mg" id="btn-rec" onclick="toggleOmtrekRecording()">✏️ START OVERTREK [O]</button>
                    <button class="btn btn-mg" onclick="stampMagnesiumPoint()">📌 STEMPEL PUNT [T]</button>
                    <button class="btn" onclick="toggleResultsWindow()">📊 ARM-VENSTER [V]</button>
                    <button class="btn" onclick="clearOmtrek()">🗑️ WIS OVERTREK [C]</button>
                </div>
                <div style="margin-top:4px;">
                    <label class="chk-row"><input type="checkbox" id="chk-pyramid" checked onchange="renderConcentricPyramid()"> Toon 8-Assets Concentrische Piramide-Kaders [F]</label>
                    <label class="chk-row"><input type="checkbox" id="chk-adapt-trace" checked onchange="renderMagnesiumOvertrek()"> Pas Overtrek & Kaders aan op Oorsprong-Inversie (σ)</label>
                </div>
            </div>
        </div>
    </section>

    <!-- KOLOM 2: AI SYNTHESIS TERMINAL MET DE 5 WETTEN VAN FUNDAMENTELE ORDENING -->
    <section class="column" style="border-left: 1px solid var(--border); border-right: 1px solid var(--border);">
        <div class="col-header">
            <span>Fundamentele Ordening Analyse</span>
            <span id="ai-status" style="color:var(--gold)">5 WETTEN // ONTDEKT</span>
        </div>
        <div class="ai-engine">
            <div class="ai-terminal" id="ai-terminal">
                <div class="ai-response" style="border-color:var(--gold); background:rgba(255,204,51,0.05);">
                    <b style="color:var(--gold)">🏛️ SYNTHESE FUNDAMENTELE ORDENING (8 BESTANDEN):</b><br><br>
                    <b>1. De Mechanische Sleutel (<code>vizierkerf.png</code> — 671×355 px):</b><br>
                    • Hoogte = <b>355 px (8,875 cm)</b> = exact <code>R_JIAZI_PX</code> (straal van het 60-Jiazi wiel) én de teller van $\pi \approx \frac{355}{113}$!<br>
                    • Breedte = <b>671 px (16,78 cm / 33,5 vakjes)</b> = exact de lengte van de <b>Ott Nr. 573 Rijarm ($L_{\text{rij}}$)</b>!<br><br>
                    <b>2. De Shao Yong Hoek-Matrix (<code>cellarius-v3</code> — 1500×1500 px):</b><br>
                    • Meet <b>75,0 × 75,0 = 5625 vakjes</b> van 0,5 cm.<br>
                    • $360^\circ / 64 = $ <b>$5{,}625^\circ$</b> per I Ching hexagram! Het aantal vakjes ($5625$) is exact $1000 \times \Delta\theta_{64}$.<br><br>
                    <b>3. De $64^3$ Binaire Hyperkubus (<code>cellarius-v4</code> & <code>nebra-pleiaden</code> — 2048×2048 px):</b><br>
                    • Oppervlakte = <b>2621,44 cm² (26.214,4 nonius)</b>.<br>
                    • $262.144 = $ <b>$64^3 = (2^6)^3$</b> (3D Shao Yong kubus!).<br><br>
                    <b>4. De $\sqrt{3}$ Vesica-Horizon (<code>cellarius-oost-v5</code> — 1950×1125 px):</b><br>
                    • Hoogte = <b>56,25 vakjes</b> ($10 \times 5{,}625^\circ$).<br>
                    • Ratio $1950 / 1125 = 26 / 15 = 1{,}7333 \approx $ <b>$\sqrt{3} = \tan 60^\circ$</b>.<br><br>
                    <b>5. De 60-Jiazi Spiegel (<code>breda-v8</code> — 2048×1195 px):</b><br>
                    • Hoogte = <b>59,8 $\approx$ 60 vakjes</b> (1 Jiazi-cyclus) $\times$ 102,4 vakjes breed.
                </div>
            </div>
            <div class="input-bar">
                <span style="color:var(--mg-glow); font-family:var(--font-mono);">></span>
                <input type="text" class="v-input" id="ai-query" placeholder="Klik op een van de 8 bestanden links of typ 'sleutel', '64', 'plat'..." onkeypress="handleQuery(event)">
            </div>
        </div>
    </section>

    <!-- KOLOM 3: OMNI-BRIDGE VIEWPORT [PIRAMIDE FOOTPRINT + MULTI-AS WIELEN + OTT NR. 573] -->
    <section class="column">
        <div class="col-header">
            <span>Omni-Bridge Viewport [FUNDAMENTELE ORDENING PIRAMIDE & OTT NR. 573]</span>
            <span id="hud-coord-mini" style="color:var(--mg-glow); font-family:var(--font-mono);">[T: 0.00, +10.75 cm | ρ: +10.75 cm]</span>
        </div>
        <div class="viewport-frame">
            <div id="svg-stage">
                <!-- Live Mini-Overlay linksboven in de Viewport -->
                <div class="viewport-hud-overlay">
                    <div>ACTIEVE ORDENING-LAAG: <b id="vp-asset-info" style="color:var(--gold)">vizierkerf.png (671×355px | R_Jiazi=355px)</b></div>
                    <div>HARMONISCHE WET: <b id="vp-law-info" style="color:var(--mg-glow)">H=355px (R_Jiazi) × B=671px (L_rij Ott 573)</b></div>
                    <div>OTT NR. 573 NONIUS: <b id="vp-nonius" style="color:var(--gold)">+3630</b> (Cirkel: <b id="vp-area">+363.0 cm²</b>)</div>
                    <div>VOLGSTIFT T(θ, ρ): <b id="vp-az">0.00°</b> | ρ = <b id="vp-rho">+10.75 cm</b></div>
                </div>

                <!-- Quick Actions rechtsboven in de Viewport -->
                <div class="viewport-QuickActions">
                    <button class="btn btn-home" onclick="resetToBeginstand()" title="Zet Arm & Wielen in Beginstand op de Cirkels (0)">🎯 Beginstand [0]</button>
                    <button class="btn" onclick="setGlobalAxisFlatten(0.0)" title="Druk Wiel Helemaal Plat op Oorsprong-as (8)">➖ Plat [8]</button>
                    <button class="btn btn-neg" onclick="setGlobalAxisFlatten(-1.0)" title="Klap Wiel door Oorsprong naar Negatief (9)">🔄 Negatief [9]</button>
                    <button class="btn btn-mg" onclick="stampMagnesiumPoint()" title="Stempel Punt op Magnesium Overtrek (T)">📌 Stempel [T]</button>
                    <button class="btn btn-mg" onclick="toggleResultsWindow()" title="Toon/Verberg Resultaten Venster (V)">📊 Venster [V]</button>
                </div>

                <!-- ====================================================================================== -->
                <!-- ZWEVEND VENSTER MET RESULTATEN VAN DE FUNDAMENTELE ORDENING & PLANIMETER-ARM           -->
                <!-- ====================================================================================== -->
                <div id="plano-results-window">
                    <div class="win-header" id="win-drag-handle">
                        <span>📐 FUNDAMENTELE ORDENING & PLANO-ARM TELEMETRIE</span>
                        <div style="display:flex; gap:6px;">
                            <span style="cursor:pointer; color:var(--gold);" onclick="minimizeResultsWindow()">[_]</span>
                            <span style="cursor:pointer; color:#fca5a5;" onclick="toggleResultsWindow()">[X]</span>
                        </div>
                    </div>
                    <div class="win-body">
                        <!-- Sectie 0: Fundamentele Ordening van het Geselecteerde Bestand -->
                        <div class="win-section" style="border-color: var(--gold);">
                            <div class="win-sec-title" style="color:var(--gold);">
                                <span>0. Fundamentele Ordening (./assets/images/)</span>
                                <span id="res-asset-rank" style="color:var(--mg-glow)">TRAP 1 / 5</span>
                            </div>
                            <div class="kv"><span>Bestand (URL):</span><span id="res-asset-url">assets/images/vizierkerf.png</span></div>
                            <div class="kv"><span>Pixels & Centimeters (1:1):</span><span id="res-asset-dim">671×355 px | 16.8×8.9 cm</span></div>
                            <div class="kv"><span>0,5 cm Whiteboard-Vakjes:</span><span id="res-asset-vakjes">33.5 × 17.8 vak (596.3 vak²)</span></div>
                            <div class="kv"><span>Oppervlakte & Ott Nonius:</span><span id="res-asset-area" style="color:var(--gold)">148.9 cm² | 1489 nonius (41.0% v. 363)</span></div>
                            <div class="kv"><span>Harmonische Verhouding (B:H):</span><span id="res-asset-ratio" style="color:var(--mg-glow)">1.8901 (L_rij : R_Jiazi = 671:355)</span></div>
                            <div class="kv"><span>Shao Yong (64) / Jiazi (60):</span><span id="res-asset-sectors">26.25 SY-sectoren | 24.61 Jiazi</span></div>
                        </div>

                        <!-- Sectie 1: Arm Draai, Coördinaten & Oorsprong-Inversie -->
                        <div class="win-section">
                            <div class="win-sec-title">
                                <span>1. Planimeter-Arm Draai & Coördinaten</span>
                                <span id="res-arm-state" style="color:var(--gold)">BEGINSTAND [0]</span>
                            </div>
                            <div class="kv"><span>Arm Draaihoek (Azimut θ):</span><span id="res-arm-az">0.00° (Noord-Cirkel)</span></div>
                            <div class="kv"><span>Geprojecteerde Straal (ρ_eff):</span><span id="res-arm-rho">+10.75 cm (+21.5 vakjes)</span></div>
                            <div class="kv"><span>Volgstift Coördinaten T(x, y):</span><span id="res-tx-ty">[0.00, +10.75] cm</span></div>
                            <div class="kv"><span>Scharnier Coördinaten G(x, y):</span><span id="res-gx-gy">[-3.48, +6.65] cm</span></div>
                            <div class="kv"><span>Poolarm (α) / Rijarm (β) / ∠γ:</span><span id="res-angles">α=195° | β=72° | γ=117.4°</span></div>
                            <div class="kv"><span>Oorsprong-Projectie (σ_Y / det J):</span><span id="res-jacobian" style="color:var(--mg-glow)">+1.00 (Normaal)</span></div>
                            <div class="parity-bar-bg">
                                <div class="parity-bar-fill" id="res-parity-bar" style="width:100%"></div>
                            </div>
                        </div>

                        <!-- Sectie 2: Onafhankelijke I Ching (64) & Binnenwielen (60 / 16 / N²) Resultaten -->
                        <div class="win-section">
                            <div class="win-sec-title">
                                <span>2. I Ching (64) & Onafhankelijke Binnenwielen</span>
                                <span id="res-chirality-badge" style="color:var(--main)">CHIRALITEIT: +</span>
                            </div>
                            <div class="kv"><span>I Ching Buitenwiel (64) [φ64]:</span><span id="res-iching-wheel">#0 (111111) @ Δθ=0.0°</span></div>
                            <div class="kv"><span>Oorsprong-Inversie Hexagram (H̄):</span><span id="res-iching-inv" style="color:var(--neg-glow)">#32 (000000) [Antipode]</span></div>
                            <div class="kv"><span>Jiazi Middenwiel (60) [φ60]:</span><span id="res-jiazi-wheel">Jia-Zi (#1/60) @ φ=0.0°</span></div>
                            <div class="kv"><span>Binnenwiel (16) & N² Kern [φ16]:</span><span id="res-inner-wheel">Noord-Ster #0 | Kern 11→N²=111111</span></div>

                            <div class="hex-box">
                                <div>
                                    <div style="color:#94a3b8;font-size:0.52rem;">H (Actief Wiel)</div>
                                    <div id="vis-H"></div>
                                    <div id="lbl-H" style="margin-top:2px;color:var(--main);">111111</div>
                                </div>
                                <div>
                                    <div style="color:#94a3b8;font-size:0.52rem;">N (Hu Gua)</div>
                                    <div id="vis-N"></div>
                                    <div id="lbl-N" style="margin-top:2px;color:var(--gold);">111111</div>
                                </div>
                                <div>
                                    <div style="color:#94a3b8;font-size:0.52rem;">N² / Inversie</div>
                                    <div id="vis-N2"></div>
                                    <div id="lbl-N2" style="margin-top:2px;color:var(--neg-glow);">111111</div>
                                </div>
                            </div>
                        </div>

                        <!-- Sectie 3: Magnesium Overtrek Integratie & Meetpunten Logboek -->
                        <div class="win-section">
                            <div class="win-sec-title">
                                <span>3. Magnesium Overtrek & Nonius Resultaat</span>
                                <span id="res-nonius-badge" style="color:var(--gold)">+3630 nonius</span>
                            </div>
                            <div class="kv"><span>Getekende Cirkel-Nonius (σ·A):</span><span id="res-sector-area">+363.00 cm² (+1452 vakjes)</span></div>
                            <div class="kv"><span>Overtrokken Pad & Vlak:</span><span id="res-poly-area" style="color:var(--mg-glow)">0.00 cm | 0.00 cm² (0 vakjes)</span></div>

                            <div class="trace-table-wrap" style="margin-top:4px;">
                                <table class="trace-table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>T(x,y) cm</th>
                                            <th>Draai θ</th>
                                            <th>As σ</th>
                                            <th>Nonius</th>
                                            <th>I Ching</th>
                                        </tr>
                                    </thead>
                                    <tbody id="res-trace-tbody">
                                        <tr><td colspan="6" style="text-align:center; color:#64748b; padding:6px;">Druk op [T] (Stempel) of klik op een van de 8 bestanden links.</td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="btn-grid" style="margin-top:4px;">
                                <button class="btn btn-mg" onclick="stampMagnesiumPoint()">📌 Stempel Punt [T]</button>
                                <button class="btn" onclick="exportCADReport()">📥 Export Ordening (TXT)</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Interactieve Toetsenbord-Balk onderin de Viewport -->
                <div class="key-bar">
                    <span class="kbd-key" id="key-0" onclick="resetToBeginstand()" title="Beginstand op Cirkels (0)">0:BEGIN</span>
                    <span class="kbd-key" id="key-left" onclick="stepPolar(-1, 0)" title="Arm Draai Links (←)">←</span>
                    <span class="kbd-key" id="key-up" onclick="stepPolar(0, 0.5)" title="Straal +0.5cm (↑)">↑</span>
                    <span class="kbd-key" id="key-down" onclick="stepPolar(0, -0.5)" title="Straal -0.5cm door Oorsprong (↓)">↓</span>
                    <span class="kbd-key" id="key-right" onclick="stepPolar(1, 0)" title="Arm Draai Rechts (→)">→</span>
                    <span style="color:#475569">|</span>
                    <span class="kbd-key" id="key-8" onclick="setGlobalAxisFlatten(0.0)" title="Wiel Helemaal Plat op Oorsprong (8)">8:PLAT(0)</span>
                    <span class="kbd-key" id="key-9" onclick="setGlobalAxisFlatten(-1.0)" title="Wiel door Oorsprong naar Negatief (9)">9:NEG(-1)</span>
                    <span class="kbd-key" id="key-7" onclick="setGlobalAxisFlatten(1.0)" title="Herstel Positief Rond (7)">7:POS(+1)</span>
                    <span class="kbd-key" id="key-x" onclick="toggleOriginFoldAnimation()" title="Animeer Vouw door Oorsprong (X)">X:VOUW</span>
                    <span style="color:#475569">|</span>
                    <span class="kbd-key mg-active" id="key-f" onclick="toggleFootprintPyramid()" title="Toon/Verberg 8-Assets Piramide Kaders (F)">F:PIRAMIDE</span>
                    <span class="kbd-key" id="key-s" onclick="stopPlanimeterArm()" title="Zet Arm Stil (S of Spatie)">S:STOP</span>
                    <span class="kbd-key run-active" id="key-g" onclick="startPlanimeterArm()" title="Start Arm Vrij (G)">G:START</span>
                    <span class="kbd-key mg-active" id="key-t" onclick="stampMagnesiumPoint()" title="Stempel Magnesium Punt (T)">T:STEMPEL</span>
                </div>

                <!-- DE GEÏNTEGREERDE MULTI-AS GEO-TEKENING, 8-ASSETS PIRAMIDE, MAGNESIUM OVERTREK & OTT NR. 573 -->
                <svg id="geo-svg" viewBox="-480 -480 960 960" preserveAspectRatio="xMidYMid meet">
                    <defs>
                        <pattern id="grid-05cm" width="20" height="20" patternUnits="userSpaceOnUse">
                            <path d="M 20 0 L 0 0 0 20" fill="none" stroke="var(--grid-fine)" stroke-width="0.7"/>
                            <path d="M 0 0 L 20 20" fill="none" stroke="rgba(0, 210, 255, 0.05)" stroke-width="0.5"/>
                        </pattern>
                        <pattern id="grid-25cm" width="100" height="100" patternUnits="userSpaceOnUse">
                            <rect width="100" height="100" fill="url(#grid-05cm)"/>
                            <path d="M 100 0 L 0 0 0 100" fill="none" stroke="var(--grid-major)" stroke-width="1.1"/>
                        </pattern>
                        <pattern id="mg-vellum-grid" width="20" height="20" patternUnits="userSpaceOnUse">
                            <path d="M 20 0 L 0 0 0 20" fill="none" stroke="rgba(80, 255, 176, 0.14)" stroke-width="0.6"/>
                            <circle cx="0" cy="0" r="0.8" fill="rgba(230, 255, 247, 0.35)"/>
                        </pattern>
                        <filter id="laser-glow" x="-50%" y="-50%" width="200%" height="200%">
                            <feGaussianBlur stdDeviation="3.0" result="blur1"/>
                            <feGaussianBlur stdDeviation="7.0" result="blur2"/>
                            <feMerge>
                                <feMergeNode in="blur2"/>
                                <feMergeNode in="blur1"/>
                                <feMergeNode in="SourceGraphic"/>
                            </feMerge>
                        </filter>
                        <filter id="mg-flare" x="-30%" y="-30%" width="160%" height="160%">
                            <feGaussianBlur stdDeviation="2.0" result="mgBlur"/>
                            <feMerge>
                                <feMergeNode in="mgBlur"/>
                                <feMergeNode in="SourceGraphic"/>
                            </feMerge>
                        </filter>
                        <marker id="arrow-gold" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
                            <path d="M 0 1 L 10 5 L 0 9 z" fill="#ffcc33"/>
                        </marker>
                        <marker id="arrow-magenta" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
                            <path d="M 0 1 L 10 5 L 0 9 z" fill="#ff3385"/>
                        </marker>
                    </defs>

                    <!-- 1. VASTE RASTER LAAG (0.5 cm eenheden) -->
                    <rect x="-480" y="-480" width="960" height="960" fill="url(#grid-25cm)"/>

                    <!-- 1B. ACTIEVE GEPROJECTEERDE AFBEELDING UIT ./assets/images/ -->
                    <g id="assets-image-layer"></g>

                    <!-- 1C. NIEUW: CONCENTRISCHE PIRAMIDE VAN ALLE 8 GEOCENTRUM BESTANDEN -->
                    <g id="pyramid-footprint-layer"></g>

                    <g id="axes" stroke="#2dd4bf" stroke-width="0.9" opacity="0.8">
                        <line x1="-480" y1="0" x2="480" y2="0" stroke="#50ffb0" stroke-width="1.2" stroke-dasharray="6,3"/>
                        <line x1="0" y1="-480" x2="0" y2="480" stroke="#00e5ff" stroke-width="1.2" stroke-dasharray="6,3"/>
                        <circle cx="0" cy="0" r="5" fill="none" stroke="#ffcc33" stroke-width="1.5"/>
                        <text x="10" y="-8" fill="#ffcc33" font-size="9" font-family="Courier New" font-weight="bold">OORSPRONG (0,0)</text>
                    </g>

                    <!-- 2. ONAFHANKELIJK DRAAIENDE & PLAT-KANTELBARE WIELEN IN VERSCHILLENDE ASSEN -->
                    <g id="multi-axis-wheels-root">
                        <g id="wheel-iching-64"></g>
                        <g id="wheel-jiazi-60"></g>
                        <g id="wheel-inner-16"></g>
                    </g>

                    <!-- 3. MAGNESIUM OVERTREK LAYER (CALQUEER-VEL & ARM-SPOREN) -->
                    <g id="magnesium-overtrek-layer">
                        <rect id="mg-vellum-sheet" x="-480" y="-480" width="960" height="960" fill="rgba(4, 14, 24, 0.35)" pointer-events="none"/>
                        <rect id="mg-vellum-dots" x="-480" y="-480" width="960" height="960" fill="url(#mg-vellum-grid)" opacity="0.8" pointer-events="none"/>
                        <rect x="-466" y="-466" width="932" height="932" fill="none" stroke="rgba(80, 255, 176, 0.35)" stroke-width="1" stroke-dasharray="8,4" pointer-events="none"/>
                        <text x="-455" y="-448" fill="#50ffb0" font-size="9.5" font-family="Courier New" font-weight="bold" opacity="0.88">MAGNESIUM OVERTREK LAYER // FUNDAMENTELE ORDENING (8 ASSETS PIRAMIDE)</text>
                        <g id="mg-traces-group" filter="url(#mg-flare)"></g>
                    </g>

                    <!-- 4. A. OTT NR. 573 PLANIMETER KINEMATICA LAAG -->
                    <g id="planimeter-layer"></g>

                    <!-- 5. OPTISCHE LASER LAAG OP DE PLANO-ARM -->
                    <g id="laser-layer"></g>
                </svg>
            </div>

            <!-- COCKPIT CONTROLS ONDERIN DE VIEWPORT -->
            <div class="cockpit-controls">
                <div class="slider-box">
                    <div class="slider-info">ARM DRAAI (θ ←/→) <span id="yaw-deg">0.0°</span></div>
                    <input type="range" min="0" max="360" step="0.1" value="0" id="yaw-slider" oninput="processKinematica('yaw', this.value)">
                </div>
                <div class="slider-box">
                    <div class="slider-info">STRAAL DOOR (0,0) (ρ ↑/↓) <span id="rho-val">+10.75 cm</span></div>
                    <input type="range" min="-11.5" max="11.5" step="0.05" value="10.75" id="rho-slider" oninput="processKinematica('rho', this.value)">
                </div>
                <div class="slider-box">
                    <div class="slider-info">WIEL PLAT → NEGATIEF (σ [-/+]) <span id="sigma-val" style="color:var(--mg-glow)">+1.00</span></div>
                    <input type="range" min="-1" max="1" step="0.01" value="1.0" id="sigma-slider" oninput="setGlobalAxisFlatten(this.value)">
                </div>
                <div class="slider-box">
                    <div class="slider-info">3D PITCH / GOLFLENGTE <span id="pitch-deg">0° | 517.3nm</span></div>
                    <input type="range" min="0" max="60" step="1" value="0" id="pitch-slider" oninput="processKinematica('pitch', this.value)">
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    // --- CONSTANTES & SCHAAL ---
    const PX_PER_CM = 40;
    const R_KOMPAS_CM = Math.sqrt(363.0 / Math.PI); // 10.74905 cm (21.5 vakjes)
    const R_KOMPAS_PX = R_KOMPAS_CM * PX_PER_CM;    // 429.96 px
    const R_JIAZI_PX  = 355;                        // 8.875 cm = exact de hoogte van vizierkerf.png!
    const R_NUC_PX    = (R_KOMPAS_CM / 4) * PX_PER_CM; // 2.687 cm = 107.5 px

    const STEMS = ["Jia","Yi","Bing","Ding","Wu","Ji","Geng","Xin","Ren","Gui"];
    const BRANCHES = ["Zi","Chou","Yin","Mao","Chen","Si","Wu","Wei","Shen","You","Xu","Hai"];
    const COMPASS_16 = ["N","NNO","NO","ONO","O","OZO","ZO","ZZO","Z","ZZW","ZW","WZW","W","WNW","NW","NNW"];
    const CORE_COLORS = { "00": "#3b82f6", "10": "#eab308", "01": "#ec4899", "11": "#ef4444" };

    // =========================================================================================
    // DE 8 GEÏNDEXEERDE BESTANDEN UIT /home/ontwerp/Bureaublad/geocentrum/assets/images/
    // Gesorteerd volgens hun Fundamentele Harmonische Ordening (Trap 1 t/m Trap 5)
    // =========================================================================================
    const FUNDAMENTAL_ASSETS = [
        {
            rank: "TRAP 1 // SLEUTEL",
            name: "vizierkerf.png",
            url: "assets/images/vizierkerf.png",
            size_kb: 10.6,
            width_px: 671, height_px: 355,
            width_cm: 16.78, height_cm: 8.88,
            width_vakjes: 33.5, height_vakjes: 17.8,
            area_cm2: 148.9, ott573_nonius: 1489,
            color: "#50ffb0",
            lawTitle: "H=355px (Exact R_Jiazi & π=355/113) × B=671px (Exact L_rij Ott 573)",
            diagAngle: 62.1 // Hoek van de diagonaal t.o.v. Noord
        },
        {
            rank: "TRAP 2 // 5:2 PALINDROOM",
            name: "Schermafdruk van 2026-10-08 21-53-...",
            matchPrefix: "Schermafdruk",
            url: "assets/images/Schermafdruk van 2026-10-08 21-53-00.png",
            size_kb: 493.6,
            width_px: 1953, height_px: 786,
            width_cm: 48.8, height_cm: 19.6,
            width_vakjes: 97.7, height_vakjes: 39.3,
            area_cm2: 959.5, ott573_nonius: 9595,
            color: "#38bdf8",
            lawTitle: "Nonius Palindroom 9595n | Ratio 1953:786 = 2.485 (≈ 5:2 Harmonie)",
            diagAngle: 68.1
        },
        {
            rank: "TRAP 3A // √3 HORIZON",
            name: "cellarius-horizon-oost-overlay-v5.png",
            matchPrefix: "cellarius-horizon-oost",
            url: "assets/images/cellarius-horizon-oost-overlay-v5.png",
            size_kb: 174.3,
            width_px: 1950, height_px: 1125,
            width_cm: 48.8, height_cm: 28.1,
            width_vakjes: 97.5, height_vakjes: 56.25,
            area_cm2: 1370.8, ott573_nonius: 13708,
            color: "#ffcc33",
            lawTitle: "H=56.25 vakjes (10×5.625° Shao Yong) | B/H = 26/15 = 1.7333 ≈ √3 (tan 60°)",
            diagAngle: 60.0
        },
        {
            rank: "TRAP 3B // 5625 MATRIX",
            name: "cellarius-raster-overlay-v3.png",
            matchPrefix: "cellarius-raster-overlay-v3",
            url: "assets/images/cellarius-raster-overlay-v3.png",
            size_kb: 288.5,
            width_px: 1500, height_px: 1500,
            width_cm: 37.5, height_cm: 37.5,
            width_vakjes: 75.0, height_vakjes: 75.0,
            area_cm2: 1406.2, ott573_nonius: 14062,
            color: "#00ffcc",
            lawTitle: "75×75 = 5625 vakjes (Exact 1000 × 5.625° Shao Yong hoek) | 1500px = 25×60 Jiazi",
            diagAngle: 45.0
        },
        {
            rank: "TRAP 3C // 60-SPIEGEL",
            name: "breda-spiegel-west-noordwest-v8.png",
            matchPrefix: "breda-spiegel",
            url: "assets/images/breda-spiegel-west-noordwest-v8.png",
            size_kb: 322.8,
            width_px: 2048, height_px: 1195,
            width_cm: 51.2, height_cm: 29.9,
            width_vakjes: 102.4, height_vakjes: 59.8,
            area_cm2: 1529.9, ott573_nonius: 15299,
            color: "#f97316",
            lawTitle: "B=2048px (2¹¹) × H=59.8≈60 vakjes (1 volledige Jiazi-cyclus van 60 vakjes)",
            diagAngle: 59.7
        },
        {
            rank: "TRAP 4 // Δ1-KALIBRATIE",
            name: "cellarius-raster-overlay-v2.png",
            matchPrefix: "cellarius-raster-overlay-v2",
            url: "assets/images/cellarius-raster-overlay-v2.png",
            size_kb: 629.5,
            width_px: 2027, height_px: 2048,
            width_cm: 50.7, height_cm: 51.2,
            width_vakjes: 101.3, height_vakjes: 102.4,
            area_cm2: 2594.3, ott573_nonius: 25943,
            color: "#a855f7",
            lawTitle: "2027×2048 px: Exact 1 vakje (21 px / 0.5 cm) kalibratie-offset t.o.v. 2¹¹",
            diagAngle: 44.7
        },
        {
            rank: "TRAP 5A // 64³ AARDE-MATRIX",
            name: "cellarius-raster-overlay-v4.png",
            matchPrefix: "cellarius-raster-overlay-v4",
            url: "assets/images/cellarius-raster-overlay-v4.png",
            size_kb: 552.1,
            width_px: 2048, height_px: 2048,
            width_cm: 51.2, height_cm: 51.2,
            width_vakjes: 102.4, height_vakjes: 102.4,
            area_cm2: 2621.4, ott573_nonius: 26214,
            color: "#ff3385",
            lawTitle: "2048×2048 (2¹¹×2¹¹) | Opp = 2621.44 cm² → 262.144 = 64³ (3D Shao Yong Kubus!)",
            diagAngle: 45.0
        },
        {
            rank: "TRAP 5B // 64³ HEMEL-SCHIJF",
            name: "nebra-pleiaden-precisie-overlay.png",
            matchPrefix: "nebra-pleiaden",
            url: "assets/images/nebra-pleiaden-precisie-overlay.png",
            size_kb: 307.7,
            width_px: 2048, height_px: 2048,
            width_cm: 51.2, height_cm: 51.2,
            width_vakjes: 102.4, height_vakjes: 102.4,
            area_cm2: 2621.4, ott573_nonius: 26214,
            color: "#fde047",
            lawTitle: "Tweeling-resonantie met Cellarius-v4: 262.144 = 64³ (Nebra Hemel ↔ Cellarius Aarde)",
            diagAngle: 45.0
        }
    ];

    // Koppel exacte volledige bestandsnamen uit window.VORTEX_ASSETS_MANIFEST indien aanwezig
    if (Array.isArray(window.VORTEX_ASSETS_MANIFEST) && window.VORTEX_ASSETS_MANIFEST.length > 0) {
        FUNDAMENTAL_ASSETS.forEach(fa => {
            const match = window.VORTEX_ASSETS_MANIFEST.find(m =>
                m.name === fa.name || (fa.matchPrefix && m.name.startsWith(fa.matchPrefix))
            );
            if (match) {
                fa.name = match.name;
                fa.url = match.url;
            }
        });
    }

    const assetsLayerEl = document.getElementById('assets-image-layer');
    const pyramidLayerEl = document.getElementById('pyramid-footprint-layer');
    const wheel64El = document.getElementById('wheel-iching-64');
    const wheel60El = document.getElementById('wheel-jiazi-60');
    const wheel16El = document.getElementById('wheel-inner-16');
    const mgTracesGroup = document.getElementById('mg-traces-group');
    const planimeterGroup = document.getElementById('planimeter-layer');
    const laserGroup = document.getElementById('laser-layer');
    const terminal = document.getElementById('ai-terminal');
    const svgEl = document.getElementById('geo-svg');

    const state = {
        azDeg: 0.0,
        rhoCm: R_KOMPAS_CM,
        globalSigmaY: 1.0,
        globalSigmaX: 1.0,
        w64: { rot: 0.0, tilt: 1.0 },
        w60: { rot: 0.0, tilt: 1.0 },
        w16: { rot: 0.0, tilt: 1.0 },
        txPx: 0, tyPx: -R_KOMPAS_PX,
        gxPx: 0, gyPx: 0,
        alphaDeg: 0, betaDeg: 0, gammaDeg: 90,
        pitchDeg: 0,
        armStopped: false,
        mouseFollow: false,
        recordingOmtrek: false,
        omtrekPoints: [],
        stampedNodes: [],
        mgVellumActive: true,
        foldAnimTimer: null,
        foldDirection: -1,
        laserEnabled: true,
        activeAssetIdx: 0,
        showPyramid: true
    };

    // --- 0. BOUW DE FUNDAMENTELE ORDENING LIJST & CONCENTRISCHE PIRAMIDE ---
    function buildFundamentalOrderList() {
        const container = document.getElementById('fundamental-order-list');
        container.innerHTML = FUNDAMENTAL_ASSETS.map((a, idx) => `
            <div class="order-card ${idx === state.activeAssetIdx ? 'active' : ''}" id="ocard-${idx}" onclick="selectFundamentalAsset(${idx})">
                <div class="order-card-top">
                    <span style="color:${a.color}">${idx + 1}. ${a.name.slice(0, 28)}</span>
                    <span class="order-law-badge">${a.rank}</span>
                </div>
                <div class="order-card-sub">
                    <span>${a.width_px}×${a.height_px}px (${a.width_vakjes}×${a.height_vakjes} vak)</span>
                    <span style="color:var(--gold); font-weight:bold;">${a.area_cm2}cm² (${a.ott573_nonius}n)</span>
                </div>
                <div style="font-size:0.52rem; color:#cbd5e1; margin-top:2px;">⚡ ${a.lawTitle}</div>
            </div>
        `).join('');
    }

    function selectFundamentalAsset(idx) {
        state.activeAssetIdx = idx;
        document.querySelectorAll('.order-card').forEach((el, i) => el.classList.toggle('active', i === idx));
        const a = FUNDAMENTAL_ASSETS[idx];

        // Als het vizierkerf.png is, past deze 1-op-1 binnen de cirkel (100% schaal = echte 40px/cm!).
        // Voor de grote 2048px kaarten schalen we standaard zodat ze mooi binnen het 960x960 kompas-venster zichtbaar zijn (42%),
        // of klik op "Echte 1:1 Schaal" om de 100% ware grootte te zien.
        const defaultScale = a.width_px <= 860 ? 100 : Math.round((860 / Math.max(a.width_px, a.height_px)) * 100);
        document.getElementById('sl-img-scale').value = defaultScale;

        // Stuur de planimeter-arm direct naar de karakteristieke diagonaalhoek van dit bestand!
        state.azDeg = a.diagAngle;
        // Voor vizierkerf zetten we de straal op de exacte Jiazi-ring (8.875 cm = 355 px), anders op de kompas-rand (10.75 cm)
        state.rhoCm = (a.width_px === 671) ? 8.875 : R_KOMPAS_CM;

        updateActiveAssetOverlay();
        renderConcentricPyramid();
        updatePlanimeterFromPolar(true);

        injectAI(`<b>🏛️ FUNDAMENTELE ORDENING GEACTIVEERD [${a.rank}]:</b><br>Bestand: <code>${a.url}</code><br>• <b>Afmeting:</b> ${a.width_px}×${a.height_px} px = <b>${a.width_cm}×${a.height_cm} cm</b> (${a.width_vakjes}×${a.height_vakjes} vakjes)<br>• <b>Ott Nr. 573 Integratie:</b> ${a.area_cm2} cm² = <b>${a.ott573_nonius} nonius</b> (${((a.area_cm2/363)*100).toFixed(1)}% van de 363 cm² cirkel)<br>• <b>Wetmatigheid:</b> ${a.lawTitle}`);
    }

    function updateActiveAssetOverlay() {
        const a = FUNDAMENTAL_ASSETS[state.activeAssetIdx];
        if (!a) return;

        const scalePct = parseFloat(document.getElementById('sl-img-scale').value);
        const opPct = parseFloat(document.getElementById('sl-img-op').value);
        document.getElementById('lbl-img-scale').textContent = `${scalePct}%`;
        document.getElementById('lbl-img-op').textContent = `${opPct}%`;

        const factor = scalePct / 100.0;
        const wPx = a.width_px * factor;
        const hPx = a.height_px * factor;
        const x0 = -wPx / 2, y0 = -hPx / 2;

        const effSigmaY = document.getElementById('chk-adapt-trace').checked ? (state.globalSigmaY * state.w64.tilt) : 1.0;
        assetsLayerEl.setAttribute('transform', `scale(${state.globalSigmaX}, ${effSigmaY})`);
        assetsLayerEl.innerHTML = `
            <image href="${a.url}" x="${x0}" y="${y0}" width="${wPx}" height="${hPx}" opacity="${opPct / 100}" preserveAspectRatio="none"/>
            <rect x="${x0}" y="${y0}" width="${wPx}" height="${hPx}" fill="none" stroke="${a.color}" stroke-width="2.0" stroke-dasharray="8,4"/>
            <line x1="${x0}" y1="${y0 + hPx}" x2="${x0 + wPx}" y2="${y0}" stroke="${a.color}" stroke-width="1.1" stroke-dasharray="3,3" opacity="0.7"/>
            <text x="${x0 + 6}" y="${y0 - 7}" fill="${a.color}" font-size="9.5" font-family="Courier New" font-weight="bold">
                [${a.rank}] ${a.name} | 1:1 = ${a.width_cm}×${a.height_cm}cm (${a.width_vakjes}×${a.height_vakjes} vak) | ${a.ott573_nonius} nonius
            </text>
        `;

        // Update Sectie 0 in het Resultaten-Venster
        const ratioBH = (a.width_px / a.height_px).toFixed(4);
        const sySectors = (a.area_cm2 / (363.0 / 64.0)).toFixed(2);
        const jzSectors = (a.area_cm2 / (363.0 / 60.0)).toFixed(2);
        const totalVak2 = (a.width_vakjes * a.height_vakjes).toFixed(1);

        document.getElementById('res-asset-rank').textContent = a.rank;
        document.getElementById('res-asset-url').textContent = a.url;
        document.getElementById('res-asset-dim').textContent = `${a.width_px}×${a.height_px} px | ${a.width_cm}×${a.height_cm} cm`;
        document.getElementById('res-asset-vakjes').textContent = `${a.width_vakjes} × ${a.height_vakjes} vak (${totalVak2} vak²)`;
        document.getElementById('res-asset-area').textContent = `${a.area_cm2} cm² | ${a.ott573_nonius} nonius (${((a.area_cm2/363)*100).toFixed(1)}%)`;
        document.getElementById('res-asset-ratio').textContent = `${ratioBH} — ${a.lawTitle.split('|')[0]}`;
        document.getElementById('res-asset-sectors').textContent = `${sySectors} SY-sectoren | ${jzSectors} Jiazi-sectoren`;

        document.getElementById('vp-asset-info').textContent = `${a.name} (${a.width_px}×${a.height_px}px | ${a.ott573_nonius}n)`;
        document.getElementById('vp-law-info').textContent = a.lawTitle;
    }

    // Teken de Concentrische Piramide van alle 8 bestanden (geschaald met factor 0.42 zodat 2048px precies op de 860px cirkel-diameter ligt!)
    function renderConcentricPyramid() {
        const show = document.getElementById('chk-pyramid').checked;
        state.showPyramid = show;
        if (!show) {
            pyramidLayerEl.innerHTML = '';
            return;
        }
        // Schaal waarbij de grootste 2048x2048 matrix (51.2 cm) precies op de buitendiameter van de kompasroos (859.9 px) wordt afgebeeld,
        // ÓF voor vizierkerf.png (671x355 px) ook zijn exacte 1:1 verhouding tot R_JIAZI_PX (355 px)!
        const normScale = (R_KOMPAS_PX * 2) / 2048.0; // 0.41988
        const effSigmaY = document.getElementById('chk-adapt-trace').checked ? (state.globalSigmaY * state.w64.tilt) : 1.0;

        let html = '';
        FUNDAMENTAL_ASSETS.forEach((a, idx) => {
            const isAct = idx === state.activeAssetIdx;
            const w = a.width_px * normScale;
            const h = a.height_px * normScale;
            const x = -w / 2, y = -h / 2;
            html += `<rect x="${x.toFixed(1)}" y="${y.toFixed(1)}" width="${w.toFixed(1)}" height="${h.toFixed(1)}"
                fill="none" stroke="${a.color}" stroke-width="${isAct ? 2.2 : 1.0}"
                stroke-dasharray="${isAct ? 'none' : '4,3'}" opacity="${isAct ? 0.95 : 0.55}"/>`;
            html += `<text x="${(x + 4).toFixed(1)}" y="${(y + 10 + (idx % 2)*9).toFixed(1)}" fill="${a.color}" font-size="7.5" font-family="Courier New" opacity="${isAct ? 1.0 : 0.7}">
                #${idx+1} ${a.name.slice(0,18)} (${a.ott573_nonius}n)
            </text>`;
        });

        // Teken daarnaast het EXACTE 1:1 kader van vizierkerf.png (671 x 355 px), waarbij Hoogte 355 px = exact R_JIAZI_PX!
        html += `<rect x="${-671/2}" y="${-355}" width="671" height="355" fill="rgba(80,255,176,0.04)" stroke="#50ffb0" stroke-width="1.6" stroke-dasharray="6,2"/>`;
        html += `<text x="${-671/2 + 6}" y="${-355 - 5}" fill="#50ffb0" font-size="8.5" font-family="Courier New" font-weight="bold">
            SLEUTEL 1:1 VIZIERKERF (671×355 px): Hoogte 355px raakt exact 60-Jiazi Ring (R=355px) → Oorsprong (0,0)!
        </text>`;

        pyramidLayerEl.setAttribute('transform', `scale(${state.globalSigmaX}, ${effSigmaY})`);
        pyramidLayerEl.innerHTML = html;
    }

    function toggleFootprintPyramid() {
        const chk = document.getElementById('chk-pyramid');
        chk.checked = !chk.checked;
        document.getElementById('key-f').classList.toggle('mg-active', chk.checked);
        renderConcentricPyramid();
    }

    function fitAssetToKompasCircle() {
        const a = FUNDAMENTAL_ASSETS[state.activeAssetIdx];
        const pct = Math.round(((R_KOMPAS_PX * 2) / Math.max(a.width_px, a.height_px)) * 100);
        document.getElementById('sl-img-scale').value = pct;
        updateActiveAssetOverlay();
    }

    function setTrue1to1Scale() {
        document.getElementById('sl-img-scale').value = 100;
        updateActiveAssetOverlay();
    }

    function getShaoYongBits(idx) {
        const cleanIdx = ((idx % 64) + 64) % 64;
        const val = cleanIdx < 32 ? (63 - cleanIdx) : (cleanIdx - 32);
        return val.toString(2).padStart(6, '0');
    }

    function invertBits(bits) {
        return bits.split('').map(b => b === '1' ? '0' : '1').join('');
    }

    function computeNuclear(bits) {
        const b2 = bits[1], b3 = bits[2], b4 = bits[3], b5 = bits[4];
        return { N: `${b2}${b3}${b4}${b3}${b4}${b5}`, N2: `${b3}${b4}${b3}${b4}${b3}${b4}`, core: `${b3}${b4}` };
    }

    // --- 1. BOUW DE 3 ONAFHANKELIJKE WIELEN (I CHING 64, JIAZI 60, BINNENWIEL 16 & N²) ---
    function buildIndependentWheels() {
        let h64 = '';
        h64 += `<circle cx="0" cy="0" r="${R_KOMPAS_PX}" fill="rgba(0, 180, 216, 0.04)" stroke="#00e5ff" stroke-width="2.2"/>`;
        h64 += `<circle cx="0" cy="0" r="${R_KOMPAS_PX - 38}" fill="none" stroke="#00e5ff" stroke-width="1"/>`;

        [
            { ang: 0, lbl: "0° BEGINSTAND [0]", col: "#50ffb0" },
            { ang: 29, lbl: "29° NYC", col: "#00ffcc" },
            { ang: 45, lbl: "45° 64³ / 5625 DIAGONAAL", col: "#fde047" },
            { ang: 60, lbl: "60° √3 CELLARIUS OOST", col: "#ffcc33" },
            { ang: 82.5, lbl: "82.5° THOLEN", col: "#f97316" },
            { ang: 108, lbl: "108° SIRIUS", col: "#ff3385" }
        ].forEach(v => {
            const rad = (v.ang - 90) * Math.PI / 180;
            const x2 = Math.cos(rad) * (R_KOMPAS_PX + 15);
            const y2 = Math.sin(rad) * (R_KOMPAS_PX + 15);
            h64 += `<line x1="0" y1="0" x2="${x2}" y2="${y2}" stroke="${v.col}" stroke-width="1" stroke-dasharray="3,4" opacity="0.65"/>`;
            h64 += `<text x="${x2 * 1.05}" y="${y2 * 1.05}" fill="${v.col}" font-size="8" font-weight="bold" text-anchor="middle">${v.lbl}</text>`;
        });

        for (let i = 0; i < 64; i++) {
            const a1 = (i * 5.625 - 90) * Math.PI / 180;
            const am = ((i + 0.5) * 5.625 - 90) * Math.PI / 180;
            const bits = getShaoYongBits(i);
            const { core } = computeNuclear(bits);
            const col = CORE_COLORS[core];

            const x1 = Math.cos(a1) * (R_KOMPAS_PX - 38), y1 = Math.sin(a1) * (R_KOMPAS_PX - 38);
            const x2 = Math.cos(a1) * R_KOMPAS_PX, y2 = Math.sin(a1) * R_KOMPAS_PX;
            h64 += `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="#1e40af" stroke-width="0.8"/>`;

            const bx = Math.cos(am) * (R_KOMPAS_PX - 12), by = Math.sin(am) * (R_KOMPAS_PX - 12);
            h64 += `<circle cx="${bx}" cy="${by}" r="3.5" fill="${col}" opacity="0.9"/>`;

            for (let b = 0; b < 6; b++) {
                const rBit = (R_KOMPAS_PX - 35) + b * 3.5;
                const dAngle = 0.032;
                const lx1 = Math.cos(am - dAngle) * rBit, ly1 = Math.sin(am - dAngle) * rBit;
                const lx2 = Math.cos(am + dAngle) * rBit, ly2 = Math.sin(am + dAngle) * rBit;
                if (bits[b] === '1') {
                    h64 += `<line x1="${lx1}" y1="${ly1}" x2="${lx2}" y2="${ly2}" stroke="#ffcc33" stroke-width="1.5"/>`;
                } else {
                    const lxm1 = Math.cos(am - dAngle * 0.25) * rBit, lym1 = Math.sin(am - dAngle * 0.25) * rBit;
                    const lxm2 = Math.cos(am + dAngle * 0.25) * rBit, lym2 = Math.sin(am + dAngle * 0.25) * rBit;
                    h64 += `<line x1="${lx1}" y1="${ly1}" x2="${lxm1}" y2="${lym1}" stroke="#38bdf8" stroke-width="1.5"/>`;
                    h64 += `<line x1="${lxm2}" y1="${lym2}" x2="${lx2}" y2="${ly2}" stroke="#38bdf8" stroke-width="1.5"/>`;
                }
            }
        }
        wheel64El.innerHTML = h64;

        let h60 = '';
        h60 += `<circle cx="0" cy="0" r="${R_JIAZI_PX}" fill="none" stroke="#a855f7" stroke-width="1.6"/>`;
        h60 += `<circle cx="0" cy="0" r="${R_JIAZI_PX - 28}" fill="none" stroke="#a855f7" stroke-width="1"/>`;
        for (let j = 0; j < 60; j++) {
            const a1 = (j * 6 - 90) * Math.PI / 180;
            const am = ((j + 0.5) * 6 - 90) * Math.PI / 180;
            const x1 = Math.cos(a1) * (R_JIAZI_PX - 28), y1 = Math.sin(a1) * (R_JIAZI_PX - 28);
            const x2 = Math.cos(a1) * R_JIAZI_PX, y2 = Math.sin(a1) * R_JIAZI_PX;
            h60 += `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="#7e22ce" stroke-width="0.7"/>`;

            const tx = Math.cos(am) * (R_JIAZI_PX - 14), ty = Math.sin(am) * (R_JIAZI_PX - 14);
            const rot = (j + 0.5) * 6;
            const label = `${STEMS[j % 10][0]}${BRANCHES[j % 12][0]}${j+1}`;
            h60 += `<text x="${tx}" y="${ty}" fill="#e9d5ff" font-size="7.5" text-anchor="middle" dominant-baseline="central" transform="rotate(${rot}, ${tx}, ${ty})">${label}</text>`;
        }
        wheel60El.innerHTML = h60;

        let h16 = '';
        for (let s = 0; s < 16; s++) {
            const ang = (s * 22.5 - 90) * Math.PI / 180;
            const angL = ((s * 22.5 - 6) - 90) * Math.PI / 180;
            const angR = ((s * 22.5 + 6) - 90) * Math.PI / 180;
            const rTip = (s % 4 === 0) ? (R_JIAZI_PX - 30) : (s % 2 === 0 ? 275 : 215);
            const rBase = R_NUC_PX;

            const px = Math.cos(ang) * rTip, py = Math.sin(ang) * rTip;
            const lx = Math.cos(angL) * rBase, ly = Math.sin(angL) * rBase;
            const rx = Math.cos(angR) * rBase, ry = Math.sin(angR) * rBase;
            const fillCol = (s % 2 === 0) ? "rgba(0, 229, 255, 0.22)" : "rgba(168, 85, 247, 0.18)";
            const strCol  = (s % 4 === 0) ? "#ffcc33" : "#00e5ff";

            h16 += `<polygon points="0,0 ${lx},${ly} ${px},${py}" fill="${fillCol}" stroke="${strCol}" stroke-width="0.9"/>`;
            h16 += `<polygon points="0,0 ${px},${py} ${rx},${ry}" fill="rgba(15, 23, 42, 0.65)" stroke="${strCol}" stroke-width="0.9"/>`;
        }
        h16 += `<path d="M 0 ${-R_KOMPAS_PX} A ${R_KOMPAS_PX/2} ${R_KOMPAS_PX/2} 0 0 1 0 0 A ${R_KOMPAS_PX/2} ${R_KOMPAS_PX/2} 0 0 0 0 ${R_KOMPAS_PX}" fill="none" stroke="#ff3385" stroke-width="2.2" stroke-dasharray="6,4" marker-end="url(#arrow-magenta)"/>`;
        h16 += `<circle cx="0" cy="0" r="${R_NUC_PX}" fill="rgba(15, 23, 42, 0.88)" stroke="#ff9900" stroke-width="2"/>`;
        [
            { code: "11", ang: -45, col: CORE_COLORS["11"] },
            { code: "01", ang: 45, col: CORE_COLORS["01"] },
            { code: "00", ang: 135, col: CORE_COLORS["00"] },
            { code: "10", ang: -135, col: CORE_COLORS["10"] }
        ].forEach(c => {
            const rad = c.ang * Math.PI / 180;
            const cx = Math.cos(rad) * (R_NUC_PX * 0.58), cy = Math.sin(rad) * (R_NUC_PX * 0.58);
            h16 += `<circle cx="${cx}" cy="${cy}" r="22" fill="rgba(0,0,0,0.65)" stroke="${c.col}" stroke-width="1.8"/>`;
            h16 += `<text x="${cx}" y="${cy - 3}" fill="${c.col}" font-size="11" font-weight="bold" text-anchor="middle">${c.code}</text>`;
            h16 += `<text x="${cx}" y="${cy + 9}" fill="#cbd5e1" font-size="7.5" text-anchor="middle">90,75cm²</text>`;
        });
        wheel16El.innerHTML = h16;
    }

    function applyWheelTransforms() {
        const sY64 = state.globalSigmaY * state.w64.tilt;
        const sY60 = state.globalSigmaY * state.w60.tilt;
        const sY16 = state.globalSigmaY * state.w16.tilt;

        wheel64El.setAttribute('transform', `scale(${state.globalSigmaX}, ${sY64}) rotate(${state.w64.rot})`);
        wheel60El.setAttribute('transform', `rotate(45) scale(${state.globalSigmaX}, ${sY60}) rotate(-45) rotate(${state.w60.rot})`);
        wheel16El.setAttribute('transform', `scale(${state.globalSigmaX}, ${sY16}) rotate(${state.w16.rot})`);

        document.getElementById('lbl-w64').textContent = `Draai: ${state.w64.rot.toFixed(1)}° | As: ${sY64 >= 0 ? '+' : ''}${sY64.toFixed(2)}`;
        document.getElementById('lbl-w60').textContent = `Draai: ${state.w60.rot.toFixed(1)}° | As: ${sY60 >= 0 ? '+' : ''}${sY60.toFixed(2)}`;
        document.getElementById('lbl-w16').textContent = `Draai: ${state.w16.rot.toFixed(1)}° | As: ${sY16 >= 0 ? '+' : ''}${sY16.toFixed(2)}`;

        updateActiveAssetOverlay();
        renderConcentricPyramid();
    }

    function computeTransformedWheelPoint(azDeg, rhoCm) {
        const rad = (azDeg - 90) * Math.PI / 180;
        const rawX = Math.cos(rad) * (rhoCm * PX_PER_CM);
        const rawY = Math.sin(rad) * (rhoCm * PX_PER_CM);
        const effSigmaY = state.globalSigmaY * state.w64.tilt;
        return { x: rawX * state.globalSigmaX, y: rawY * effSigmaY, effSigmaY };
    }

    // --- 2. UPDATE DE ADAPTIEVE OTT NR. 573 PLANIMETER-ARM ---
    function updatePlanimeterFromPolar(syncSliders = true) {
        applyWheelTransforms();

        const pt = computeTransformedWheelPoint(state.azDeg, state.rhoCm);
        const tx = pt.x, ty = pt.y, effSigmaY = pt.effSigmaY;

        const jacobian = state.globalSigmaX * effSigmaY * (state.rhoCm >= 0 ? 1 : -1);
        const isNegativeSpace = jacobian < -0.001;
        const isFlatOrigin = Math.abs(effSigmaY) <= 0.02 || Math.abs(state.rhoCm) <= 0.08;

        const px = 0, py = -300, R = 300, L = 435;
        const dx = tx - px, dy = ty - py;
        let d = Math.hypot(dx, dy) || 1;
        const maxReach = R + L - 1, minReach = Math.abs(R - L) + 1;

        let effPy = py;
        if (d > maxReach) effPy = ty - (maxReach * (dy / d));
        const edx = tx - px, edy = ty - effPy;
        let ed = Math.max(minReach, Math.min(maxReach, Math.hypot(edx, edy)));

        const a = (R * R - L * L + ed * ed) / (2 * ed);
        const h = Math.sqrt(Math.max(0, R * R - a * a));
        const mx = px + a * (edx / ed), my = effPy + a * (edy / ed);

        const chiralitySign = isNegativeSpace ? -1 : 1;
        const gx = mx - chiralitySign * h * (edy / ed);
        const gy = my + chiralitySign * h * (edx / ed);

        const armLen = Math.hypot(tx - gx, ty - gy) || 1;
        const ux = (tx - gx) / armLen, uy = (ty - gy) / armLen;
        const wx = gx + ux * (L + 70), wy = gy + uy * (L + 70);

        state.txPx = tx; state.tyPx = ty; state.gxPx = gx; state.gyPx = gy;

        const alphaDeg = (Math.atan2(gy - effPy, gx - px) * 180 / Math.PI + 90 + 360) % 360;
        const betaDeg  = (Math.atan2(ty - gy, tx - gx) * 180 / Math.PI + 90 + 360) % 360;
        const cosGamma = Math.max(-1, Math.min(1, (R * R + L * L - ed * ed) / (2 * R * L)));
        const gammaDeg = Math.acos(cosGamma) * 180 / Math.PI;
        state.alphaDeg = alphaDeg; state.betaDeg = betaDeg; state.gammaDeg = gammaDeg;

        const normAz = ((state.azDeg % 360) + 360) % 360;
        const sweepFraction = normAz === 0 ? 1.0 : (normAz / 360.0);
        const rhoRatioSq = Math.pow(state.rhoCm / R_KOMPAS_CM, 2) * (state.rhoCm >= 0 ? 1 : -1);
        const signedNonius = Math.round(3630 * sweepFraction * rhoRatioSq * state.globalSigmaX * effSigmaY);
        const signedAreaCm2 = signedNonius * 0.1;

        const armColor = state.armStopped ? "#ef4444" : (isFlatOrigin ? "#ffffff" : (isNegativeSpace ? "#ff3385" : "#eab308"));
        const tracerStroke = isFlatOrigin ? "#ffffff" : (isNegativeSpace ? "#ff3385" : "#50ffb0");

        let pHtml = '';
        const rxOrbit = Math.abs(state.rhoCm * PX_PER_CM * state.globalSigmaX);
        const ryOrbit = Math.abs(state.rhoCm * PX_PER_CM * effSigmaY);
        if (ryOrbit < 1.5) {
            pHtml += `<line x1="${-rxOrbit}" y1="0" x2="${rxOrbit}" y2="0" stroke="#ffffff" stroke-width="3" stroke-dasharray="6,3"/>`;
        } else {
            pHtml += `<ellipse cx="0" cy="0" rx="${rxOrbit}" ry="${ryOrbit}" fill="none" stroke="${tracerStroke}" stroke-width="1.4" stroke-dasharray="5,3"/>`;
        }

        pHtml += `<line x1="${-tx}" y1="${-ty}" x2="${tx}" y2="${ty}" stroke="${tracerStroke}" stroke-width="1.3" stroke-dasharray="3,3" opacity="0.8"/>`;
        pHtml += `<line x1="${px}" y1="${effPy}" x2="${gx}" y2="${gy}" stroke="#d4af37" stroke-width="15" stroke-linecap="round" opacity="0.88"/>`;
        pHtml += `<circle cx="${px}" cy="${effPy}" r="8" fill="#92400e" stroke="#fde047" stroke-width="2"/>`;
        pHtml += `<text x="${px + 14}" y="${effPy + 4}" fill="#fde047" font-size="9.5" font-weight="bold">Poolanker P (Ott Nr. 573)</text>`;

        pHtml += `<line x1="${gx}" y1="${gy}" x2="${wx}" y2="${wy}" stroke="${armColor}" stroke-width="10" stroke-linecap="round" opacity="0.93"/>`;
        pHtml += `<circle cx="${gx}" cy="${gy}" r="10" fill="#451a03" stroke="${tracerStroke}" stroke-width="2.5"/>`;

        pHtml += `<circle cx="${tx}" cy="${ty}" r="11" fill="rgba(0,0,0,0.7)" stroke="${tracerStroke}" stroke-width="2.8"/>`;
        pHtml += `<circle cx="${tx}" cy="${ty}" r="3.5" fill="#ffffff"/>`;
        pHtml += `<text x="${tx + 14}" y="${ty - 10}" fill="#ffffff" font-size="9.5" font-family="Courier New" font-weight="bold">T (${state.azDeg.toFixed(1)}° | ρ=${state.rhoCm >= 0 ? '+' : ''}${state.rhoCm.toFixed(2)}cm)</text>`;

        pHtml += `<circle cx="${wx}" cy="${wy}" r="20" fill="${isNegativeSpace ? '#ffe4f0' : '#fef3c7'}" stroke="${isNegativeSpace ? '#ff3385' : '#92400e'}" stroke-width="2.5"/>`;
        pHtml += `<text x="${wx}" y="${wy + 3}" fill="#000" font-size="8.2" font-weight="bold" text-anchor="middle">${signedNonius >= 0 ? '+' : ''}${signedNonius}</text>`;

        planimeterGroup.innerHTML = pHtml;
        renderLaserOptics(gx, gy, tx, ty, tracerStroke);

        if (state.recordingOmtrek) {
            state.omtrekPoints.push({
                x_px: tx, y_px: ty, gx_px: gx, gy_px: gy,
                x_cm: tx / PX_PER_CM, y_cm: -ty / PX_PER_CM,
                rawX_px: Math.cos((state.azDeg - 90) * Math.PI / 180) * (state.rhoCm * PX_PER_CM),
                rawY_px: Math.sin((state.azDeg - 90) * Math.PI / 180) * (state.rhoCm * PX_PER_CM)
            });
            renderMagnesiumOvertrek();
        } else if (document.getElementById('chk-adapt-trace').checked) {
            renderMagnesiumOvertrek();
        }

        const originPhaseFlip = isNegativeSpace ? 180.0 : 0.0;
        const relAz64 = ((state.azDeg - state.w64.rot + originPhaseFlip) % 360 + 360) % 360;
        const syIdx = Math.floor(relAz64 / 5.625) % 64;
        const bits = getShaoYongBits(syIdx);
        const invBits = invertBits(bits);
        const invIdx = (syIdx + 32) % 64;
        const { N, N2, core } = computeNuclear(bits);

        const relAz60 = ((state.azDeg - state.w60.rot + originPhaseFlip) % 360 + 360) % 360;
        const jiaziIdx = Math.floor(relAz60 / 6.0) % 60;
        const jiaziName = `${STEMS[jiaziIdx % 10]}-${BRANCHES[jiaziIdx % 12]}`;

        const relAz16 = ((state.azDeg - state.w16.rot + originPhaseFlip) % 360 + 360) % 360;
        const comp16Idx = Math.floor(((relAz16 + 11.25) % 360) / 22.5) % 16;

        const txCm = tx / PX_PER_CM, tyCm = -ty / PX_PER_CM;
        const gxCm = gx / PX_PER_CM, gyCm = -gy / PX_PER_CM;

        document.getElementById('vp-nonius').textContent = `${signedNonius >= 0 ? '+' : ''}${signedNonius}`;
        document.getElementById('vp-area').textContent = `${signedAreaCm2 >= 0 ? '+' : ''}${signedAreaCm2.toFixed(1)} cm²`;
        document.getElementById('vp-az').textContent = `${state.azDeg.toFixed(2)}°`;
        document.getElementById('vp-rho').textContent = `${state.rhoCm >= 0 ? '+' : ''}${state.rhoCm.toFixed(2)} cm`;
        document.getElementById('hud-coord-mini').textContent = `[T: ${txCm >= 0 ? '+' : ''}${txCm.toFixed(2)}, ${tyCm >= 0 ? '+' : ''}${tyCm.toFixed(2)} cm | σ=${effSigmaY.toFixed(2)}]`;

        const parityText = isFlatOrigin
            ? "0.00 (PLAT IN OORSPRONG 0,0)"
            : (isNegativeSpace ? `${jacobian.toFixed(2)} (NEGATIEF DOOR OORSPRONG)` : `+${jacobian.toFixed(2)} (POSITIEF ROND)`);
        const parityCol = isFlatOrigin ? "#ffffff" : (isNegativeSpace ? "var(--neg-glow)" : "var(--mg-glow)");

        document.getElementById('origin-badge').textContent = `AS-PROJECTIE: ${effSigmaY >= 0 ? '+' : ''}${effSigmaY.toFixed(2)}`;
        document.getElementById('origin-badge').style.borderColor = parityCol;
        document.getElementById('origin-badge').style.color = parityCol;

        document.getElementById('res-arm-az').textContent = `${state.azDeg.toFixed(2)}° (${COMPASS_16[comp16Idx]})`;
        document.getElementById('res-arm-rho').textContent = `${state.rhoCm >= 0 ? '+' : ''}${state.rhoCm.toFixed(2)} cm (${(state.rhoCm * 2).toFixed(1)} vakjes)`;
        document.getElementById('res-tx-ty').textContent = `[${txCm >= 0 ? '+' : ''}${txCm.toFixed(2)}, ${tyCm >= 0 ? '+' : ''}${tyCm.toFixed(2)}] cm`;
        document.getElementById('res-gx-gy').textContent = `[${gxCm >= 0 ? '+' : ''}${gxCm.toFixed(2)}, ${gyCm >= 0 ? '+' : ''}${gyCm.toFixed(2)}] cm`;
        document.getElementById('res-angles').textContent = `α=${alphaDeg.toFixed(1)}° | β=${betaDeg.toFixed(1)}° | γ=${gammaDeg.toFixed(1)}°`;
        document.getElementById('res-jacobian').textContent = parityText;
        document.getElementById('res-jacobian').style.color = parityCol;
        document.getElementById('res-parity-bar').style.width = `${((effSigmaY + 1) / 2) * 100}%`;

        document.getElementById('res-iching-wheel').textContent = `#${syIdx} (${bits}) @ Δθ=${relAz64.toFixed(1)}°`;
        document.getElementById('res-iching-inv').textContent = `#${invIdx} (${invBits}) [Spiegel door 0,0]`;
        document.getElementById('res-jiazi-wheel').textContent = `${jiaziName} (#${jiaziIdx + 1}/60) @ Δθ=${relAz60.toFixed(1)}°`;
        document.getElementById('res-inner-wheel').textContent = `Ster: ${COMPASS_16[comp16Idx]} (#${comp16Idx}) | Kern ${core}→N²=${N2}`;

        const signedVakjes = signedAreaCm2 / 0.25;
        document.getElementById('res-nonius-badge').textContent = `${signedNonius >= 0 ? '+' : ''}${signedNonius} nonius`;
        document.getElementById('res-sector-area').textContent = `${signedAreaCm2 >= 0 ? '+' : ''}${signedAreaCm2.toFixed(2)} cm² (${signedVakjes >= 0 ? '+' : ''}${signedVakjes.toFixed(1)} vakjes)`;

        renderHexBars('vis-H', bits);
        renderHexBars('vis-N', N);
        renderHexBars('vis-N2', isNegativeSpace ? invBits : N2);
        document.getElementById('lbl-H').textContent = bits;
        document.getElementById('lbl-N').textContent = N;
        document.getElementById('lbl-N2').textContent = isNegativeSpace ? `${invBits} (H̄)` : N2;

        if (syncSliders) {
            document.getElementById('yaw-slider').value = state.azDeg.toFixed(1);
            document.getElementById('yaw-deg').innerText = `${state.azDeg.toFixed(1)}°`;
            document.getElementById('rho-slider').value = state.rhoCm.toFixed(2);
            document.getElementById('rho-val').innerText = `${state.rhoCm >= 0 ? '+' : ''}${state.rhoCm.toFixed(2)} cm`;
        }
    }

    function renderHexBars(elId, bits) {
        let h = '';
        for (let i = 0; i < 6; i++) {
            h += `<div class="bit-bar ${bits[i] === '0' ? 'bit-0' : ''}"></div>`;
        }
        document.getElementById(elId).innerHTML = h;
    }

    // --- 3. BEGINSTAND & OORSPRONG-INVERSIE ---
    function resetToBeginstand() {
        if (state.foldAnimTimer) toggleOriginFoldAnimation();
        state.azDeg = 0.0;
        state.rhoCm = R_KOMPAS_CM;
        state.globalSigmaY = 1.0;
        state.globalSigmaX = 1.0;
        state.w64.rot = 0.0; state.w64.tilt = 1.0;
        state.w60.rot = 0.0; state.w60.tilt = 1.0;
        state.w16.rot = 0.0; state.w16.tilt = 1.0;
        state.armStopped = false;
        state.mouseFollow = false;

        document.getElementById('slider-global-sigma').value = 1.0;
        document.getElementById('sigma-slider').value = 1.0;
        document.getElementById('lbl-sigma-state').textContent = "σ = +1.00";
        document.getElementById('lbl-global-sigma').textContent = "+1.00 (Rond)";
        document.getElementById('sigma-val').textContent = "+1.00";
        ['64', '60', '16'].forEach(w => {
            document.getElementById(`sl-rot-${w}`).value = 0;
            document.getElementById(`sl-tilt-${w}`).value = 1;
        });

        document.getElementById('arm-badge').textContent = "BEGINSTAND: 0.0° [0]";
        document.getElementById('res-arm-state').textContent = "BEGINSTAND OP CIRKEL [0]";
        updatePlanimeterFromPolar(true);
    }

    function setGlobalAxisFlatten(val) {
        const sigma = Math.max(-1.0, Math.min(1.0, parseFloat(val)));
        state.globalSigmaY = sigma;
        document.getElementById('slider-global-sigma').value = sigma;
        document.getElementById('sigma-slider').value = sigma;
        const desc = Math.abs(sigma) <= 0.02 ? "0.00 (PLAT DOOR OORSPRONG)" : (sigma < 0 ? `${sigma.toFixed(2)} (NEGATIEF)` : `+${sigma.toFixed(2)} (POSITIEF)`);
        document.getElementById('lbl-sigma-state').textContent = `σ = ${sigma >= 0 ? '+' : ''}${sigma.toFixed(2)}`;
        document.getElementById('lbl-global-sigma').textContent = desc;
        document.getElementById('sigma-val').textContent = `${sigma >= 0 ? '+' : ''}${sigma.toFixed(2)}`;
        document.getElementById('key-8').classList.toggle('mg-active', Math.abs(sigma) <= 0.02);
        document.getElementById('key-9').classList.toggle('neg-active', sigma <= -0.95);
        document.getElementById('key-7').classList.toggle('run-active', sigma >= 0.95);
        updatePlanimeterFromPolar(true);
    }

    function toggleOriginFoldAnimation() {
        const btn = document.getElementById('btn-fold-anim');
        const keyX = document.getElementById('key-x');
        if (state.foldAnimTimer) {
            clearInterval(state.foldAnimTimer);
            state.foldAnimTimer = null;
            btn.textContent = "🌀 Vouw door (0,0) [X]";
            keyX.classList.remove('neg-active');
        } else {
            btn.textContent = "⏹️ Stop Vouw [X]";
            keyX.classList.add('neg-active');
            state.foldAnimTimer = setInterval(() => {
                let nextSigma = state.globalSigmaY + state.foldDirection * 0.025;
                if (nextSigma <= -1.0) { nextSigma = -1.0; state.foldDirection = 1; }
                else if (nextSigma >= 1.0) { nextSigma = 1.0; state.foldDirection = -1; }
                setGlobalAxisFlatten(nextSigma);
            }, 30);
        }
    }

    function setWheelParam(wheelId, param, val) {
        const num = parseFloat(val);
        const wObj = wheelId === 64 ? state.w64 : (wheelId === 60 ? state.w60 : state.w16);
        if (param === 'rot') {
            wObj.rot = ((num % 360) + 360) % 360;
            document.getElementById(`sl-rot-${wheelId}`).value = wObj.rot;
        } else if (param === 'tilt') {
            wObj.tilt = Math.max(-1.0, Math.min(1.0, num));
            document.getElementById(`sl-tilt-${wheelId}`).value = wObj.tilt;
        }
        updatePlanimeterFromPolar(false);
    }

    function syncAllWheelsToZero() {
        ['64', '60', '16'].forEach(w => {
            setWheelParam(parseInt(w), 'rot', 0);
            setWheelParam(parseInt(w), 'tilt', 1.0);
        });
    }

    // --- 4. MAGNESIUM OVERTREK LAYER & STEMPEL-FUNCTIE ---
    function renderMagnesiumOvertrek() {
        const adaptToSigma = document.getElementById('chk-adapt-trace').checked;
        const effSigmaY = state.globalSigmaY * state.w64.tilt;
        let mHtml = '';

        if (state.omtrekPoints.length > 1) {
            const pts = state.omtrekPoints.map(pt => ({
                x: adaptToSigma ? pt.rawX_px * state.globalSigmaX : pt.x_px,
                y: adaptToSigma ? pt.rawY_px * effSigmaY : pt.y_px,
                gx: pt.gx_px, gy: pt.gy_px
            }));
            const dTracer = pts.map((p, i) => `${i === 0 ? 'M' : 'L'} ${p.x.toFixed(1)} ${p.y.toFixed(1)}`).join(' ');
            const strokeCol = effSigmaY < 0 ? "#ff3385" : "#50ffb0";
            mHtml += `<path d="${dTracer} Z" fill="rgba(80, 255, 176, 0.14)" stroke="${strokeCol}" stroke-width="2.5"/>`;
        }

        if (state.stampedNodes.length > 0) {
            const nodes = state.stampedNodes.map(n => ({
                ...n,
                drawX: adaptToSigma ? n.rawX_px * state.globalSigmaX : n.x_px,
                drawY: adaptToSigma ? n.rawY_px * effSigmaY : n.y_px
            }));
            if (nodes.length > 1) {
                const dPoly = nodes.map((n, i) => `${i === 0 ? 'M' : 'L'} ${n.drawX.toFixed(1)} ${n.drawY.toFixed(1)}`).join(' ');
                mHtml += `<path d="${dPoly} Z" fill="rgba(230, 255, 247, 0.08)" stroke="#50ffb0" stroke-width="1.8" stroke-dasharray="5,3"/>`;
            }
            nodes.forEach((n, idx) => {
                mHtml += `<circle cx="${n.drawX}" cy="${n.drawY}" r="7" fill="rgba(80,255,176,0.25)" stroke="#e6fff7" stroke-width="1.8"/>`;
                mHtml += `<text x="${n.drawX + 10}" y="${n.drawY - 8}" fill="#e6fff7" font-size="8.5" font-family="Courier New" font-weight="bold">M${idx+1} [${n.nonius}]</text>`;
            });
        }
        mgTracesGroup.innerHTML = mHtml;
    }

    function stampMagnesiumPoint() {
        const txCm = state.txPx / PX_PER_CM, tyCm = -state.tyPx / PX_PER_CM;
        const effSigmaY = state.globalSigmaY * state.w64.tilt;
        const isNeg = (state.globalSigmaX * effSigmaY * (state.rhoCm >= 0 ? 1 : -1)) < 0;
        const relAz64 = ((state.azDeg - state.w64.rot + (isNeg ? 180 : 0)) % 360 + 360) % 360;
        const syIdx = Math.floor(relAz64 / 5.625) % 64;
        const bits = getShaoYongBits(syIdx);
        const nonius = document.getElementById('vp-nonius').textContent;
        const rad = (state.azDeg - 90) * Math.PI / 180;

        const node = {
            idx: state.stampedNodes.length + 1,
            x_px: state.txPx, y_px: state.tyPx,
            rawX_px: Math.cos(rad) * (state.rhoCm * PX_PER_CM),
            rawY_px: Math.sin(rad) * (state.rhoCm * PX_PER_CM),
            gx_px: state.gxPx, gy_px: state.gyPx,
            x_cm: txCm, y_cm: tyCm,
            azDeg: state.azDeg, sigma: effSigmaY,
            nonius: nonius, syIdx: syIdx, bits: bits
        };
        state.stampedNodes.push(node);
        renderMagnesiumOvertrek();
        renderStampedTable();
    }

    function renderStampedTable() {
        const tbody = document.getElementById('res-trace-tbody');
        if (state.stampedNodes.length === 0) {
            tbody.innerHTML = `<tr><td colspan="6" style="text-align:center; color:#64748b; padding:6px;">Druk op [T] (Stempel) of klik op een van de 8 bestanden links.</td></tr>`;
            return;
        }
        tbody.innerHTML = state.stampedNodes.map(n => `
            <tr onclick="restoreStampedNode(${n.idx - 1})">
                <td style="color:var(--mg-glow); font-weight:bold;">M${n.idx}</td>
                <td>${n.x_cm.toFixed(1)}, ${n.y_cm.toFixed(1)}</td>
                <td>${n.azDeg.toFixed(1)}°</td>
                <td style="color:${n.sigma < 0 ? 'var(--neg-glow)' : 'var(--main)'}">${n.sigma >= 0 ? '+' : ''}${n.sigma.toFixed(2)}</td>
                <td style="color:var(--gold); font-weight:bold;">${n.nonius}</td>
                <td>#${n.syIdx} (${n.bits})</td>
            </tr>
        `).join('');
    }

    function restoreStampedNode(idx) {
        const n = state.stampedNodes[idx];
        if (!n) return;
        state.azDeg = n.azDeg;
        setGlobalAxisFlatten(n.sigma);
    }

    function renderLaserOptics(gx, gy, tx, ty, col) {
        if (!state.laserEnabled) { laserGroup.innerHTML = ''; return; }
        const armLen = Math.hypot(tx - gx, ty - gy) || 1;
        const ux = (tx - gx) / armLen, uy = (ty - gy) / armLen;
        const hitX = tx + ux * 260, hitY = ty + uy * 260;
        const nx = -uy, ny = ux;
        laserGroup.innerHTML = `<g filter="url(#laser-glow)">
            <line x1="${gx}" y1="${gy}" x2="${hitX}" y2="${hitY}" stroke="${col}" stroke-width="2.4" opacity="0.9"/>
            <line x1="${tx - nx * 70}" y1="${ty - ny * 70}" x2="${tx + nx * 70}" y2="${ty + ny * 70}" stroke="${col}" stroke-width="1.1" stroke-dasharray="2,4" opacity="0.75"/>
            <circle cx="${tx}" cy="${ty}" r="14" fill="none" stroke="${col}" stroke-width="1.5" stroke-dasharray="4,2"/>
        </g>`;
    }

    // --- 5. TOETSENBORD & PIJLTJES BESTURING ---
    function stepPolar(dAzDeg, dRhoCm) {
        state.armStopped = false;
        state.mouseFollow = false;
        state.azDeg = (state.azDeg + dAzDeg + 360) % 360;
        state.rhoCm = Math.max(-11.5, Math.min(11.5, state.rhoCm + dRhoCm));
        updatePlanimeterFromPolar(true);
    }

    function stopPlanimeterArm() {
        state.armStopped = true; state.mouseFollow = false;
        if (state.foldAnimTimer) toggleOriginFoldAnimation();
        document.getElementById('arm-badge').textContent = "ARM: STILGEZET [S]";
        document.getElementById('res-arm-state').textContent = "STILGEZET [S]";
        document.getElementById('key-s').classList.add('stop-active');
        document.getElementById('key-g').classList.remove('run-active');
        updatePlanimeterFromPolar(false);
    }

    function startPlanimeterArm() {
        state.armStopped = false; state.mouseFollow = true;
        document.getElementById('arm-badge').textContent = "ARM: VRIJ ACTIEF [G]";
        document.getElementById('res-arm-state').textContent = "ACTIEF (MUIS+TOETS)";
        document.getElementById('key-s').classList.remove('stop-active');
        document.getElementById('key-g').classList.add('run-active');
        updatePlanimeterFromPolar(false);
    }

    function flashKey(id) {
        const el = document.getElementById(id);
        if (!el) return;
        el.classList.add('pressed');
        setTimeout(() => el.classList.remove('pressed'), 140);
    }

    window.addEventListener('keydown', (e) => {
        if (document.activeElement && document.activeElement.id === 'ai-query') {
            if (e.key === 'Escape') document.activeElement.blur();
            return;
        }
        const azStep = e.altKey ? 5.625 : (e.shiftKey ? 0.1 : 1.0);
        const rhoStep = e.shiftKey ? 0.1 : 0.5;

        switch (e.key) {
            case '0': case 'Home': e.preventDefault(); flashKey('key-0'); resetToBeginstand(); break;
            case 'ArrowLeft': e.preventDefault(); flashKey('key-left'); stepPolar(-azStep, 0); break;
            case 'ArrowRight': e.preventDefault(); flashKey('key-right'); stepPolar(azStep, 0); break;
            case 'ArrowUp': e.preventDefault(); flashKey('key-up'); stepPolar(0, rhoStep); break;
            case 'ArrowDown': e.preventDefault(); flashKey('key-down'); stepPolar(0, -rhoStep); break;
            case '8': e.preventDefault(); flashKey('key-8'); setGlobalAxisFlatten(0.0); break;
            case '9': e.preventDefault(); flashKey('key-9'); setGlobalAxisFlatten(-1.0); break;
            case '7': e.preventDefault(); flashKey('key-7'); setGlobalAxisFlatten(1.0); break;
            case '-': case '_': e.preventDefault(); setGlobalAxisFlatten(state.globalSigmaY - 0.05); break;
            case '=': case '+': e.preventDefault(); setGlobalAxisFlatten(state.globalSigmaY + 0.05); break;
            case 'x': case 'X': e.preventDefault(); flashKey('key-x'); toggleOriginFoldAnimation(); break;
            case 'f': case 'F': e.preventDefault(); flashKey('key-f'); toggleFootprintPyramid(); break;
            case 'b': case 'B': e.preventDefault(); fitAssetToKompasCircle(); break;
            case 'q': case 'Q': e.preventDefault(); setWheelParam(64, 'rot', state.w64.rot - 5.625); break;
            case 'e': case 'E': e.preventDefault(); setWheelParam(64, 'rot', state.w64.rot + 5.625); break;
            case 'z': case 'Z': e.preventDefault(); setWheelParam(60, 'rot', state.w60.rot - 6.0); break;
            case 'c': case 'C': e.preventDefault(); setWheelParam(60, 'rot', state.w60.rot + 6.0); break;
            case 'u': case 'U': e.preventDefault(); setWheelParam(16, 'rot', state.w16.rot - 5.625); break;
            case 'i': case 'I': e.preventDefault(); setWheelParam(16, 'rot', state.w16.rot + 5.625); break;
            case ' ': case 's': case 'S': e.preventDefault(); flashKey('key-s'); stopPlanimeterArm(); break;
            case 'g': case 'G': e.preventDefault(); flashKey('key-g'); startPlanimeterArm(); break;
            case 't': case 'T': case 'Enter': e.preventDefault(); flashKey('key-t'); stampMagnesiumPoint(); break;
            case 'o': case 'O': e.preventDefault(); toggleOmtrekRecording(); break;
            case 'v': case 'V': e.preventDefault(); toggleResultsWindow(); break;
        }
    });

    function processKinematica(axis, val) {
        const num = parseFloat(val);
        if (axis === 'yaw') { state.azDeg = num; document.getElementById('yaw-deg').innerText = `${num.toFixed(1)}°`; }
        else if (axis === 'rho') { state.rhoCm = num; document.getElementById('rho-val').innerText = `${num >= 0 ? '+' : ''}${num.toFixed(2)} cm`; }
        else if (axis === 'pitch') { state.pitchDeg = num; document.getElementById('pitch-deg').innerText = `${num}° | 517.3nm`; svgEl.style.transform = `rotateX(${num}deg)`; return; }
        updatePlanimeterFromPolar(false);
    }

    function toggleOmtrekRecording() {
        state.recordingOmtrek = !state.recordingOmtrek;
        const btn = document.getElementById('btn-rec');
        if (state.recordingOmtrek) {
            state.omtrekPoints = [];
            btn.textContent = "⏺️ OVERTREK ACTIEF [O]";
            btn.classList.add('btn-stop');
            updatePlanimeterFromPolar(false);
        } else {
            btn.textContent = "✏️ START OVERTREK [O]";
            btn.classList.remove('btn-stop');
            renderMagnesiumOvertrek();
        }
    }

    function clearOmtrek() {
        state.recordingOmtrek = false;
        state.omtrekPoints = [];
        state.stampedNodes = [];
        document.getElementById('btn-rec').textContent = "✏️ START OVERTREK [O]";
        document.getElementById('btn-rec').classList.remove('btn-stop');
        renderMagnesiumOvertrek();
        renderStampedTable();
    }

    function toggleResultsWindow() {
        const win = document.getElementById('plano-results-window');
        win.style.display = win.style.display === 'none' ? 'flex' : 'none';
    }

    function minimizeResultsWindow() {
        document.getElementById('plano-results-window').classList.toggle('minimized');
    }

    (function initDraggableWindow() {
        const win = document.getElementById('plano-results-window');
        const handle = document.getElementById('win-drag-handle');
        let isDragging = false, startX = 0, startY = 0, initLeft = 0, initTop = 0;
        handle.addEventListener('mousedown', (e) => {
            isDragging = true;
            const rect = win.getBoundingClientRect(), parentRect = win.parentElement.getBoundingClientRect();
            initLeft = rect.left - parentRect.left; initTop = rect.top - parentRect.top;
            win.style.right = 'auto'; win.style.left = `${initLeft}px`; win.style.top = `${initTop}px`;
            startX = e.clientX; startY = e.clientY;
        });
        window.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            win.style.left = `${initLeft + (e.clientX - startX)}px`;
            win.style.top = `${Math.max(0, initTop + (e.clientY - startY))}px`;
        });
        window.addEventListener('mouseup', () => { isDragging = false; });
    })();

    function injectAI(content) {
        terminal.innerHTML += `<div class="ai-response">${content}</div>`;
        terminal.scrollTop = terminal.scrollHeight;
    }

    function handleQuery(e) {
        if (e.key === 'Enter' && e.target.value.trim()) {
            const q = e.target.value.trim().toLowerCase();
            terminal.innerHTML += `<div style="color:var(--main); font-size:0.7rem; margin-bottom:6px;">USER_QUERY: ${q}</div>`;
            e.target.value = ''; e.target.blur();
            if (q.includes('sleutel') || q.includes('vizier')) selectFundamentalAsset(0);
            else if (q.includes('5625') || q.includes('v3')) selectFundamentalAsset(3);
            else if (q.includes('64') || q.includes('nebra')) selectFundamentalAsset(7);
            else if (q.includes('breda')) selectFundamentalAsset(4);
            else if (q.includes('begin')) resetToBeginstand();
            else if (q.includes('plat')) setGlobalAxisFlatten(0.0);
            else if (q.includes('neg')) setGlobalAxisFlatten(-1.0);
        }
    }

    function exportCADReport() {
        const orderLines = FUNDAMENTAL_ASSETS.map((a, i) =>
            `${i+1}. [${a.rank}] ${a.name} | ${a.width_px}x${a.height_px}px (${a.width_vakjes}x${a.height_vakjes} vak) | ${a.area_cm2}cm² (${a.ott573_nonius}n) | Wet: ${a.lawTitle}`
        ).join('\n');
        const txt = [
            "=== VORTEX DASHBOARD v155.0 // FUNDAMENTELE ORDENING VAN DE 8 GEOCENTRUM ASSETS ===",
            `Tijdstip: ${new Date().toISOString()}`,
            "--- HIËRARCHISCHE PIRAMIDE VAN DE 8 BESTANDEN ---",
            orderLines,
            "--- ACTIEVE PLANIMETER-ARM TELEMETRIE ---",
            `Arm Draaihoek (Azimut): ${document.getElementById('res-arm-az').textContent}`,
            `Volgstift Coördinaten T(x,y): ${document.getElementById('res-tx-ty').textContent}`,
            `Oorsprong-Projectie (Sigma): ${document.getElementById('res-jacobian').textContent}`
        ].join('\n');
        const blob = new Blob([txt], { type: 'text/plain' });
        const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
        a.download = `vortex_fundamentele_ordening_8_assets.txt`; a.click();
    }

    svgEl.addEventListener('mousemove', (e) => {
        if (state.armStopped || !state.mouseFollow) return;
        const pt = svgEl.createSVGPoint();
        pt.x = e.clientX; pt.y = e.clientY;
        const cursor = pt.matrixTransform(svgEl.getScreenCTM().inverse());
        state.azDeg = (Math.atan2(cursor.y, cursor.x) * 180 / Math.PI + 90 + 360) % 360;
        state.rhoCm = Math.min(11.5, Math.hypot(cursor.x, cursor.y) / PX_PER_CM);
        updatePlanimeterFromPolar(true);
    });

    svgEl.addEventListener('dblclick', () => stampMagnesiumPoint());

    setInterval(() => {
        document.getElementById('clock').innerText = new Date().toLocaleTimeString('nl-NL');
    }, 1000);

    buildIndependentWheels();
    buildFundamentalOrderList();
    resetToBeginstand();
    updateActiveAssetOverlay();
    renderConcentricPyramid();
</script>

</body>
</html>
EOF
xdg-open ~/Bureaublad/geocentrum/vortex_fundamentele_ordening_v155.html 2>/dev/null &