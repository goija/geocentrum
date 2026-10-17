#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.7 — Integrale Master Cockpit met Alle Koppelingen"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 1. Opschonen .gitignore
if [ -f .gitignore ]; then
  sed -i '/\.pdf/d' .gitignore
  sed -i '/\.html/d' .gitignore
  sed -i '/\.js/d' .gitignore
  sed -i '/\.json/d' .gitignore
  sed -i '/\.geojson/d' .gitignore
  sed -i '/\.dxf/d' .gitignore
  sed -i '/\.png/d' .gitignore
  sed -i '/\.log/d' .gitignore
  sed -i '/\.txt/d' .gitignore
fi

# 2. Fysieke submappen aanmaken
mkdir -p cockpittools systeemdiagnose/update pdf assets

# 3. PDF dossier uit Downloads kopieren
if [ -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ]; then
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./naamloos_dossier.pdf
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./pdf/naamloos_dossier.pdf
fi

# 4. Telemetrie logbestanden initialiseren
touch vortex_telemetry.log
cp -f vortex_telemetry.log vortex_telemetry.txt 2>/dev/null || true

# 5. Dual-path synchronisatie van alle HTML-, JS-, GeoJSON-, DXF- en PDF-bestanden
cp -f *.js cockpittools/ 2>/dev/null || true
cp -f *.geojson cockpittools/ 2>/dev/null || true
cp -f *.png cockpittools/ 2>/dev/null || true
cp -f *.dxf cockpittools/ 2>/dev/null || true

cp -f *.pdf pdf/ 2>/dev/null || true
cp -f pdf/*.pdf ./ 2>/dev/null || true
cp -f assets_manifest.js assets/ 2>/dev/null || true

# 6. Schrijf de geconsolideerde vercel.json rewrites
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
    { "source": "/vortex_geodetic_refraction_report-v2.pdf", "destination": "/vortex_geodetic_refraction_report-v2.pdf" },
    { "source": "/vortex_telemetry.log", "destination": "/vortex_telemetry.log" },
    { "source": "/vortex_telemetry.txt", "destination": "/vortex_telemetry.txt" }
  ]
}
JSON_EOF

# 7. Git Staging & Push naar Vercel
git add -f *.html *.pdf *.js *.json *.geojson *.dxf *.png *.log *.txt 2>/dev/null || true
git add -f cockpittools/ systeemdiagnose/ pdf/ assets/ 2>/dev/null || true

git commit -m "Build complete Omni Cockpit v158.7 with all connections and Admin Hub" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./push_geocentrum_main.sh" ]; then
  ./push_geocentrum_main.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Volledige Omni Master Cockpit v158.7 met alle koppelingen live op Vercel!"
echo "======================================================================"
