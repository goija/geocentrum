#!/usr/bin/env bash
# ==============================================================================
# VORTEX OS // AUTOMATISCHE GITHUB & VERCEL DEPLOY PIPELINE
# ==============================================================================

set -euo pipefail
TIMESTAMP="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"

echo "=============================================================================="
echo " 🚀 VORTEX OS: Synchroniseren met GitHub & Vercel"
echo "=============================================================================="

# 1. Voeg alle bestanden toe aan Git (inclusief de nieuwe HTML)
git add -A

# 2. Leg de wijzigingen vast
if git diff --cached --quiet; then
  echo "ℹ️ Geen nieuwe wijzigingen gedetecteerd om te committeren."
else
  git commit -m "VORTEX OS Update: Clean Viewports v158 (Geodesie & Spectraal) - ${TIMESTAMP}"
  echo "✅ Wijzigingen succesvol vastgelegd in Git."
fi

# 3. Push naar GitHub (Triggert automatisch Vercel)
echo "☁️ Pushen naar GitHub (main)..."
CURRENT_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")"
git push origin "${CURRENT_BRANCH}"

echo "=============================================================================="
echo " 🎉 DEPLOY VOLTOOID! Vercel bouwt direct op https://geocentrum.vercel.app"
echo "=============================================================================="
