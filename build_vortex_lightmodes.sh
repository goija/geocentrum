#!/usr/bin/env bash
echo "Bouwen van vortex_clean_viewports_v158.html met 4 lichtmodi..."

cat << 'HTMLEOF' > vortex_clean_viewports_v158.html
<!DOCTYPE html>
<html lang="nl" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VORTEX OS v158.0 - 4 Lichtmodi (Helder, Donker, Daglicht, Nachtlicht)</title>
    
    <!-- MapLibre GL JS -->
    <link href="https://unpkg.com/maplibre-gl@3.3.1/dist/maplibre-gl.css" rel="stylesheet" />
    <script src="https://unpkg.com/maplibre-gl@3.3.1/dist/maplibre-gl.js"></script>
    
    <style>
        /* THEMA KLEURPROFIELEN (HELDER, DONKER, DAGLICHT, NACHTLICHT) */
        :root {
            --bg: #050811;
            --panel: #0b1018;
            --surface: #111927;
            --border: #1e2d42;
            --cyan: #00e5ff;
            --gold: #f5b027;
            --text: #e2e8f0;
            --muted: #8b9bb4;
        }

        [data-theme="light"] {
            --bg: #f8fafc;
            --panel: #ffffff;
            --surface: #f1f5f9;
            --border: #cbd5e1;
            --cyan: #0284c7;
            --gold: #d97706;
            --text: #0f172a;
            --muted: #64748b;
        }

        [data-theme="daylight"] {
            --bg: #fdf6e2;
            --panel: #eee8d5;
            --surface: #e5dfc9;
            --border: #b58900;
            --cyan: #268bd2;
            --gold: #b58900;
            --text: #363636;
            --muted: #657b83;
        }

        [data-theme="nightlight"] {
            --bg: #0a0202;
            --panel: #1a0505;
            --surface: #2b0808;
            --border: #5c1414;
            --cyan: #ff4d4d;
            --gold: #ffb84d;
            --text: #ff9999;
            --muted: #cc6666;
        }

        body { margin: 0; background: var(--bg); color: var(--text); font-family: 'Courier New', monospace; display: flex; flex-direction: column; height: 100vh; overflow: hidden; transition: 0.3s; }
        header { padding: 10px 18px; background: var(--panel); border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; }
        .badge { background: rgba(245,176,39,0.15); color: var(--gold); padding: 4px 8px; border: 1px solid var(--gold); border-radius: 4px; font-size: 0.75rem; }
        
        .light-mode-buttons { display: flex; gap: 5px; }
        .mode-btn { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 5px 10px; border-radius: 4px; cursor: pointer; font-family: inherit; font-size: 0.75rem; font-weight: bold; }
        .mode-btn.active { background: var(--cyan); color: #000; border-color: var(--cyan); }

        .workspace { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; padding: 12px; flex: 1; min-height: 0; }
        .viewport { background: var(--panel); border: 1px solid var(--border); border-radius: 6px; position: relative; display: flex; flex-direction: column; overflow: hidden; }
        .vp-header { background: var(--surface); padding: 8px 12px; border-bottom: 1px solid var(--border); font-weight: bold; font-size: 0.85rem; color: var(--cyan); }
        
        .stage { flex: 1; position: relative; }
        #mapglobe { position: absolute; inset: 0; z-index: 1; opacity: 0.5; }
        #planimeter-overlay { position: absolute; inset: 0; z-index: 2; width: 100%; height: 100%; pointer-events: none; }
        
        .spectral-info { padding: 15px; font-size: 0.85rem; color: var(--text); line-height: 1.6; }
        canvas#fftCanvas { width: 100%; height: 150px; background: var(--bg); border-top: 1px solid var(--border); margin-top: auto; }
        
        button.action-btn { background: var(--surface); color: var(--cyan); border: 1px solid var(--cyan); padding: 6px 12px; border-radius: 4px; cursor: pointer; font-family: inherit; font-weight: bold; font-size: 0.75rem; }
        button.action-btn:hover { background: var(--cyan); color: #000; }
        button.action-btn.active { background: rgba(0,229,255,0.2); }
    </style>
</head>
<body>

    <header>
        <div><strong>🧭 VORTEX OS v158.0</strong> // MULTI-LIGHT COCKPIT</div>
        <div class="light-mode-buttons">
            <button class="mode-btn" id="btn-light" onclick="setLightMode('light')">☀️ Helder</button>
            <button class="mode-btn active" id="btn-dark" onclick="setLightMode('dark')">🌑 Donker</button>
            <button class="mode-btn" id="btn-daylight" onclick="setLightMode('daylight')">🌤️ Daglicht</button>
            <button class="mode-btn" id="btn-nightlight" onclick="setLightMode('nightlight')">🔴 Nachtlicht</button>
        </div>
        <div>
            <button class="action-btn" id="btn-audio" onclick="toggleAudio()">🔊 Start 432Hz Spectraal</button>
        </div>
    </header>

    <div class="workspace">
        <!-- VIEWPORT 1 -->
        <div class="viewport">
            <div class="vp-header">VP-1: Planimeter / Cellarius Raster</div>
            <div class="stage">
                <div id="mapglobe"></div>
                <svg id="planimeter-overlay" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid meet">
                    <circle cx="50" cy="50" r="45" stroke="var(--cyan)" stroke-width="0.3" fill="none" stroke-dasharray="1,1" opacity="0.4"/>
                    <circle cx="50" cy="50" r="30" stroke="var(--cyan)" stroke-width="0.3" fill="none" opacity="0.3"/>
                    <circle cx="50" cy="50" r="1.5" fill="var(--gold)" />
                    <text x="52" y="49" fill="var(--gold)" font-size="2.5">Poolanker P</text>
                    <line x1="50" y1="50" x2="30" y2="25" stroke="var(--gold)" stroke-width="1.2" stroke-linecap="round"/>
                    <circle cx="30" cy="25" r="1.5" fill="var(--surface)" stroke="var(--cyan)" stroke-width="0.5"/>
                    <line x1="30" y1="25" x2="70" y2="15" stroke="var(--gold)" stroke-width="0.8" stroke-linecap="round"/>
                    <circle cx="70" cy="15" r="2" fill="#ff3385" />
                    <text x="73" y="16" fill="#ff3385" font-size="2">Meetrol</text>
                </svg>
            </div>
        </div>

        <!-- VIEWPORT 2 -->
        <div class="viewport">
            <div class="vp-header">VP-2: Spectrale / Laser Node (FFT Analyzer)</div>
            <div class="spectral-info">
                Systeem gesynchroniseerd met geodetische ankers[cite: 32].<br><br>
                • <strong>Laser Node:</strong> Fraunhofer D (589 nm) actief.<br>
                • <strong>Harmonische Audio:</strong> 432 Hz frequentie generator.<br>
                • <strong>Kinematica:</strong> A. Ott Nr. 573 arm geladen[cite: 32].
            </div>
            <canvas id="fftCanvas"></canvas>
        </div>
    </div>

    <script>
        // 1. Lichtmodi Schakelaar (Helder, Donker, Daglicht, Nachtlicht)
        function setLightMode(mode) {
            document.documentElement.setAttribute('data-theme', mode);
            document.querySelectorAll('.mode-btn').forEach(b => b.classList.remove('active'));
            document.getElementById('btn-' + mode).classList.add('active');

            // MapLibre thema stijl aanpassen indien nodig
            if (map) {
                const styleUrl = (mode === 'light' || mode === 'daylight') 
                    ? 'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json'
                    : 'https://basemaps.cartocdn.com/gl/dark-matter-gl-style/style.json';
                map.setStyle(styleUrl);
            }
        }

        // 2. Initialiseer 3D Globe
        const map = new maplibregl.Map({
            container: 'mapglobe',
            style: 'https://basemaps.cartocdn.com/gl/dark-matter-gl-style/style.json',
            center: [5.22, 52.25], // Laren
            zoom: 3,
            pitch: 45
        });

        // 3. Web Audio API & FFT Analyzer
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

            if (!audioCtx) {
                audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                analyser = audioCtx.createAnalyser();
                analyser.fftSize = 128;
                
                osc = audioCtx.createOscillator();
                osc.type = 'sine';
                osc.frequency.setValueAtTime(432, audioCtx.currentTime);
                
                const gain = audioCtx.createGain();
                gain.gain.value = 0.05;

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
            if (!isPlaying) return;
            requestAnimationFrame(drawFFT);
            
            analyser.getByteFrequencyData(dataArray);
            
            const canvas = document.getElementById('fftCanvas');
            canvasCtx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--bg').trim();
            canvasCtx.fillRect(0, 0, canvas.width, canvas.height);
            
            const barWidth = (canvas.width / dataArray.length) * 2.5;
            let x = 0;
            
            for (let i = 0; i < dataArray.length; i++) {
                const barHeight = dataArray[i] * 0.5;
                canvasCtx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--gold').trim();
                canvasCtx.fillRect(x, canvas.height - barHeight, barWidth, barHeight);
                x += barWidth + 1;
            }
        }
    </script>
</body>
</html>
HTMLEOF

echo "Bestand succesvol aangemaakt met 4 lichtmodi!"
xdg-open vortex_clean_viewports_v158.html 2>/dev/null &
