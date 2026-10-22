#!/usr/bin/env bash
# ==============================================================================
# VORTEX GEOCENTRUM // VERCEL AUTOMATISCHE CLOUD DEPLOY SCRIPT
# Locatie: ~/Bureaublad/geocentrum/push_to_vercel.sh
# ==============================================================================
set -e
cd "$(dirname "$0")"

echo "=== [1/3] Sync assets en HTML naar Vercel workspace ==="
git add .
git commit -m "VORTEX Geocentrum Cloud Sync: $(date '+%Y-%m-%d %H:%M:%S')" || echo "Geen lokale wijzigingen."
git push origin main || git push origin master

echo "=== [2/3] Trigger Vercel Production Deployment ==="
if command -v vercel &> /dev/null; then
    vercel --prod --yes
else
    echo "Vercel CLI niet gevonden. Installeer via: npm i -g vercel"
    echo "Je GitHub push is wel succesvol uitgevoerd; Vercel bouwt automatisch op basis van je repo."
fi

echo "=== ✅ GEOCENTRUM IS LIVE OP https://geocentrum.vercel.app ==="
