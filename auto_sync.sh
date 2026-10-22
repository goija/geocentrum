#!/bin/bash
BASE_DIR="$HOME/VORTEX_OS"
LOG_FILE="$BASE_DIR/sync_history.log"

cd "$BASE_DIR" || exit 1

{
    echo "=================================================="
    echo "🕒 Synchronisatie gestart op: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "🔍 Stap 1: Uitvoeren van repo-validatie..."
    
    python3 validate_repo.py
    VALIDATION_STATUS=$?

    if [ $VALIDATION_STATUS -ne 0 ]; then
        echo "❌ Synchronisatie geaborteerd vanwege ontbrekende verplichte onderdelen."
        echo "--------------------------------------------------"
        exit 1
    fi

    echo "✅ Validatie geslaagd!"

    # Controleer of er wijzigingen zijn
    if [[ -n $(git status --porcelain) ]]; then
        echo "🔄 Wijzigingen gedetecteerd. Bezig met synchroniseren..."
        git add .
        git commit -m "Auto-sync & Validate: $(date '+%Y-%m-%d %H:%M:%S')"
        git push origin main
        echo "🚀 Synchronisatie succesvol voltooid!"
    else
        echo "✨ Geen wijzigingen om te synchroniseren."
    fi
    echo "--------------------------------------------------"
} | tee -a "$LOG_FILE"
