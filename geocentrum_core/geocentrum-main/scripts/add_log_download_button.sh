#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.5 — Toevoegen Log Download Knop (.TXT / .LOG)"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 1. Zorg dat het logbestand aanwezig is
touch vortex_telemetry.log
cp -f vortex_telemetry.log vortex_telemetry.txt 2>/dev/null || true

# 2. Update vercel.json rewrites voor .log en .txt
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

# 3. Voeg de knop toe aan vortex_omni_master_v158.html in de rechter zijbalk
if [ -f "vortex_omni_master_v158.html" ]; then
  if ! grep -q "vortex_telemetry.log" vortex_omni_master_v158.html; then
    sed -i '/<div class="sidebar-section-title">📊 INTERACTIVE ENGINE<\/div>/i \
    <div class="sidebar-section-title">📜 TELEMETRIE LOGS<\/div>\
    <a class="nav-button" href="\/vortex_telemetry.log" target="_blank" download style="color:var(--cyan); text-decoration:none; margin-bottom:8px;">\
      <span>📥 Download Log (.TXT)<\/span>\
    <\/a>' vortex_omni_master_v158.html
    cp -f vortex_omni_master_v158.html index.html
  fi
fi

# 4. Git Staging & Deployment
git add -f vortex_omni_master_v158.html index.html vercel.json vortex_telemetry.log vortex_telemetry.txt 2>/dev/null || true
git commit -m "Add direct download button for vortex_telemetry.log (.txt)" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./push_geocentrum_main.sh" ]; then
  ./push_geocentrum_main.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Downloadknop voor vortex_telemetry.log (.txt) succesvol live op Vercel!"
echo "======================================================================"
