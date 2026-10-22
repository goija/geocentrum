#!/usr/bin/env bash
set -euo pipefail

# Forceer de juiste werkmap
cd ~/VORTEX_OS
ROOT_DIR="$(pwd)"

echo "=============================================================================="
echo " 🚀 VORTEX OS: Uitrollen van alle Geodetische & API Services"
echo "=============================================================================="

# 1. Zeker weten dat mappen bestaan
mkdir -p input txt assets scripts

# 2. Maak poorten 8080 (Rust) en 8082 (Python) agressief vrij
sudo fuser -k -9 8080/tcp 2>/dev/null || true
sudo fuser -k -9 8082/tcp 2>/dev/null || true
sleep 1

# 3. Start Python API Server
if [[ -f "server_api.py" ]]; then
    echo "🌐 [1/4] Starten van Python API Server (poort 8082)..."
    python3 server_api.py &
    PYTHON_PID=$!
else
    echo "⚠️ Waarschuwing: server_api.py niet gevonden in ${ROOT_DIR}!"
fi

# 4. Voer Asset Manifest uit
if [[ -f "build_geocentrum_assets.sh" ]]; then
    echo "📦 [2/4] Genereren van Asset Manifest..."
    bash build_geocentrum_assets.sh >/dev/null 2>&1 || true
fi

# 5. Geodesie Doorrekening
if [[ -f "scripts/geodesic_calc.py" && -f "input/observation_2026-10-22.json" ]]; then
    echo "🐍 [3/4] Uitvoeren Geodesie & Refractie testrun..."
    python3 scripts/geodesic_calc.py input/observation_2026-10-22.json input/calc_output.json 2>/dev/null || true
fi

# 6. Start de Rust Core Engine op poort 8080
if [[ -d "vortex-geospatial-pipeline" ]]; then
    echo "🦀 [4/4] Starten van Rust Core Engine (poort 8080)..."
    cd vortex-geospatial-pipeline
    cargo run --release &
    RUST_PID=$!
    cd "${ROOT_DIR}"
fi

echo "=============================================================================="
echo " 🎉 VORTEX OS SERVICES ACTIEF OP DE ACHTERGROND"
echo "=============================================================================="
echo " Druk op [Ctrl+C] om alle processen veilig te beëindigen."

cleanup() {
    echo -e "\n[!] Stoppen van processen..."
    [[ -n "${PYTHON_PID:-}" ]] && kill $PYTHON_PID 2>/dev/null || true
    [[ -n "${RUST_PID:-}" ]] && kill $RUST_PID 2>/dev/null || true
    echo "✅ Alles netjes afgesloten."
    exit 0
}

trap cleanup SIGINT SIGTERM
while true; do sleep 30; done
