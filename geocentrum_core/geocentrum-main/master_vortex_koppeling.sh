#!/bin/bash
set -e

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOCAL_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

echo "======================================================================"
echo "🌀 VORTEX OS — Master Integratie & Coördinaten Koppeling Script"
echo "Tijdstempel: $LOCAL_TIME"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
if [ -d "$TARGET_DIR" ]; then cd "$TARGET_DIR"; fi

# 1. Garandeer alle benodigde mappen
mkdir -p cockpittools rekencentrum/tijdscapsule/backups maanpad scripts

# 2. Beveilig pizzadisk_simulatie_v158.py (Master Lock Backup)
if [ -f "rekencentrum/pizzadisk_simulatie_v158.py" ]; then
  cp -f rekencentrum/pizzadisk_simulatie_v158.py rekencentrum/tijdscapsule/backups/pizzadisk_simulatie_v158_LOCKED.py 2>/dev/null || true
  echo "🔒 Master lock opgeslagen voor pizzadisk_simulatie_v158.py"
fi

# 3. Maak het herstelscript (rollback_pizzadisk.sh)
cat << 'ROLLBACK_EOF' > rollback_pizzadisk.sh
#!/bin/bash
set -e
echo "🔄 Restoring pizzadisk_simulatie_v158.py from Master Lock..."
BACKUP="rekencentrum/tijdscapsule/backups/pizzadisk_simulatie_v158_LOCKED.py"
TARGET="rekencentrum/pizzadisk_simulatie_v158.py"
if [ -f "$BACKUP" ]; then
  chmod 644 "$TARGET" 2>/dev/null || true
  cp -f "$BACKUP" "$TARGET"
  echo "✅ Hersteld van Master Lock."
else
  echo "❌ Geen backup gevonden op $BACKUP"
  exit 1
fi
ROLLBACK_EOF
chmod +x rollback_pizzadisk.sh

# 4. Kopieer Canvas naar maanpad.html voor localhost:8000 ondersteuning
if [ -f "cockpittools/vortex_maanpad_canvas.html" ]; then
  cp -f cockpittools/vortex_maanpad_canvas.html maanpad.html 2>/dev/null || true
  cp -f cockpittools/vortex_maanpad_canvas.html maanpad/index.html 2>/dev/null || true
fi

# 5. Voer het geautomatiseerde uurupdate-script uit
chmod +x vortex_hourly_update.sh 2>/dev/null || true
./vortex_hourly_update.sh

# 6. Push naar Git & Vercel
git add -A
git commit -m "feat: full master coupling for RD coordinates, live Maanpad Canvas & Tijdscapsule [$LOCAL_TIME]" || true
git pull origin main --rebase || true
git push origin main

echo "======================================================================"
echo "✅ Master koppeling succesvol afgerond!"
echo "   • Localhost Maanpad: http://localhost:8000/maanpad.html"
echo "   • Direct Pad: http://localhost:8000/cockpittools/vortex_maanpad_canvas.html"
echo "   • Live Vercel: geocentrum.vercel.app/maanpad"
echo "======================================================================"
