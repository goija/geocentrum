#!/bin/bash
# ==========================================
# VORTEX OS - Tijdscapsule Back-up Automatisering
# ==========================================

BASE_DIR="$HOME/VORTEX_OS"
CAPSULE_DIR="$BASE_DIR/rekencentrum/tijdscapsule"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_NAME="vortex_backup_$TIMESTAMP.tar.gz"
BACKUP_PATH="$CAPSULE_DIR/$BACKUP_NAME"

cd "$BASE_DIR" || exit 1

echo "📦 [1/3] Starten van Tijdscapsule back-up (inclusief metadata)..."

# Maak de tijdscapsule map aan indien deze niet bestaat
mkdir -p "$CAPSULE_DIR"

# Maak een gecomprimeerd archief van de monorepo en de metadata
tar --exclude="rekencentrum/tijdscapsule/*.tar.gz" \
    --exclude=".git" \
    -czf "$BACKUP_PATH" \
    config.json beheercentrum/ docs/ rekencentrum/ index.html start_services.py server_met_markdown.py validate_repo.py test_webrtc_channel.py webrtc_test_runner.sh

if [ $? -eq 0 ]; then
    echo "✅ [2/3] Archief succesvol aangemaakt: $BACKUP_NAME"
    echo "🔒 [3/3] Tijdscapsule en metadata veilig opgeslagen in: $CAPSULE_DIR"
else
    echo "❌ Fout tijdens het creëren van het back-up archief."
    exit 1
fi
