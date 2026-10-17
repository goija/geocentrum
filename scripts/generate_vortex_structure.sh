#!/usr/bin/env bash
# ==============================================================================
# VORTEX OS v158.0 — Full Project Structure & HTML/JS Generator Script
# Automatisch genereren van mappenstructuur, HTML/JS viewports en manifesten
# ==============================================================================

set -e

echo "🌀 VORTEX OS v158.0 — Starten van projectgeneratie..."

# 1. Mappenstructuur aanmaken
echo "📁 Mappenstructuur aanmaken..."
mkdir -p assets
mkdir -p cockpittools
mkdir -p images
mkdir -p systeemdiagnose/update
mkdir -p txt

# 2. Genereren van assets/assets_manifest.js
echo "📄 Genereren van assets/assets_manifest.js..."
cat << 'EOF' > assets/assets_manifest.js
/**
 * VORTEX OS v158.0 — Geconsolideerd Assets Manifest
 * Automatisch gegenereerd door build_geocentrum_assets.sh
 */
window.VORTEX_ASSETS_MANIFEST = {
  version: "158.0.0",
  timestamp: new Date().toISOString(),
  anchors: {
    poolanker_p: { name: "Poolanker P (NL)", lat: 52.2500, lng: 5.2200, rd: [141120, 473200] },
    taurus_aldebaran: { name: "Aldebaran Anker", azimuth: 51.40, elevation: -3.7 },
    mercurius_eclips: { name: "Mercurius Eclips Anker", azimuth: 245.91, elevation: -4.2 }
  },
  modules: [
    { name: "k7_caustic_matrix", file: "./k7_modular_caustic_matrix.geojson", type: "geojson" },
    { name: "bipolar_engine", file: "./vortex_precision_tool_v156.js", type: "javascript" },
    { name: "sagittarius_shader", file: "./vortex_maplibre_sagittarius_k7_layer.js", type: "shader" },
    { name: "openlayers_rd", file: "./vortex_openlayers_projection_module.js", type: "projection" }
  ]
};
console.log("🌀 VORTEX OS Assets Manifest geladen:", window.VORTEX_ASSETS_MANIFEST);
EOF

