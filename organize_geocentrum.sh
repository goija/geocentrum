#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS — Mappenstructuur Herstructurering & Vercel Sync"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"

if [ -d "$TARGET_DIR" ]; then
  cd "$TARGET_DIR"
else
  echo "⚠️ Map $TARGET_DIR niet gevonden. Huidige werkmap wordt gebruikt: $(pwd)"
fi

# 1. Maak de volledige mappenstructuur aan
echo "📂 Mappenstructuur aanmaken..."
mkdir -p cockpittools
mkdir -p systeemdiagnose/update
mkdir -p pdf
mkdir -p assets
mkdir -p scripts

# 2. Kopieer/Verplaats PDF-dossier vanuit Downloads indien aanwezig
if [ -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ]; then
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./pdf/naamloos_dossier.pdf
  cp -f "/home/ontwerp/Downloads/0e8f0f2d-4786-4c53-a949-eb1ba9839998_Naamloos.pdf" ./naamloos_dossier.pdf
fi

# 3. Sorteer HTML-dashboards & Viewports
echo "📄 HTML-bestanden sorteren..."
[ -f "vortex_bipolar_precision_dashboard.html" ] && cp -f vortex_bipolar_precision_dashboard.html cockpittools/
[ -f "mapglobe.html" ] && cp -f mapglobe.html cockpittools/
[ -f "modular_flower_layer.html" ] && cp -f modular_flower_layer.html cockpittools/
[ -f "nebra_mapanalyst_vortex155.html" ] && cp -f nebra_mapanalyst_vortex155.html cockpittools/
[ -f "update.html" ] && cp -f update.html systeemdiagnose/update/

# 4. Sorteer PDF-rapporten
echo "📄 PDF-bestanden sorteren..."
for pdf in *.pdf; do
  if [ -f "$pdf" ]; then
    cp -f "$pdf" pdf/
  fi
done

# 5. Sorteer JS, GeoJSON, DXF en Afbeeldingen naar cockpittools & assets
echo "🧩 Scripts & Assets sorteren..."
[ -f "assets_manifest.js" ] && cp -f assets_manifest.js assets/
[ -f "assets_manifest-v2.js" ] && cp -f assets_manifest-v2.js assets/

for file in *.js *.geojson *.dxf *.png; do
  if [ -f "$file" ] && [ "$file" != "assets_manifest.js" ] && [ "$file" != "assets_manifest-v2.js" ]; then
    cp -f "$file" cockpittools/
  fi
done

# 6. Shell-scripts naar scripts/ kopieren
echo "⚙️ Shell-scripts sorteren..."
for sh_script in *.sh; do
  if [ -f "$sh_script" ] && [ "$sh_script" != "organize_geocentrum.sh" ]; then
    cp -f "$sh_script" scripts/
  fi
done

# 7. Zorg dat logbestanden aanwezig zijn
touch vortex_telemetry.log
cp -f vortex_telemetry.log vortex_telemetry.txt 2>/dev/null || true

# 8. Genereer vercel.json met de juiste mappen-routing
echo "🌐 vercel.json rewrites configureren..."
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
    { "source": "/vortex_geodetic_refraction_report-v2.pdf", "destination": "/pdf/vortex_geodetic_refraction_report-v2.pdf" },
    { "source": "/vortex_telemetry.log", "destination": "/vortex_telemetry.log" },
    { "source": "/vortex_telemetry.txt", "destination": "/vortex_telemetry.txt" }
  ]
}
JSON_EOF

# 9. Opschonen .gitignore
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

# 10. Git staging, commit en deploy
echo "🚀 Git staging & push naar GitHub / Vercel..."
git add -A
git commit -m "Organize full project structure into cockpittools, pdf, assets, scripts, and systeemdiagnose" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./scripts/vortex_master_deploy.sh" ]; then
  ./scripts/vortex_master_deploy.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Alle bestanden succesvol in de mappenstructuur geplaatst!"
echo "======================================================================"
