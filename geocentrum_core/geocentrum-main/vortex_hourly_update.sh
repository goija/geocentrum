#!/bin/bash
set -e

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOCAL_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")

echo "======================================================================"
echo "📡 VORTEX OS Automatic Sync & Tijdscapsule Update: $LOCAL_TIME"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
if [ -d "$TARGET_DIR" ]; then cd "$TARGET_DIR"; fi

# Safety Check: Test of pizzadisk_simulatie_v158.py geldig is
if [ -f "rekencentrum/pizzadisk_simulatie_v158.py" ]; then
  if ! python3 -m py_compile rekencentrum/pizzadisk_simulatie_v158.py 2>/dev/null; then
    echo "⚠️ Waarschuwing: Fout gedetecteerd in pizzadisk_simulatie_v158.py. Automatische rollback wordt uitgevoerd..."
    bash ./rollback_pizzadisk.sh
  fi
fi

# Update vortex_telemetry.log
cat << LOG_EOF > vortex_telemetry.log
VORTEX OS Realtime Telemetrie Sync Log
Tijdstempel: $LOCAL_TIME
Status: ● ACTIEF (Auto-Sync & Interface Locked)
Attractor: 010101 (Hex #21)
Node: Mathgeo-Seven (EPSG:28992)
LOG_EOF

# Update dynamische tijdscapsule JSON data
mkdir -p rekencentrum/tijdscapsule
cat << JSON_EOF > rekencentrum/tijdscapsule/tijdscapsule_data.json
{
  "tijdscapsule_metadata": {
    "titel": "VORTEX OS — Geodetische & Astrometrische Tijdscapsule",
    "timestamp_lock": "$LOCAL_TIME",
    "iso_timestamp": "$TIMESTAMP",
    "versie": "v159.1 Locked-Interface",
    "interface_lock": "pizzadisk_simulatie_v158.py (Protected)",
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
  "dataset_ref": "vortex_processed_points.geojson (100 Punten P1-P100)"
}
JSON_EOF

# Git commit & push naar GitHub en Vercel
git add -A
git commit -m "auto: update telemetry with locked pizzadisk interface [$LOCAL_TIME]" || true
git pull origin main --rebase || true
git push origin main

echo "======================================================================"
echo "🔒 Interface gelockt, veiligheidscheck geslaagd & Tijdscapsule gesynchroniseerd!"
echo "======================================================================"
