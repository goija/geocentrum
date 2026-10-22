#!/bin/bash
set -e

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOCAL_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

echo "======================================================================"
echo "📡 VORTEX OS Automatic Sync & Tijdscapsule Update: $LOCAL_TIME"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
if [ -d "$TARGET_DIR" ]; then cd "$TARGET_DIR"; fi

# 1. Update vortex_telemetry.log
cat << LOG_EOF > vortex_telemetry.log
VORTEX OS Realtime Telemetrie Sync Log
Tijdstempel: $LOCAL_TIME
Status: ● ACTIEF (Auto-Sync)
Attractor: 010101 (Hex #21)
Node: Mathgeo-Seven (EPSG:28992)
LOG_EOF

# 2. Update dynamische tijdscapsule JSON data
mkdir -p rekencentrum/tijdscapsule
cat << JSON_EOF > rekencentrum/tijdscapsule/tijdscapsule_data.json
{
  "tijdscapsule_metadata": {
    "titel": "VORTEX OS — Geodetische & Astrometrische Tijdscapsule",
    "timestamp_lock": "$LOCAL_TIME",
    "iso_timestamp": "$TIMESTAMP",
    "versie": "v159.0 Auto-Dynamic",
    "oorsprong_anker": "Poolanker P (52.2500° N, 5.2200° E)",
    "attractor_state": "010101 (Hex #21)"
  },
  "plani_configuratie": {
    "diameter_cm": 29,
    "start_azimut_deg": 108,
    "ring1": { "rotatie_deg": 202, "tilt_deg": 22 },
    "ring2": { "rotatie_deg": 22, "tilt_deg": 22 },
    "ring3": { "rotatie_deg": 22, "tilt_deg": -22 },
    "a_ott_573": {
      "poolarm_r_cm": 15.00,
      "rijarm_l_cm": 16.67,
      "fraunhofer_d_nm": 589.0,
      "oppervlakte_a0_cm2": 363.08
    }
  },
  "astrometrie_18_okt_2026": {
    "object": "Maan",
    "tijd_cest": "$LOCAL_TIME",
    "rechte_klimming_ra_deg": 191.20,
    "declinatie_dec_deg": 13.30,
    "lokale_sterrentijd_lst_deg": 312.74,
    "uurhoek_ha_deg": 121.54,
    "azimut_deg": 303.23,
    "elevatie_deg": -7.45,
    "constellatie": "Capricornus / Steenbok (Zuidmuur)"
  },
  "geodetische_vectoren": [
    { "hoek": 22.00, "label": "Planimeter Normandië / Kompas" },
    { "hoek": 29.00, "label": "Trans-Atlantische Zichtlijn (NYC)" },
    { "hoek": 91.00, "label": "Pömmelte Equinox Oost-Vector" },
    { "hoek": 97.00, "label": "Snellius Refractie Kustlijn Biskaje" },
    { "hoek": 122.00, "label": "Caustische k=7 Resonantie / Saturnus-as" },
    { "hoek": 331.00, "label": "CRT Modulaire Attractor (x^3 = x mod 260)" }
  ],
  "dataset_ref": "vortex_processed_points.geojson (100 Punten P1-P100)"
}
JSON_EOF

# 3. Synchroniseer naar scripts map
mkdir -p scripts
cp -f vortex_hourly_update.sh scripts/vortex_hourly_update.sh 2>/dev/null || true

# 4. Commit & push naar GitHub / Vercel
git add -A
git commit -m "auto: update dynamic tijdscapsule telemetry [$LOCAL_TIME]" || true
git pull origin main --rebase || true
git push origin main

echo "======================================================================"
echo "✅ Synchronisatie succesvol uitgevoerd en dynamische tijdscapsule bijgewerkt!"
echo "======================================================================"
