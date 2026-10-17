#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.5 — Instellen Uurlijkse Automatische Cron & Deploy"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Maak het automatische uurlijkse update-script aan
cat << 'UPDATER_EOF' > vortex_hourly_update.sh
#!/bin/bash
set -e

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
cd "$TARGET_DIR"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S %Z')
echo "======================================================================" >> vortex_telemetry.log
echo "📡 VORTEX OS Automatic Hourly Sync: $TIMESTAMP" >> vortex_telemetry.log

# Synchroniseer en genereer de nieuwste views
if [ -f "./fix_all_vortex_bugs.sh" ]; then
  bash ./fix_all_vortex_bugs.sh >> vortex_telemetry.log 2>&1
fi

# Git Commit & Vercel Push
git add -f *.html *.pdf *.js *.json *.geojson *.dxf *.png 2>/dev/null || true
git commit -m "Automated Hourly Sync: $TIMESTAMP" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  bash ./vortex_master_deploy.sh >> vortex_telemetry.log 2>&1
else
  git push origin main >> vortex_telemetry.log 2>&1
fi

echo "✅ Update voltooid op $TIMESTAMP" >> vortex_telemetry.log
UPDATER_EOF

chmod +x vortex_hourly_update.sh

# Voeg toe aan crontab (elke uur op minuut 0)
(crontab -l 2>/dev/null | grep -v "vortex_hourly_update.sh" ; echo "0 * * * * /bin/bash $TARGET_DIR/vortex_hourly_update.sh >/dev/null 2>&1") | crontab -

echo "======================================================================"
echo "✅ Uurlijkse automatische update is geactiveerd in crontab!"
echo "   Locatie script: $TARGET_DIR/vortex_hourly_update.sh"
echo "   Crontab schema: Elk uur (0 * * * *)"
echo "======================================================================"
