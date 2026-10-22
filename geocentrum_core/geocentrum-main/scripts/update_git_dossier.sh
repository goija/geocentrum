#!/bin/bash
set +H

echo "📊 VORTEX OS - Git Status Dossier Genereren & Synchroniseren..."

# Navigeer naar de hoofdmap
cd "$(dirname "$0")/.." || exit

# Zorg dat de beheercentrum map bestaat
mkdir -p beheercentrum

# Genereer automatisch het git status dossier
DOSSIER_FILE="beheercentrum/git_status_dossier.md"
echo "# GIT STATUS DOSSIER & REPOSITORY RAPPORT" > "$DOSSIER_FILE"
echo "Laatste update: $(date +'\%Y-\%m-\%d \%H:\%M:\%S')" >> "$DOSSIER_FILE"
echo "" >> "$DOSSIER_FILE"
echo "## Actuele Repository Status" >> "$DOSSIER_FILE"
echo '```text' >> "$DOSSIER_FILE"
git status >> "$DOSSIER_FILE"
echo '```' >> "$DOSSIER_FILE"
echo "" >> "$DOSSIER_FILE"
echo "## Laatste 5 Commits" >> "$DOSSIER_FILE"
echo '```text' >> "$DOSSIER_FILE"
git log -n 5 --oneline >> "$DOSSIER_FILE"
echo '```' >> "$DOSSIER_FILE"

echo "✅ Git Status Dossier geschreven naar $DOSSIER_FILE."

# Los de uncommitted/untracked wijzigingen op door alles toe te voegen en te committen
git add -A
git commit -m "docs(git): automatisch git status dossier bijgewerkt en wijzigingen vastgelegd" || true

# Veilig pullen met rebase en pushen naar GitHub
git pull origin main --rebase || true
git push origin main

echo "🎉 Het Git Dossier is succesvol bijgewerkt en gepusht naar GitHub!"
