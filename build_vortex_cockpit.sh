#!/usr/bin/env bash
echo "Bouwen van vortex_clean_viewports_v158.html..."

cat << 'HTMLEOF' > vortex_clean_viewports_v158.html
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX OS v158.0 - Clean Viewports (Geodesie/Spectraal)</title>
    
    <link href="https://unpkg.com/maplibre-gl@3.3.1/dist/maplibre-gl.css" rel="stylesheet" />
    <script src="https://unpkg.com/maplibre-gl@3.3.1/dist/maplibre-gl.js"></script>
    
    <style>
        body { margin: 0; background: #050811; color: #00e5ff; font-family: 'Courier New', monospace; display: flex; flex-direction: column; height: 100vh; overflow: hidden; }
        header { padding: 12px 20px; background: #0b1018; border-bottom: 1px solid #1e2d42; display: flex; justify-content: space-between; align-items: center; }
        .badge { background: rgba(245,176,39,0.15); color: #f5b027; padding: 4px 8px; border: 1px solid #f5b027; border-radius: 4px; font-size: 0.8rem; }
        
        .workspace { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; padding: 15px; flex: 1; }
        .viewport { background: #0a0f1a; border: 1px solid #1e2d42; border-radius: 6px; position: relative; display: flex; flex-direction: column; overflow: hidden; }
        .vp-header { background: #0d1522; padding: 8px 12px; border-bottom: 1px solid #1e2d42; font-weight: bold; font-size: 0.9rem; }
        
        /* Viewport 1: Map & Planimeter */
        .stage { flex: 1; position: relative; }
        #mapglobe { position: absolute; inset: 0; z-index: 1; opacity: 0.4; }
        #planimeter-overlay { position: absolute; inset: 0; z-index: 2; width: 100%; height: 100%; pointer-events: none; }
        
        /* Viewport 2: Spectral */
        .spectral-info { padding: 15px; font-size: 0.85rem; color: #e2e8f0; line-height: 1.6; }
        .spectral-info strong { color: #f5b027; }
        canvas#fftCanvas { width: 100%; height: 150px; background: #03060b; border-top: 1px solid #1e2d42; margin-top: auto; }
        
        button { background: #1e2d42; color: #00e5ff; border: 1px solid #00e5ff; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-family: inherit; font-weight: bold; }
        button:hover { background: #00e5ff; color: #000; }
        button.active { background: rgba(0,229,255,0.2); color: #fff; }
    </style>
</head>
<body>

    <header>
        <div><strong>🧭 VORTEX OS v158.0</strong> // CLEAN VIEWPORTS</div>
        <div>
            <span class="badge">STIER (TAURUS) LOCK: 51.4°</span>
            <button id="btn-audio" onclick="toggleAudio()">🔊 Start 432Hz Spectraal</button>
        </div>
    </header>

    <div class="workspace">
        <div class="viewport">
            <div class="vp-header">VP-1: Planimeter / Cellarius Raster</div>
            <div class="stage">
                <div id="mapglobe"></div>
                <svg id="planimeter-overlay" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid meet">
                    <circle cx="50" cy="50" r="45" stroke="rgba(0,229,255,0.3)" stroke-width="0.3" fill="none" stroke-dasharray="1,1"/>
                    <circle cx="50" cy="50" r="30" stroke="rgba(0,229,255,0.2)" stroke-width="0.3" fill="none"/>
                    
                    <circle cx="50" cy="50" r="1.5" fill="#f5b027" />
                    <text x="52" y="49" fill="#f5b027" font-size="2.5">Poolanker P</text>
                    
                    <line x1="50" y1="50" x2="30" y2="25" stroke="#f5b027" stroke-width="1.2" stroke-linecap="round"/>
                    <circle cx="30" cy="25" r="1.5" fill="#1e293b" stroke="#00e5ff" stroke-width="0.5"/>
                    <line x1="30" y1="25" x2="70" y2="15" stroke="#f5b027" stroke-width="0.8" stroke-linecap="round"/>
                    <circle cx="70" cy="15" r="2" fill="#ff3385" />
                    <text x="73" y="16" fill="#ff3385" font-size="2">Meetrol</text>
                </svg>
            </div>
        </div>

        <div class="viewport">
            <div class="vp-header">VP-2: Spectrale / Laser Node (FFT Analyzer)</div>
            <div class="spectral-info">
                Systeem is gesynchroniseerd met de astronomische en geodetische ankers.<br><br>
                • <strong>Laser Node:</strong> Fraunhofer D (589 nm) geactiveerd.<br>
                • <strong>Harmonische Audio:</strong> 432 Hz basislijn (Klaar voor input).<br>
                • <strong>Kinematica:</strong> A. Ott Nr. 573 configuratie succesvol geladen in het virtuele geheugen.
            </div>
            <canvas id="fftCanvas"></canvas>
        </div>
    </div>

    <script>
        // 1. Initialiseer de 3D Globe via MapLibre
        const map = new maplibregl.Map({
            container: 'mapglobe',
            style: 'https://basemaps.cartocdn.com/gl/dark-matter-gl-style/style.json',
            center: [5.22, 52.25], // Coördinaten Laren
            zoom: 3,
            pitch: 45
        });

        // 2. Web Audio API & FFT Analyzer
        let audioCtx, analyser, dataArray, canvasCtx, osc, isPlaying = false;

        function toggleAudio() {
            const btn = document.getElementById('btn-audio');
            if (isPlaying) {
                audioCtx.suspend();
                isPlaying = false;
                btn.classList.remove('active');
                btn.innerHTML = '🔊 Start 432Hz Spectraal';
                return;
            }

                audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                analyser = audioCtx.createAnalyser();
                analyser.fftSize = 128;
                
                // Genereer de 432Hz frequentie
                osc = audioCtx.createOscillator();
                osc.type = 'sine';
                osc.frequency.setValueAtTime(432, audioCtx.currentTime);
                
                const gain = audioCtx.createGain();
                gain.gain.value = 0.05; // Houd het volume laag en comfortabel

                osc.connect(gain);
                gain.connect(analyser);
                analyser.connect(audioCtx.destination);
                osc.start();

                dataArray = new Uint8Array(analyser.frequencyBinCount);
                
                const canvas = document.getElementById('fftCanvas');
                canvas.width = canvas.clientWidth;
                canvas.height = canvas.clientHeight;
                canvasCtx = canvas.getContext('2d');
                
                drawFFT();
            } else {
                audioCtx.resume();
            }
            
            isPlaying = true;
            btn.classList.add('active');
            btn.innerHTML = '⏸ Pauzeer Spectraal';
        }

        function drawFFT() {
            requestAnimationFrame(drawFFT);
            
            analyser.getByteFrequencyData(dataArray);
            
            const canvas = document.getElementById('fftCanvas');
            canvasCtx.fillStyle = '#03060b'; // Achtergrondkleur wissen
            canvasCtx.fillRect(0, 0, canvas.width, canvas.height);
            
            const barWidth = (canvas.width / dataArray.length) * 2.5;
            let x = 0;
            
            for (let i = 0; i < dataArray.length; i++) {
                const barHeight = dataArray[i] * 0.5;
                
                // Kleur afgestemd op de 589nm Fraunhofer D-lijn (Goud/Oranje)
                canvasCtx.fillStyle = 'rgb(245, ' + (176 - (barHeight * 0.5)) + ', 39)';
                canvasCtx.fillRect(x, canvas.height - barHeight, barWidth, barHeight);
                
                x += barWidth + 1;
            }
        }
    </script>
</body>
</html>
HTMLEOF

echo "Bestand succesvol aangemaakt! Openen in browser..."
xdg-open vortex_clean_viewports_v158.html 2>/dev/null &
