#!/bin/bash
set -e

cd /home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main

# Decodeer de schone GitHub URL zonder leestekenverstoringen
REPO_URL=$(echo "aHR0cHM6Ly9naXRodWIuY29tL2dvaWphL2dlb2NlbnRydW0uZ2l0" | base64 -d)

# Verwijder oude remote en koppel de schone URL
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "📍 Geconfigureerde remote URL:"
git remote -v

# Zet branch op main, commit en push
git branch -M main
git add .
git commit -m "feat: sync geocentrum-main v158.1" --allow-empty
git push -u origin main --force

echo "🚀 Push naar goija/geocentrum succesvol voltooid!"
