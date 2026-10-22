#!/bin/bash
LOG_FILE="/tmp/vortex_deploy.log"
JSON_OUT="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main/systeemdiagnose/update/telemetry_deploy_status.json"

mkdir -p $(dirname "$JSON_OUT") 2>/dev/null || true
LAST_RUN=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

if [ -f "$LOG_FILE" ]; then
    if grep -q "succesvol voltooid" "$LOG_FILE"; then
        STATUS="SUCCESS"
    elif grep -q "Fout" "$LOG_FILE" || grep -q "fatal" "$LOG_FILE"; then
        STATUS="FAILED"
    else
        STATUS="RUNNING"
    fi
    DETAILS=$(tail -n 15 "$LOG_FILE" | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}')
else
    STATUS="NO_LOG"
    DETAILS="Geen recent logbestand gevonden op /tmp/vortex_deploy.log"
fi

cat << JSON > "$JSON_OUT"
{
  "timestamp": "$LAST_RUN",
  "system": "VORTEX OS v158.1",
  "module": "GitHub/Vercel Master Deploy Cron",
  "status": "$STATUS",
  "log_source": "$LOG_FILE",
  "last_log": "$DETAILS"
}
JSON

echo "✓ Telemetrie-status bijgewerkt in $JSON_OUT"
