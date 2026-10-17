#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.3 — Definitief Herstel Asset- & Routestructuur"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
cd "$TARGET_DIR"

# 1. Schoon .gitignore op
if [ -f .gitignore ]; then
  sed -i '/\.pdf/d' .gitignore
  sed -i '/\.html/d' .gitignore
  sed -i '/\.js/d' .gitignore
  sed -i '/\.json/d' .gitignore
  sed -i '/\.geojson/d' .gitignore
  sed -i '/\.dxf/d' .gitignore
  sed -i '/\.png/d' .gitignore
fi

# 2. Maak alle vereiste fysieke submappen aan
mkdir -p cockpittools systeemdiagnose/update pdf assets

# 3. Synchroniseer het PDF-dossier vanuit Downloads
if [ -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ]; then
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./naamloos_dossier.pdf
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./pdf/naamloos_dossier.pdf
fi

# 4. KOPIEER ALLE HTML, JS EN ASSETS NAAR ZOWEL DE ROOT ALS DE SUBMAPPEN
echo "📦 Kopiëren van dashboards en scripts naar root en submappen..."

for file in vortex_bipolar_precision_dashboard.html mapglobe.html modular_flower_layer.html nebra_mapanalyst_vortex155.html; do
  [ -f "$file" ] && cp -f "$file" cockpittools/
  [ -f "cockpittools/$file" ] && cp -f "cockpittools/$file" ./
done

[ -f update.html ] && cp -f update.html systeemdiagnose/update/
[ -f systeemdiagnose/update/update.html ] && cp -f systeemdiagnose/update/update.html ./

# Kopieer ondersteunende JS-, PNG-, DXF- en GeoJSON-bestanden naar cockpittools/ en root
cp -f *.js cockpittools/ 2>/dev/null || true
cp -f *.geojson cockpittools/ 2>/dev/null || true
cp -f *.png cockpittools/ 2>/dev/null || true
cp -f *.dxf cockpittools/ 2>/dev/null || true

