#!/bin/bash
set -e
echo "🔄 Restoring pizzadisk_simulatie_v158.py from Master Lock..."
BACKUP="rekencentrum/tijdscapsule/backups/pizzadisk_simulatie_v158_LOCKED.py"
TARGET="rekencentrum/pizzadisk_simulatie_v158.py"
if [ -f "\$BACKUP" ]; then
  chmod 644 "\$TARGET" 2>/dev/null || true
  cp -f "\\(BACKUP" "\\)TARGET"
  echo "✅ Hersteld van Master Lock."
else
  echo "❌ Geen backup gevonden op \$BACKUP"
  exit 1
fi
