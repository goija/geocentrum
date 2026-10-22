#!/bin/bash
cd ~/VORTEX_OS

# Controleer of er wijzigingen zijn
if [[ -n $(git status --porcelain) ]]; then
    echo "🔄 Wijzigingen gedetecteerd. Bezig met synchroniseren..."
    git add .
    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "✅ Synchronisatie voltooid!"
else
    echo "✨ Geen wijzigingen om te synchroniseren."
fi
