#!/bin/bash
set +H

echo "📂 Integreren van het Beheercentrum procesdossier in de repository..."

# Zorg dat de doelmap bestaat
mkdir -p beheercentrum/notion_export

# Maak een placeholder / opslagbestand aan voor de geïmporteerde Notion export
cat << 'NOTION_EOF' > beheercentrum/notion_export/Beheercentrum_procesdossier.html
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <title>Beheercentrum - Procesdossier (Notion Export)</title>
    <style>
        body { font-family: sans-serif; background: #0d1b2a; color: #e0e1dd; padding: 40px; }
        .container { max-width: 800px; margin: 0 auto; background: #1b263b; padding: 30px; border-radius: 8px; border: 1px solid rgba(0,180,216,0.3); }
        h1 { color: #00b4d8; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Beheercentrum - Procesdossier (Notion)</h1>
        <p>Dit bestand vertegenwoordigt de geïmporteerde Notion-export van het procesdossier binnen het VORTEX OS / GeoCentrum ecosysteem.</p>
        <p><a href="../../cockpittools/procesdossier.html" style="color: #00b4d8;">← Terug naar het lokale operationele Procesdossier</a></p>
    </div>
</body>
</html>
NOTION_EOF

echo "✅ Notion procesdossier succesvol geplaatst in beheercentrum/notion_export/"

# Voeg toe aan Git en push naar GitHub
git add beheercentrum/notion_export/
git commit -m "feat(beheer): notion export van beheercentrum procesdossier geïntegreerd in repository" || true
git pull origin main --rebase || true
git push origin main

echo "🎉 De Notion export is toegevoegd aan het Beheercentrum en gepusht naar GitHub!"
