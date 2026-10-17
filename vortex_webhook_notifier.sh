#!/bin/bash
# ==============================================================================
# VORTEX OS v158.1 — Webhook & Alert Notification Bridge
# ==============================================================================

WEBHOOK_URL="${VORTEX_WEBHOOK_URL:-}"
STATUS_JSON="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main/systeemdiagnose/update/telemetry_deploy_status.json"

if [ ! -f "$STATUS_JSON" ]; then
    echo "⚠️ Geen telemetrie JSON gevonden op $STATUS_JSON"
    exit 0
fi

STATUS=$(grep -o '"status": "[^"]*"' "$STATUS_JSON" | cut -d'"' -f4 || echo "UNKNOWN")
TIMESTAMP=$(grep -o '"timestamp": "[^"]*"' "$STATUS_JSON" | cut -d'"' -f4 || echo "NOW")

if [ "$STATUS" == "FAILED" ]; then
    EMOJI="🚨"
    TITLE="VORTEX OS Deployment FAILED"
elif [ "$STATUS" == "SUCCESS" ]; then
    EMOJI="✅"
    TITLE="VORTEX OS Deployment SUCCESS"
else
    EMOJI="ℹ️"
    TITLE="VORTEX OS Deployment Status: $STATUS"
fi

echo "[$TIMESTAMP] $EMOJI $TITLE — Status: $STATUS"

# Verstuur webhook-melding indien WEBHOOK_URL is ingesteld (bijv. Discord, Slack, Teams of Ntfy)
if [ -n "$WEBHOOK_URL" ]; then
    curl -s -H "Content-Type: application/json" -X POST -d "{\"content\":\"$EMOJI **$TITLE**\\nSysteem: VORTEX OS v158.1\\nTijdstip: $TIMESTAMP\\nStatus: $STATUS\"}" "$WEBHOOK_URL" || true
fi
