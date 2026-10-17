#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.2 — Integrale Bugfix & Deployment Script"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
cd "$TARGET_DIR"

# 1. Schoningsregel voor .gitignore
if [ -f .gitignore ]; then
  sed -i '/\.pdf/d' .gitignore
  sed -i '/\.html/d' .gitignore
  sed -i '/\.js/d' .gitignore
  sed -i '/\.json/d' .gitignore
  sed -i '/\.geojson/d' .gitignore
  sed -i '/\.dxf/d' .gitignore
fi

# 2. Maak alle vereiste submappen aan
mkdir -p cockpittools systeemdiagnose/update pdf assets

# 3. Kopieer PDF-dossier vanuit Downloads indien aanwezig
if [ -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ]; then
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./naamloos_dossier.pdf
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./pdf/naamloos_dossier.pdf
fi

# 4. Synchroniseer bestanden naar root en submappen
[ -f vortex_bipolar_precision_dashboard.html ] && cp -f vortex_bipolar_precision_dashboard.html cockpittools/
[ -f mapglobe.html ] && cp -f mapglobe.html cockpittools/
[ -f modular_flower_layer.html ] && cp -f modular_flower_layer.html cockpittools/
[ -f nebra_mapanalyst_vortex155.html ] && cp -f nebra_mapanalyst_vortex155.html cockpittools/
[ -f update.html ] && cp -f update.html systeemdiagnose/update/

[ -f cockpittools/vortex_bipolar_precision_dashboard.html ] && cp -f cockpittools/vortex_bipolar_precision_dashboard.html ./
[ -f cockpittools/mapglobe.html ] && cp -f cockpittools/mapglobe.html ./
[ -f cockpittools/modular_flower_layer.html ] && cp -f cockpittools/modular_flower_layer.html ./
[ -f cockpittools/nebra_mapanalyst_vortex155.html ] && cp -f cockpittools/nebra_mapanalyst_vortex155.html ./
[ -f systeemdiagnose/update/update.html ] && cp -f systeemdiagnose/update/update.html ./

[ -f vortex_geodetic_refraction_report-v2.pdf ] && cp -f vortex_geodetic_refraction_report-v2.pdf pdf/
[ -f pdf/vortex_geodetic_refraction_report-v2.pdf ] && cp -f pdf/vortex_geodetic_refraction_report-v2.pdf ./

# 5. Genereer schone vercel.json
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
    { "source": "/bipolar", "destination": "/cockpittools/vortex_bipolar_precision_dashboard.html" },
    { "source": "/globe", "destination": "/cockpittools/mapglobe.html" },
    { "source": "/flower", "destination": "/cockpittools/modular_flower_layer.html" },
    { "source": "/update", "destination": "/systeemdiagnose/update/update.html" },
    { "source": "/nebra", "destination": "/cockpittools/nebra_mapanalyst_vortex155.html" },
    { "source": "/naamloos_dossier.pdf", "destination": "/pdf/naamloos_dossier.pdf" },
    { "source": "/vortex_geodetic_refraction_report-v2.pdf", "destination": "/pdf/vortex_geodetic_refraction_report-v2.pdf" }
  ]
}
JSON_EOF

# 6. Bouw de Omni Master Interface
cat << 'HTML_EOF' > vortex_omni_master_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.2 — Omni Master Interface</title>
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
  <h1>🌀 VORTEX OS v158.2 OMNI MASTER</h1>
  <div style="font-size: 0.72rem; color: #64748b; display:flex; gap:12px; align-items:center;">
    <span style="color:var(--green);">● DEPLOY: LIVE</span>
    <span>Gekoppeld aan Vercel Node Mathgeo-Seven</span>
  </div>
</header>
<main>
  <section class="sidebar">
    <h3 style="color:var(--gold); margin-bottom:0.2rem;">🧭 NAVIGATION HUB</h3>
    <a class="nav-item" href="/bipolar" target="viewport">🎯 Precision Cockpit (/bipolar)</a>
    <a class="nav-item" href="/globe" target="viewport">🌍 MapLibre 3D Globe (/globe)</a>
    <a class="nav-item" href="/flower" target="viewport">🌸 k=7 Caustic Layer (/flower)</a>
    <a class="nav-item" href="/clean" target="viewport">🖥️ Clean Quad Grid (/clean)</a>
    <a class="nav-item" href="/update" target="viewport" style="color:var(--green); border-color:var(--green);">📡 OSINT Telemetrie (/update)</a>
    <a class="nav-item" href="/nebra" target="viewport" style="color:var(--magenta); border-color:var(--magenta);">🌌 Nebra Pleiaden (/nebra)</a>
    <a class="nav-item" href="/vortex_geodetic_refraction_report-v2.pdf" target="viewport" style="color:var(--gold); border-color:var(--gold);">📄 PDF Audit Rapport v2</a>
    <a class="nav-item" href="/naamloos_dossier.pdf" target="viewport" style="color:var(--cyan); border-color:var(--cyan);">📄 Nieuw Dossier PDF</a>
  </section>

  <section class="frame-container">
    <iframe name="viewport" src="/bipolar"></iframe>
  </section>

  <section class="sidebar right">
    <h3 style="color:var(--gold); margin-bottom:0.5rem;">📊 SYSTEM STATUS</h3>
    <p><strong>Manifest Versie:</strong> 158.2.0</p>
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

# 7. Dwing Git staging van alle extensies
git add -f *.html *.pdf *.js *.json *.geojson *.dxf 2>/dev/null || true
git add -f cockpittools/ systeemdiagnose/ pdf/ assets/ 2>/dev/null || true

# 8. Commit en voer deploy uit
git commit -m "Fix 404 & EOF bugs: Integrale Vercel routing en PDF sync" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./push_geocentrum_main.sh" ]; then
  ./push_geocentrum_main.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Integrale bugfix voltooid en gepusht naar Vercel!"
echo "======================================================================"