cp -f *.pdf pdf/ 2>/dev/null || true
cp -f pdf/*.pdf ./ 2>/dev/null || true
cp -f assets_manifest.js assets/ 2>/dev/null || true

# 5. Genereer vercel.json
cat << 'JSON_EOF' > vercel.json
{
  "version": 2,
  "name": "geocentrum-vortex-os",
  "cleanUrls": true,
  "trailingSlash": false,
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Access-Control-Allow-Origin", "value": "*" },
        { "key": "Cache-Control", "value": "public, max-age=3600, s-maxage=86400" }
      ]
    }
  ],
  "rewrites": [
    { "source": "/", "destination": "/vortex_omni_master_v158.html" },
    { "source": "/clean", "destination": "/vortex_clean_viewports_v158.html" },
    { "source": "/bipolar", "destination": "/vortex_bipolar_precision_dashboard.html" },
    { "source": "/globe", "destination": "/mapglobe.html" },
    { "source": "/flower", "destination": "/modular_flower_layer.html" },
    { "source": "/update", "destination": "/update.html" },
    { "source": "/nebra", "destination": "/nebra_mapanalyst_vortex155.html" },
    { "source": "/naamloos_dossier.pdf", "destination": "/naamloos_dossier.pdf" },
    { "source": "/vortex_geodetic_refraction_report-v2.pdf", "destination": "/vortex_geodetic_refraction_report-v2.pdf" }
  ]
}
JSON_EOF

# 6. Herbouw de Omni Master Interface
cat << 'HTML_EOF' > vortex_omni_master_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.3 — Omni Master Interface</title>
  <script src="./assets_manifest.js"></script>
  <script src="./assets/assets_manifest.js"></script>
  <style>
    :root { 
      --bg: #030712; 
      --panel: rgba(15,23,42,0.95); 
      --cyan: #00e5ff; 
      --gold: #ffcc33; 
      --magenta: #ff3385; 
      --green: #00ff88;
      --text: #f1f5f9; 
      --font: 'Fira Code', monospace; 
    }
    * { box-sizing: border-box; margin:0; padding:0; }
    body { 
      background: var(--bg); 
      color: var(--text); 
      font-family: var(--font); 
      height: 100vh; 
      display: flex; 
      flex-direction: column; 
    }
    header { 
      background: #0f172a; 
      padding: 0.6rem 1.2rem; 
      border-bottom: 1px solid #1e293b; 
      display: flex; 
      justify-content: space-between; 
      align-items: center;
    }
    h1 { font-size: 1.1rem; color: var(--cyan); }
    main { 
      display: grid; 
      grid-template-columns: 320px 1fr 320px; 
      flex: 1; 
    }
    .sidebar { 
      background: var(--panel); 
      border-right: 1px solid #1e293b; 
      padding: 1rem; 
      font-size: 0.75rem; 
      display: flex;
      flex-direction: column;
      gap: 0.6rem;
      overflow-y: auto;
    }
    .sidebar.right { 
      border-right: none; 
      border-left: 1px solid #1e293b; 
    }
    .nav-item {
      display: block;
      padding: 8px 12px;
      background: rgba(255,255,255,0.03);
      border: 1px solid rgba(0,229,255,0.25);
      border-radius: 4px;
      color: var(--cyan);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.2s ease;
    }
    .nav-item:hover {
      background: rgba(0,229,255,0.15);
      border-color: var(--cyan);
      transform: translateX(2px);
    }
    .frame-container { 
      width: 100%; 
      height: 100%; 
      background: #02040a; 
    }
    iframe { 
      width: 100%; 
      height: 100%; 
      border: none; 
    }
  </style>
</head>
<body>
<header>
  <h1>🌀 VORTEX OS v158.3 OMNI MASTER</h1>
  <div style="font-size: 0.72rem; color: #64748b; display:flex; gap:12px; align-items:center;">
    <span style="color:var(--green);">● DEPLOY: LIVE (OK)</span>
    <span>Gekoppeld aan Vercel Node Mathgeo-Seven</span>
  </div>
</header>
<main>
  <section class="sidebar">
    <h3 style="color:var(--gold); margin-bottom:0.2rem;">🧭 NAVIGATION HUB</h3>
    <a class="nav-item" href="./vortex_bipolar_precision_dashboard.html" target="viewport">🎯 Precision Cockpit (/bipolar)</a>
    <a class="nav-item" href="./mapglobe.html" target="viewport">🌍 MapLibre 3D Globe (/globe)</a>
    <a class="nav-item" href="./modular_flower_layer.html" target="viewport">🌸 k=7 Caustic Layer (/flower)</a>
    <a class="nav-item" href="./vortex_clean_viewports_v158.html" target="viewport">🖥️ Clean Quad Grid (/clean)</a>
    <a class="nav-item" href="./update.html" target="viewport" style="color:var(--green); border-color:var(--green);">📡 OSINT Telemetrie (/update)</a>
    <a class="nav-item" href="./nebra_mapanalyst_vortex155.html" target="viewport" style="color:var(--magenta); border-color:var(--magenta);">🌌 Nebra Pleiaden (/nebra)</a>
    <a class="nav-item" href="./vortex_geodetic_refraction_report-v2.pdf" target="viewport" style="color:var(--gold); border-color:var(--gold);">📄 PDF Audit Rapport v2</a>
    <a class="nav-item" href="./naamloos_dossier.pdf" target="viewport" style="color:var(--cyan); border-color:var(--cyan);">📄 Nieuw Dossier PDF</a>
  </section>

  <section class="frame-container">
    <iframe name="viewport" src="./vortex_bipolar_precision_dashboard.html"></iframe>
  </section>

  <section class="sidebar right">
    <h3 style="color:var(--gold); margin-bottom:0.5rem;">📊 SYSTEM STATUS</h3>
    <p><strong>Manifest Versie:</strong> 158.3.0</p>
    <p><strong>Attractor N²:</strong> 010101 (Hex #21)</p>
    <p><strong>Snellius Δθ:</strong> -3,80° (Biskaje)</p>
    <p><strong>Laserlijn:</strong> 589,0 nm (D-line)</p>
    <p><strong>RD-Oorsprong:</strong> 155000, 463000</p>
  </section>
</main>
</body>
</html>
HTML_EOF

cp -f vortex_omni_master_v158.html index.html

# 7. Dwing Git staging van ALLE bestanden
git add -f *.html *.pdf *.js *.json *.geojson *.dxf *.png 2>/dev/null || true
git add -f cockpittools/ systeemdiagnose/ pdf/ assets/ 2>/dev/null || true

# 8. Commit en voer deploy uit
git commit -m "Fix all routes: Dual path sync HTML/JS/CSS/PDF to eliminate 404s" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./push_geocentrum_main.sh" ]; then
  ./push_geocentrum_main.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Definitieve route- & asset-fix voltooid en live gepusht naar Vercel!"
echo "======================================================================"
