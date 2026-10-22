#!/usr/bin/env bash
echo "Bouwen van vortex_clean_viewports_v158.html..."

cat << 'HTMLEOF' > vortex_clean_viewports_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <title>VORTEX OS v158 // Clean Viewports</title>
    <!-- MapLibre en andere dependencies komen hier -->
    <style>
        body { background: #060a12; color: #38bdf8; font-family: monospace; padding: 20px; }
        .viewport { border: 1px solid #293b5f; padding: 15px; border-radius: 8px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <h1>VORTEX OS v158.0 - Clean Viewports (Geodesie/Spectraal)</h1>
    
    <div class="viewport">
        <h2>VP-1: Planimeter / Cellarius Raster</h2>
        <p>A. Ott Nr. 573 configuratie geladen.</p>
    </div>
    
    <div class="viewport">
        <h2>VP-2: Spectrale / Laser Node (FFT Analyzer)</h2>
        <p>Fraunhofer D (589nm) / 432 Hz harmonische audio klaar.</p>
    </div>
</body>
</html>
HTMLEOF

echo "Bestand succesvol aangemaakt! Openen in browser..."
xdg-open vortex_clean_viewports_v158.html &
