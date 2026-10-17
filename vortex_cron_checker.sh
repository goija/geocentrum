#!/bin/bash
PROJECT_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
LOG_FILE="/tmp/vortex_cron_telemetry.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "--------------------------------------------------" >> "$LOG_FILE"
echo "🕒 Cron Check @ $TIMESTAMP" >> "$LOG_FILE"

# Controleer de Vercel live endpoint status
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" [suspicious link removed] || echo "000")
echo "🌐 Vercel Live /update HTTP Status: $HTTP_STATUS" >> "$LOG_FILE"

# Controleer de lokale systemd service status
if command -v systemctl &> /dev/null; then
    SYS_STATUS=$(systemctl --user is-active vortex-geodetic-engine.service 2>/dev/null || echo "unknown")
    echo "⚡ Systemd Rust Engine Service: $SYS_STATUS" >> "$LOG_FILE"
fi

echo "✅ Telemetrie Cron Check voltooid." >> "$LOG_FILE"
