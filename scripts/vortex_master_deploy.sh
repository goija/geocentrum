#!/bin/bash
# ==============================================================================
# VORTEX OS v158.1 — Master Deploy, GeoJSON/DXF Sync & GitHub Push Script
# ==============================================================================

set -e

PROJECT_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
REPO_URL=$(echo "aHR0cHM6Ly9naXRodWIuY29tL2dvaWphL2dlb2NlbnRydW0uZ2l0" | base64 -d)

echo "----------------------------------------------------------------------"
echo "🚀 VORTEX OS v158.1 — Start Master Deploy & Sync Process"
echo "----------------------------------------------------------------------"

# 1. Navigeer naar de projectmap
if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
    echo "📁 Projectmap gelokaliseerd: $PROJECT_DIR"
else
    echo "❌ Fout: Projectmap $PROJECT_DIR niet gevonden!"
    exit 1
fi

# 2. Opschonen en correct instellen van Git Remote 'origin'
echo "🔧 Controleren en herstellen van Git Remote..."
git init
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "📍 Geconfigureerde Remote URL:"
git remote -v

# 3. Bestanden toevoegen en commiten
echo "📦 Staging van alle VORTEX OS v158.1 bestanden en assets..."
git branch -M main
git add .
git commit -m "feat: automated VORTEX OS v158.1 master deploy [$(date +'%Y-%m-%d %H:%M:%S')]" --allow-empty

# 4. Geforceerd pushen naar GitHub
echo "⬆️ Pushen naar GitHub (main branch)..."
git push -u origin main --force

echo "----------------------------------------------------------------------"
echo "🚀 Master Sync naar goija/geocentrum succesvol voltooid!"
echo "----------------------------------------------------------------------"
