#!/bin/bash
set +H

echo "📅 VORTEX OS - Kalender & Historie Logger..."

# Navigeer naar de hoofdmap
cd "$(dirname "$0")/.." || exit

HISTORIE_DIR="beheercentrum"
HISTORIE_FILE="$HISTORIE_DIR/kalender_historie.md"

mkdir -p "$HISTORIE_DIR"

# Als het historiedossier nog niet bestaat, maak de header aan
if [ ! -f "$HISTORIE_FILE" ]; then
    echo "# VORTEX OS - Historisch Kalender- en Activiteitenlog" > "$HISTORIE_FILE"
    echo "Dit document bevat de chronologische tijdlijn van alle projectmilestones, versies en beheertaken." >> "$HISTORIE_FILE"
    echo "" >> "$HISTORIE_FILE"
fi

# Vraag optioneel om een beschrijving van de mijlpaal, of gebruik een standaard melding
ACTIE_BESCHRIJVING=${1:-"Automatische synchronisatie en systeemupdate"}
DATUM_TIJD=$(date +'%Y-%m-%d %H:%M:%S')
DAG_NAAM=$(date +'%A')

# Schrijf de nieuwe gebeurtenis weg naar het historiedossier
echo "### [$DATUM_TIJD] ($DAG_NAAM)" >> "$HISTORIE_FILE"
echo "- **Gebeurtenis / Taak:** $ACTIE_BESCHRIJVING" >> "$HISTORIE_FILE"
echo "- **Git Status:** $(git rev-parse --short HEAD 2>/dev/null || echo "Lokale wijziging")" >> "$HISTORIE_FILE"
echo "- **Actieve Modules:** Frontend (8000), Python API (8080), Mapglobe GIS" >> "$HISTORIE_FILE"
echo "" >> "$HISTORIE_FILE"

echo "✅ Activiteit succesvol toegevoegd aan het historisch kalenderlog ($HISTORIE_FILE)."

# Voeg het historiedossier direct toe aan de sync-cyclus
git add "$HISTORIE_FILE"

# Roep het bestaande sync-script aan als dat er is
if [ -f "scripts/sync_vortex.sh" ]; then
    ./scripts/sync_vortex.sh
else
    git commit -m "docs(historie): kalenderlog bijgewerkt voor $DATUM_TIJD" || true
    git push origin main
    echo "🎉 Historie opgeslagen en gepusht!"
fi
