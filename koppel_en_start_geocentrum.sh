#!/usr/bin/env bash
# ==============================================================================
# VORTEX OS // PDF-HULPMIDDELEN & MASTER COCKPIT KOPPELING SCRIPT
# ==============================================================================

set -euo pipefail
ROOT_DIR="$(pwd)"

echo "=============================================================================="
echo " 📁 KOPPELEN PDF-HULPMIDDELEN & DOSSIERS IN GEOCENTRUM"
echo "=============================================================================="

# 1. Zorg dat de pdf-map bestaat en navigeer ernaar
mkdir -p "${ROOT_DIR}/pdf"
cd "${ROOT_DIR}/pdf"

# 2. Hernoem eventuele complexe of anonieme bestandsnamen veilig zonder spaties/haakjes
for f in *; do
  if [[ "$f" == *"anonymous"* || "$f" == *"ACFrOg"* ]]; then
    mv -f "$f" "anonymous_dossier.pdf" 2>/dev/null || true
  fi
done

# 3. Maak een centrale index.html voor de PDF Hub aan als deze mist
cat << 'HTMLEOF' > firefox_pdf_hulpmiddelen.html
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <title>GEOCENTRUM // Firefox PDF Hulpmiddelen & Dossiers</title>
    <style>
        body { background: #070a0f; color: #e2e8f0; font-family: monospace; padding: 30px; }
        h1 { color: #00e5ff; margin-bottom: 10px; }
        ul { list-style: none; padding: 0; }
        li { margin: 10px 0; background: #111927; padding: 12px; border: 1px solid #1e2d42; border-radius: 6px; }
        a { color: #38bdf8; text-decoration: none; font-weight: bold; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>GEOCENTRUM // PDF HULPMIDDELEN & DOSSIERS</h1>
    <p>Gekoppelde archieven en meetrapporten:</p>
    <ul>
        <li>📄 <a href="1c66d21e-6829-4aca-9cc7-b29b0b1d5b07_Planitaire_data.pdf" target="_blank">Planitaire Data & Geodetische Coördinaten</a></li>
        <li>📄 <a href="7a74d769-2330-4e19-a1ca-d141a17feb71_metingen_petrus_schenk.pdf" target="_blank">Metingen Petrus Schenk</a></li>
        <li>📄 <a href="7808126e-544c-4512-b8fc-2fbd6e860183_Historisch-archeologisch_onderzoeksdossier__West-Brabant_Zeeland_en_de_Vlaamse_kust.pdf" target="_blank">Historisch-Archeologisch Onderzoeksdossier West-Brabant & Zeeland</a></li>
        <li>📄 <a href="anonymous_dossier.pdf" target="_blank">Anonymous Geodetisch & OSINT Dossier</a></li>
    </ul>
    <p style="margin-top:20px;"><a href="../vortex_omni_master_v158.html">← Terug naar VORTEX OS Master Cockpit</a></p>
</body>
</html>
HTMLEOF

echo "✅ PDF-dossiers succesvol gekoppeld aan de Geocentrum Hub!"

# 4. Navigeer terug naar de root en open de Master Cockpit en PDF Hub in de browser
cd "${ROOT_DIR}"

if [ -f "vortex_omni_master_v158.html" ]; then
  echo "🚀 Openen van Master Cockpit v158..."
  xdg-open vortex_omni_master_v158.html 2>/dev/null &
fi

xdg-open pdf/firefox_pdf_hulpmiddelen.html 2>/dev/null &

echo "=============================================================================="
echo " 🎉 KOPPELING EN START VOLTOOID!"
echo "=============================================================================="
