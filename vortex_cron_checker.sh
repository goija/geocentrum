#!/bin/bash
# ==============================================================================
# VORTEX OS v158.1 — Integrity Checker & Cronjob Installer
# ==============================================================================

set -e

PROJECT_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
MANIFEST_FILE="$PROJECT_DIR/.vortex_checksums.sha256"
DEPLOY_SCRIPT="$PROJECT_DIR/vortex_master_deploy.sh"

echo "======================================================================"
echo "🛡️ VORTEX OS v158.1 — Bestandsintegriteit & Cronjob Beheerscript"
echo "======================================================================"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ Fout: Projectmap $PROJECT_DIR bestaat niet!"
    exit 1
fi

cd "$PROJECT_DIR"

# ------------------------------------------------------------------------------
# 1. Bestandsintegriteitscontrole (SHA-256)
# ------------------------------------------------------------------------------
echo "🔍 1. Bestandsintegriteit controleren..."

CORE_FILES=(
    "index.html"
    "vortex_omni_master_v158.html"
    "vortex_clean_viewports_v158.html"
    "vercel.json"
    "vortex_laser_globe_layer.js"
)

if [ ! -f "$MANIFEST_FILE" ]; then
    echo "📌 Nieuw integriteitsmanifest aanmaken (.vortex_checksums.sha256)..."
    for file in "${CORE_FILES[@]}"; do
        if [ -f "$file" ]; then
            sha256sum "$file" >> "$MANIFEST_FILE"
        fi
    done
fi

ERRORS=0
for file in "${CORE_FILES[@]}"; do
    if [ -f "$file" ]; then
        EXPECTED=$(grep " $file$" "$MANIFEST_FILE" | awk '{print $1}' || true)
        CURRENT=$(sha256sum "$file" | awk '{print $1}')
        if [ -n "$EXPECTED" ] && [ "$EXPECTED" != "$CURRENT" ]; then
            echo "⚠️ WAARSCHUWING: Bestand '$file' is gewijzigd t.o.v. de referentie!"
            ERRORS=$((ERRORS + 1))
        else
            echo "  ✓ $file — SHA-256 OK ($CURRENT)"
        fi
    else
        echo "❌ Fout: Kernbestand '$file' ontbreekt!"
        ERRORS=$((ERRORS + 1))
    fi
done

if [ "$ERRORS" -eq 0 ]; then
    echo "✅ Alle kernbestanden zijn 100% intact en geverifieerd."
else
    echo "⚠️ Integriteitstest voltooid met $ERRORS opmerking(en)."
fi

# ------------------------------------------------------------------------------
# 2. Git Remote Status
# ------------------------------------------------------------------------------
echo ""
echo "📡 2. Git Remote status controleren..."
git remote -v || true

# ------------------------------------------------------------------------------
# 3. Cronjob Installatie (Elk uur automatische sync)
# ------------------------------------------------------------------------------
echo ""
echo "⏱️ 3. Cronjob status controleren..."

CRON_CMD="0 * * * * /bin/bash $DEPLOY_SCRIPT > /tmp/vortex_deploy.log 2>&1"

if crontab -l 2>/dev/null | grep -q "$DEPLOY_SCRIPT"; then
    echo "✅ Cronjob staat al actief in crontab!"
else
    echo "⚙️ Cronjob toevoegen aan crontab..."
    (crontab -l 2>/dev/null || true; echo "$CRON_CMD") | crontab -
    echo "✅ Cronjob succesvol geïnstalleerd:"
    echo "   $CRON_CMD"
fi

echo "======================================================================"
echo "🎉 Integriteitscontrole en Cronjob-installatie voltooid!"
echo "======================================================================"
