#!/usr/bin/env bash
# ==============================================================================
# VORTEX OS // API TEST SUITE (cURL)
# Valideert de Rust Core Engine & Geodetische Pipeline Endpoints
# ==============================================================================

BASE_URL="http://localhost:8080"
echo "=============================================================================="
echo " 🚀 VORTEX OS: Starten van API Validatie Suite (Target: $BASE_URL)"
echo "=============================================================================="

# Zorg ervoor dat jq geïnstalleerd is voor mooie JSON-opmaak (optioneel, maar handig)
if ! command -v jq &> /dev/null; then
    echo "ℹ️ Tip: Installeer 'jq' (sudo apt install jq) voor mooiere JSON-output."
    JQ_CMD="cat"
else
    JQ_CMD="jq"
fi

echo -e "\n🧪 TEST 1: GET /feed.xml (Live RSS XML telemetrie-stream)"
echo "------------------------------------------------------------------------------"
curl -s -X GET "$BASE_URL/feed.xml" | head -n 15
echo -e "\n(... output afgekapt voor leesbaarheid)"

echo -e "\n🧪 TEST 2: GET /api/matrix91 (7x13 roostermatrix)"
echo "------------------------------------------------------------------------------"
curl -s -X GET "$BASE_URL/api/matrix91" | $JQ_CMD

echo -e "\n🧪 TEST 3: GET /api/maan (Actuele Maan-stand & refractielift)"
echo "------------------------------------------------------------------------------"
curl -s -X GET "$BASE_URL/api/maan" | $JQ_CMD

echo -e "\n🧪 TEST 4: POST /api/shoelace (RD-polygonen oppervlakte & zwaartepunt)"
echo "------------------------------------------------------------------------------"
curl -s -X POST "$BASE_URL/api/shoelace" \
     -H "Content-Type: application/json" \
     -d '{
           "polygon": [
             {"x": 143582, "y": 473563},
             {"x": 143600, "y": 473500},
             {"x": 143500, "y": 473550}
           ]
         }' | $JQ_CMD

echo -e "\n🧪 TEST 5: POST /api/pipeline/run (Rust Core, Python & R geodetische verwerking)"
echo "------------------------------------------------------------------------------"
curl -s -X POST "$BASE_URL/api/pipeline/run" \
     -H "Content-Type: application/json" \
     -d '{
          "timestamp": "2026-10-22T19:00:00+02:00",
          "location": {
            "name": "Laren (Poolanker P)",
            "latitude": 52.2500,
            "longitude": 5.2200,
            "rd_x": 143582,
            "rd_y": 473563
          },
          "target": {
            "name": "Maan",
            "azimuth": 122.0,
            "elevation": 17.7,
            "illumination": 0.861
          },
          "parameters": {
            "grid_points_count": 18,
            "sd_meters": 600
          }
        }' | $JQ_CMD

echo -e "\n=============================================================================="
echo " ✅ API TEST SUITE VOLTOOID "
echo "=============================================================================="
