#!/bin/bash
set +H

echo "🚀 VORTEX OS - Automatische Synchronisatie & Notificatie..."

# Navigeer naar de hoofdmap
cd "$(dirname "$0")/.." || exit

# 1. Alles toevoegen aan Git
git add -A

# 2. Controleren of er wijzigingen zijn om te committen
if ! git diff-index --quiet HEAD -- 2>/dev/null || [ -n "$(git status --porcelain)" ]; then
    COMMIT_MSG="auto(sync): automatische update via sync_vortex op $(date +'%Y-%m-%d %H:%M')"
    git commit -m "$COMMIT_MSG"
    echo "📝 Wijzigingen vastgelegd in commit."
else
    echo "ℹ️ Geen nieuwe wijzigingen om te committen."
fi

# 3. Pull met rebase en push naar GitHub
echo "🔄 Synchroniseren met GitHub (rebase & push)..."
git pull origin main --rebase && git push origin main

# 4. Controleer of de actie succesvol was en geef een desktop-notificatie
if [ $? -eq 0 ]; then
    echo "✅ Synchronisatie succesvol voltooid!"
    if command -v notify-send &> /dev/null; then
        notify-send "VORTEX OS Sync" "Alle wijzigingen zijn succesvol gepusht naar GitHub!" -i dialog-information
    fi
else
    echo "❌ Fout tijdens synchronisatie of push!"
    if command -v notify-send &> /dev/null; then
        notify-send "VORTEX OS Sync Fout" "Er is een conflict of netwerkfout opgetreden bij GitHub." -i dialog-error
    fi
    exit 1
fi
