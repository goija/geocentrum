#!/usr/bin/env bash
# ==============================================================================
# VORTEX OS // AUTOMATISCHE GITHUB & VERCEL DEPLOY PIPELINE
# ==============================================================================

set -euo pipefail
ROOT_DIR="$(pwd)"
TIMESTAMP="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"

echo "=============================================================================="
echo " [1/3] GEOCENTRUM PIPELINE: Uitvoeren Asset & Manifest Generator..."
echo "=============================================================================="
if [[ -f "${ROOT_DIR}/build_geocentrum_assets.sh" ]]; then
  bash "${ROOT_DIR}/build_geocentrum_assets.sh"
fi

echo "=============================================================================="
echo " [2/3] GITHUB: Vastleggen van wijzigingen (Git Commit)..."
echo "=============================================================================="
git add -A

if git diff --cached --quiet; then
  echo "ℹ️ Geen nieuwe wijzigingen gedetecteerd om te committeren."
else
  git commit -m "VORTEX OS Auto-sync & Master Cockpit Update: ${TIMESTAMP}"
  echo "✅ Wijzigingen succesvol vastgelegd in Git."
fi

echo "=============================================================================="
echo " [3/3] GITHUB: Pushen naar remote origin (main)..."
echo "=============================================================================="
CURRENT_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")"
git push origin "${CURRENT_BRANCH}" --force

echo "=============================================================================="
echo " 🎉 DEPLOY PIPELINE VOLTOOID! Vercel bouwt direct op https://geocentrum.vercel.app"
echo "=============================================================================="
