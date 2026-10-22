#!/bin/bash
set -e

echo "🌀 Mappenstructuur aanmaken voor Geocentrum / VORTEX OS..."

# Submappen aanmaken
mkdir -p cockpittools systeemdiagnose/update pdf assets scripts docs

# Bestanden sorteren naar hun respectievelijke mappen
[ -f "vortex_bipolar_precision_dashboard.html" ] && cp -f vortex_bipolar_precision_dashboard.html cockpittools/
[ -f "mapglobe.html" ] && cp -f mapglobe.html cockpittools/
[ -f "modular_flower_layer.html" ] && cp -f modular_flower_layer.html cockpittools/
[ -f "nebra_mapanalyst_vortex155.html" ] && cp -f nebra_mapanalyst_vortex155.html cockpittools/

[ -f "update.html" ] && cp -f update.html systeemdiagnose/update/
[ -f "vortex_geodetic_refraction_report-v2.pdf" ] && cp -f vortex_geodetic_refraction_report-v2.pdf pdf/
[ -f "naamloos_dossier.pdf" ] && cp -f naamloos_dossier.pdf pdf/

cp -f *.js cockpittools/ 2>/dev/null || true
cp -f *.geojson cockpittools/ 2>/dev/null || true
cp -f *.dxf cockpittools/ 2>/dev/null || true
cp -f *.sh scripts/ 2>/dev/null || true

echo "✅ Mappenstructuur succesvol opgebouwd!"
