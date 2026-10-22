#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(pwd)"
OUT_DIR="${ROOT_DIR}/assets"
mkdir -p "$OUT_DIR"
MANIFEST_FILE="${OUT_DIR}/assets_manifest.js"

echo "🔍 VORTEX OS - Scannen van mappen voor assets en pagina's..."

cat << 'JS_EOF' > "$MANIFEST_FILE"
window.GEOCENTRUM_SCANNED_PAGES = [
    {name: "Systeem Index Dashboard", path: "/index.html"},
    {name: "Operationeel Procesdossier", path: "/cockpittools/procesdossier.html"},
    {name: "29cm Schijf Simulator Hub", path: "/beheercentrum/simulatoren/pizzadisk_simulatie_hub.html"},
    {name: "Handleiding V158", path: "/pdf/handleiding_vortex_os_v158.pdf"}
];
JS_EOF

echo "✅ Asset manifest succesvol gegenereerd op ${MANIFEST_FILE}"