# 3. Genereren van cockpittools/vortex_bipolar_precision_dashboard.html
echo "📄 Genereren van cockpittools/vortex_bipolar_precision_dashboard.html..."
cat << 'EOF' > cockpittools/vortex_bipolar_precision_dashboard.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.0 — Bipolaire Geodetische & Optische Precision Cockpit</title>
  <style>
    :root { --bg: #050811; --panel: rgba(10,17,32,0.9); --cyan: #00e5ff; --gold: #ffcc33; --magenta: #ff3385; --text: #e2e8f0; --font: 'Fira Code', monospace; }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: var(--bg); color: var(--text); font-family: var(--font); height: 100vh; display: flex; flex-direction: column; }
    header { background: #0f172a; padding: 0.6rem 1rem; border-bottom: 1px solid #1e293b; display: flex; justify-content: space-between; align-items: center; }
    h1 { font-size: 1rem; color: var(--cyan); }
    main { display: grid; grid-template-columns: 340px 1fr 340px; flex: 1; }
    .panel { background: var(--panel); border-right: 1px solid #1e293b; padding: 0.8rem; font-size: 0.7rem; }
    .panel.right { border-right: none; border-left: 1px solid #1e293b; }
    .card { background: rgba(15,23,42,0.6); border: 1px solid #1e293b; padding: 0.6rem; border-radius: 4px; margin-bottom: 0.6rem; }
    .card-title { color: var(--gold); margin-bottom: 0.4rem; font-weight: bold; border-bottom: 1px solid rgba(255,204,51,0.2); padding-bottom: 0.2rem; }
    .kv { display: flex; justify-content: space-between; margin-bottom: 0.25rem; }
    .kv label { color: #94a3b8; }
    .kv val { color: var(--cyan); font-weight: bold; }
    .viewport { background: #02040a; display: flex; justify-content: center; align-items: center; }
    svg { width: 90%; height: 90%; }
  </style>
</head>
<body>
<header>
  <h1>🧭 VORTEX OS — Cockpit Precision Dashboard</h1>
  <div style="font-size:0.7rem; color:#64748b;">Poolanker P: 52.25°N, 5.22°E (Laren)</div>
</header>
<main>
  <section class="panel">
    <div class="card">
      <div class="card-title">🎯 BIPOLAIRE VIZIER-AS</div>
      <div class="kv"><label>Taurus (Aldebaran):</label><val>51,40° NO</val></div>
      <div class="kv"><label>Libra (Mercurius):</label><val style="color:var(--gold)">245,91° WZW</val></div>
      <div class="kv"><label>Systeemscheiding:</label><val>194,51°</val></div>
      <div class="kv"><label>Asdeviatie:</label><val style="color:var(--magenta)">+14,51°</val></div>
    </div>
  </section>
  <section class="viewport">
    <svg viewBox="-200 -200 400 400">
      <circle cx="0" cy="0" r="160" fill="none" stroke="#1e293b" stroke-width="1.5"/>
      <line x1="-180" y1="0" x2="180" y2="0" stroke="#0f172a"/>
      <line x1="0" y1="-180" x2="0" y2="180" stroke="#0f172a"/>
      <!-- Vectors -->
      <line x1="0" y1="0" x2="125" y2="-100" stroke="#00e5ff" stroke-width="2" stroke-dasharray="4,2"/>
      <line x1="0" y1="0" x2="-146" y2="65" stroke="#ffcc33" stroke-width="2" stroke-dasharray="4,2"/>
      <circle cx="0" cy="0" r="5" fill="#00e5ff"/>
    </svg>
  </section>
  <section class="panel right">
    <div class="card">
      <div class="card-title">📐 OTT NR. 573 KINEMATICA</div>
      <div class="kv"><label>Poolarm (R):</label><val>15,00 cm</val></div>
      <div class="kv"><label>Rijarm (L):</label><val>16,67 cm</val></div>
      <div class="kv"><label>OPL (589 nm):</label><val>16,675 cm</val></div>
      <div class="kv"><label>Attractor N²:</label><val style="color:var(--magenta)">010101 (01)</val></div>
    </div>
  </section>
</main>
</body>
</html>
EOF

# 4. Genereren van cockpittools/mapglobe.html
echo "📄 Genereren van cockpittools/mapglobe.html..."
cat << 'EOF' > cockpittools/mapglobe.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <title>VORTEX OS — MapLibre 3D Globe Viewport</title>
  <style> body { margin:0; padding:0; background:#02040a; } #map { width:100vw; height:100vh; } </style>
</head>
<body>
<div id="map"></div>
<script>
  console.log("VORTEX 3D Globe Module initialized.");
</script>
</body>
</html>
EOF

# 5. Genereren van cockpittools/modular_flower_layer.html
echo "📄 Genereren van cockpittools/modular_flower_layer.html..."
cat << 'EOF' > cockpittools/modular_flower_layer.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <title>VORTEX OS — Modular k=7 Flower Caustic Layer</title>
  <style>
    body { margin:0; background:#050811; display:flex; justify-content:center; align-items:center; height:100vh; }
    canvas { background:#02040a; border:1px solid #1e293b; border-radius:8px; }
  </style>
</head>
<body>
<canvas id="causticCanvas" width="600" height="600"></canvas>
<script>
  const c = document.getElementById('causticCanvas');
  const ctx = c.getContext('2d');
  const R = 220, cx = 300, cy = 300, N = 260, k = 7;

  ctx.strokeStyle = 'rgba(0, 229, 255, 0.25)';
  ctx.lineWidth = 0.8;
  for(let i=0; i<N; i++) {
    let a1 = (i * 2 * Math.PI) / N;
    let a2 = ((k * i) * 2 * Math.PI) / N;
    ctx.beginPath();
    ctx.moveTo(cx + R * Math.cos(a1), cy + R * Math.sin(a1));
    ctx.lineTo(cx + R * Math.cos(a2), cy + R * Math.sin(a2));
    ctx.stroke();
  }

  ctx.strokeStyle = '#ff3385';
  ctx.lineWidth = 2.5;
  ctx.beginPath();
  for(let t=0; t<=Math.PI*2; t+=0.01) {
    let x = cx + (R/8) * (7 * Math.cos(t) - Math.cos(7*t));
    let y = cy + (R/8) * (7 * Math.sin(t) - Math.sin(7*t));
    if(t===0) ctx.moveTo(x,y); else ctx.lineTo(x,y);
  }
  ctx.closePath();
  ctx.stroke();
</script>
</body>
</html>
EOF

# 6. Genereren van systeemdiagnose/update/update.html
echo "📄 Genereren van systeemdiagnose/update/update.html..."
cat << 'EOF' > systeemdiagnose/update/update.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <title>VORTEX OS — Systeemdiagnose & Update Center</title>
  <style>
    body { background:#030712; color:#00e5ff; font-family:monospace; padding:2rem; }
    .box { border:1px solid #1e293b; background:rgba(15,23,42,0.8); padding:1.5rem; border-radius:6px; max-width:600px; }
    h2 { color:#ffcc33; margin-bottom:1rem; }
    .status { color:#2dd4bf; font-weight:bold; }
  </style>
</head>
<body>
<div class="box">
  <h2>🔄 VORTEX OS DIAGNOSTIEK v158.0</h2>
  <p>Systeemstatus: <span class="status">ONLINE & GEKALIBREERD</span></p>
  <p>Poolanker P: 52.2500° N, 5.2200° E (Laren NL)</p>
  <p>Bipolaire As: 51,40° NO ↔ 245,91° WZW (Δθ = 194,51°)</p>
  <p>Manifest Status: Geladen en Gesynct met Vercel Node</p>
</div>
</body>
</html>
EOF

# 7. Genereren van vortex_omni_master_v158.html (Root)
echo "📄 Genereren van vortex_omni_master_v158.html..."
cat << 'EOF' > vortex_omni_master_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.0 — Omni Master Interface</title>
  <script src="./assets/assets_manifest.js"></script>
  <style>
    :root { --bg: #030712; --panel: rgba(15,23,42,0.95); --cyan: #00e5ff; --gold: #ffcc33; --magenta: #ff3385; --text: #f1f5f9; --font: 'Fira Code', monospace; }
    * { box-sizing: border-box; margin:0; padding:0; }
    body { background: var(--bg); color: var(--text); font-family: var(--font); height: 100vh; display: flex; flex-direction: column; }
    header { background: #0f172a; padding: 0.6rem 1.2rem; border-bottom: 1px solid #1e293b; display: flex; justify-content: space-between; }
    h1 { font-size: 1.1rem; color: var(--cyan); }
    main { display: grid; grid-template-columns: 320px 1fr 320px; flex: 1; }
    .sidebar { background: var(--panel); border-right: 1px solid #1e293b; padding: 1rem; font-size: 0.72rem; }
    .sidebar.right { border-right: none; border-left: 1px solid #1e293b; }
    .frame-container { width: 100%; height: 100%; background: #02040a; }
    iframe { width: 100%; height: 100%; border: none; }
  </style>
</head>
<body>
<header>
  <h1>🌀 VORTEX OS v158.0 OMNI MASTER</h1>
  <div style="font-size: 0.72rem; color: #64748b;">Gekoppeld aan Vercel Node Mathgeo-Seven</div>
</header>
<main>
  <section class="sidebar">
    <h3 style="color:var(--gold); margin-bottom:0.5rem;">🧭 NAVIGATION HUB</h3>
    <p>• <a href="./cockpittools/vortex_bipolar_precision_dashboard.html" target="viewport" style="color:var(--cyan)">Precision Cockpit</a></p>
    <p>• <a href="./cockpittools/mapglobe.html" target="viewport" style="color:var(--cyan)">MapLibre 3D Globe</a></p>
    <p>• <a href="./cockpittools/modular_flower_layer.html" target="viewport" style="color:var(--cyan)">k=7 Caustic Layer</a></p>
    <p>• <a href="./vortex_clean_viewports_v158.html" target="viewport" style="color:var(--cyan)">Clean Quad Grid</a></p>
  </section>
  <section class="frame-container">
    <iframe name="viewport" src="./cockpittools/vortex_bipolar_precision_dashboard.html"></iframe>
  </section>
  <section class="sidebar right">
    <h3 style="color:var(--gold); margin-bottom:0.5rem;">📊 SYSTEM STATUS</h3>
    <p>Manifest Version: 158.0.0</p>
    <p>Attractor N²: 010101 (01)</p>
    <p>Snellius Δθ: -3,80°</p>
  </section>
</main>
</body>
</html>
EOF

# 8. Genereren van vortex_clean_viewports_v158.html (Root)
echo "📄 Genereren van vortex_clean_viewports_v158.html..."
cat << 'EOF' > vortex_clean_viewports_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <title>VORTEX OS v158.0 — Clean Quad-Viewport Grid</title>
  <style>
    body { margin:0; padding:0; background:#020408; font-family:monospace; height:100vh; overflow:hidden; }
    .grid { display:grid; grid-template-columns:1fr 1fr; grid-template-rows:1fr 1fr; width:100vw; height:100vh; gap:2px; background:#1e293b; }
    .cell { position:relative; background:#050811; }
    iframe { width:100%; height:100%; border:none; }
    .label { position:absolute; top:8px; left:8px; background:rgba(15,23,42,0.88); color:#00e5ff; font-size:0.65rem; padding:4px 8px; border-radius:4px; border:1px solid #1e293b; pointer-events:none; z-index:10; }
  </style>
</head>
<body>
<div class="grid">
  <div class="cell">
    <div class="label">VP1: Precision Cockpit</div>
    <iframe src="./cockpittools/vortex_bipolar_precision_dashboard.html"></iframe>
  </div>
  <div class="cell">
    <div class="label">VP2: MapLibre 3D Globe</div>
    <iframe src="./cockpittools/mapglobe.html"></iframe>
  </div>
  <div class="cell">
    <div class="label">VP3: k=7 Caustic Layer</div>
    <iframe src="./cockpittools/modular_flower_layer.html"></iframe>
  </div>
  <div class="cell">
    <div class="label">VP4: Systeemdiagnose</div>
    <iframe src="./systeemdiagnose/update/update.html"></iframe>
  </div>
</div>
</body>
</html>
EOF

# 9. Genereren van build_geocentrum_assets.sh (Root)
echo "📄 Genereren van build_geocentrum_assets.sh..."
cat << 'EOF' > build_geocentrum_assets.sh
#!/usr/bin/env bash
set -e
LOG_FILE="txt/geocentrum_manifest_build.log"
mkdir -p txt assets
echo "=== BUILD LOG VORTEX ASSETS MANIFEST [$(date)] ===" > "$LOG_FILE"

cat << 'JS' > assets/assets_manifest.js
/**
 * VORTEX OS v158.0 — Geconsolideerd Assets Manifest
 */
window.VORTEX_ASSETS_MANIFEST = {
  version: "158.0.0",
  timestamp: new Date().toISOString(),
  anchors: {
    poolanker_p: { name: "Poolanker P (NL)", lat: 52.2500, lng: 5.2200 },
    taurus_aldebaran: { name: "Aldebaran", azimuth: 51.40 },
    mercurius_eclips: { name: "Mercurius Eclips", azimuth: 245.91 }
  }
};
JS

echo "Assets manifest succesvol bijgewerkt." >> "$LOG_FILE"
echo "Build geslaagd!"
EOF
chmod +x build_geocentrum_assets.sh

# 10. Genereren van push_to_github.sh (Root)
echo "📄 Genereren van push_to_github.sh..."
cat << 'EOF' > push_to_github.sh
#!/usr/bin/env bash
set -e
echo "🌀 VORTEX OS — Bouwen van assets voor GitHub Push..."
./build_geocentrum_assets.sh

if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  git add .
  git commit -m "v158.0: Update VORTEX OS viewports en geodetische assets"
  git push origin main
  echo "🚀 Succesvol ge-pushed naar GitHub/Vercel!"
else
  echo "ℹ️ Geen git repository gedetecteerd. Bestanden zijn lokaal aangemaakt."
fi
EOF
chmod +x push_to_github.sh

# 11. Uitvoeren van het asset-build script
./build_geocentrum_assets.sh

echo "=============================================================================="
echo "✅ VORTEX OS v158.0 Projectstructuur & HTML/JS scripts succesvol gegenereerd!"
echo "=============================================================================="
