#!/usr/bin/env bash
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
echo " [2/3] GITHUB: Controleren en vastleggen van wijzigingen (Git Commit)..."
echo "=============================================================================="
git add .
if git diff --cached --quiet; then
  echo "ℹ️ Geen nieuwe wijzigingen gedetecteerd."
else
  git commit -m "Auto-sync VORTEX OS manifest & assets: ${TIMESTAMP}"
  echo "✅ Wijzigingen vastgelegd in Git."
fi
