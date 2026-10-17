#!/bin/bash
set -e

echo "🌀 VORTEX OS v158.1 — Beheer- & Assetmap opbouwen..."

BASE_DIR="/home/ontwerp/Bureaublad/geocentrum"

mkdir -p "$BASE_DIR/assets"
mkdir -p "$BASE_DIR/cockpittools"
mkdir -p "$BASE_DIR/images"
mkdir -p "$BASE_DIR/systeemdiagnose/update"
mkdir -p "$BASE_DIR/txt"

echo "📁 Mappenstructuur aangemaakt op: $BASE_DIR"

cat << 'JS_EOF' > "$BASE_DIR/assets/assets_manifest.js"
export const VORTEX_ASSETS_MANIFEST = {
  version: "158.1",
  timestamp: new Date().toISOString(),
  anchors: {
    poolanker_p: { lat: 52.2500, lng: 5.2200, rdX: 141120, rdY: 473200 },
    scherpenisse: { lat: 51.546389, lng: 4.103889, rdX: 65985.24, rdY: 396053.23 },
    tholen_stad: { lat: 51.533056, lng: 4.216111, rdX: 73745.01, rdY: 394438.89 }
  },
  vectors: {
    scherpenisse_tholen: {
      rdGridAzimuthDeg: 101.75,
      wgs84AzimuthDeg: 100.74,
      meridianConvergenceDeg: -1.01,
      distanceMeters: 7925.92,
      hexagonalAxesDeg: [101.75, 161.75, 221.75, 281.75, 341.75, 41.75]
    }
  },
  duogramCalibration: {
    index: [0, 8],
    azimuthDeg: 45.0,
    rhoCm: -8.20,
    nonius: -264,
    attractor: "010101 (01)"
  }
};
JS_EOF

echo "✅ assets/assets_manifest.js aangemaakt."
echo "$(date) - VORTEX OS v158.1 Bureaublad build geslaagd." > "$BASE_DIR/txt/geocentrum_manifest_build.log"

echo "=============================================================================="
echo "✅ VORTEX OS v158.1 assets-map succesvol opgebouwd op je Bureaublad!"
echo "=============================================================================="
