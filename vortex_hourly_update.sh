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
