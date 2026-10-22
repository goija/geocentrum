#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
CAPSULE_DIR="$BASE_DIR/rekencentrum/tijdscapsule"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_NAME="vortex_backup_$TIMESTAMP.tar.gz"
BACKUP_PATH="$CAPSULE_DIR/$BACKUP_NAME"

cd "$BASE_DIR" || exit 1
mkdir -p "$CAPSULE_DIR"

tar --exclude="rekencentrum/tijdscapsule" \
    --exclude=".git" \
    -czf "$BACKUP_PATH" \
    config.json beheercentrum/ docs/ index.html start_services.py server_met_markdown.py validate_repo.py

if [ $? -eq 0 ]; then
    echo "✅ Tijdscapsule back-up succesvol opgeslagen in: $BACKUP_PATH"
else
    echo "❌ Fout tijdens het creëren van het back-up archief."
    exit 1
fi
