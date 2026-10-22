#!/usr/bin/env bash
echo "Bouwen van vortex_planimeter_viewer_v154.7.html..."

cat << 'HTMLEOF' > vortex_planimeter_viewer_v154_7.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS // OTT NR. 573 PLANIMETER & SVG EXPORT v154.7</title>
  <style>
    :root {
      --bg: #070a0f;
      --panel: rgba(10, 15, 24, 0.94);
      --border: #1e293b;
      --cyan: #00e5ff;
      --gold: #fbbf24;
      --magenta: #ec4899;
      --mg-green: #50ffb0;
      --text: #e2e8f0;
      --muted: #94a3b8;
      --font-mono: 'JetBrains Mono', 'Fira Code', 'Courier New', monospace;
    }

    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background: var(--bg);
      color: var(--text);
      font-family: system-ui, -apple-system, sans-serif;
      height: 100vh;
      width: 100vw;
      overflow: hidden;
      display: flex;
    }

    .hud-sidebar {
      width: 390px;
      background: var(--panel);
      border-right: 1px solid var(--border);
      padding: 12px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      gap: 10px;
      z-index: 10;
      backdrop-filter: blur(8px);
    }

    #viewport {
      flex: 1;
      height: 100vh;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      background: radial-gradient(circle at center, #111927 0%, #06090e 100%);
      overflow: hidden;
    }

    #geosint-svg {
      width: 100%;
      height: 100%;
      cursor: crosshair;
    }

    .card {
      background: rgba(15, 23, 42, 0.65);
      border: 1px solid var(--border);
      border-radius: 5px;
      padding: 9px 11px;
    }
    .card-title {
      font-family: var(--font-mono);
      font-size: 0.72rem;
      font-weight: 700;
      color: var(--cyan);
      text-transform: uppercase;
      border-bottom: 1px solid var(--border);
      padding-bottom: 4px;
      margin-bottom: 6px;
      display: flex;
      justify-content: space-between;
    }

    .kv {
      display: flex;
      justify-content: space-between;
      font-family: var(--font-mono);
      font-size: 0.68rem;
      padding: 2.5px 0;
      color: var(--muted);
    }
    .kv b { color: var(--text); font-weight: 600; }
    .kv .hl-gold { color: var(--gold); }
    .kv .hl-cyan { color: var(--cyan); }
    .kv .hl-mg { color: var(--mg-green); }

    .btn {
      width: 100%;
      background: rgba(0, 229, 255, 0.12);
      border: 1px solid var(--cyan);
      color: var(--cyan);
      padding: 6px;
      border-radius: 4px;
      font-family: var(--font-mono);
      font-size: 0.72rem;
      cursor: pointer;
      font-weight: bold;
      margin-top: 4px;
      transition: all 0.2s;
    }
    .btn:hover { background: rgba(0, 229, 255, 0.25); }
    .btn-save { background: rgba(251, 191, 36, 0.12); border-color: var(--gold); color: var(--gold); }
    .btn-save:hover { background: rgba(251, 191, 36, 0.25); }
    .btn-svg { background: rgba(236, 72, 153, 0.12); border-color: var(--magenta); color: var(--magenta); }
    .btn-svg:hover { background: rgba(236, 72, 153, 0.25); }

    input[type="file"] {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      color: var(--muted);
      width: 100%;
      margin-top: 4px;
    }

    .viewport-overlay {
      position: absolute;
      top: 15px;
      left: 15px;
      font-family: var(--font-mono);
      font-size: 0.7rem;
      color: var(--cyan);
      background: rgba(5, 8, 15, 0.88);
      border: 1px solid var(--border);
      padding: 8px 12px;
      border-radius: 5px;
      line-height: 1.4;
      pointer-events: none;
      z-index: 20;
    }
  </style>
</head>
<body tabindex="0">

  <!-- LINKER PANEEL -->
  <aside class="hud-sidebar">
    <div class="card">
      <div class="card-title"><span>= VORTEX OTT NR. 573 HUD</span><span style="color:var(--gold)">v154.7</span></div>
      <div class="kv"><span>Muis-modus:</span><b class="hl-mg" id="lbl-mouse-mode">Vrij Bewegend (Actief)</b></div>
      <div class="kv"><span>Volgstift T(x,y):</span><b class="hl-cyan" id="hud-tx-ty">[0.00, +10.75] cm</b></div>
      <div class="kv"><span>Nonius Eindstand:</span><b class="hl-gold" id="hud-nonius">3630 / 3630 (363.0 cm²)</b></div>
    </div>

    <!-- Afbeelding Laden, Exporteren & Opslaan -->
    <div class="card">
      <div class="card-title"><span>Viewer Afbeelding & Exporteren</span><span>IO</span></div>
      <div class="kv" style="margin-bottom:2px;"><span>Laad Afbeelding in Viewer:</span></div>
      <input type="file" accept="image/*" onchange="loadViewerImage(event)">
      <div class="kv" style="margin-top:6px;"><span>Afbeelding Transparantie:</span><b id="lbl-img-op">50%</b></div>
      <input type="range" min="0" max="100" value="50" oninput="setImageOpacity(this.value)" style="width:100%; accent-color:var(--cyan); margin-top:3px;">
      
      <button class="btn btn-save" onclick="saveSessionReport()">💾 Sla Meting & Rapport Op (.txt)</button>
      <button class="btn btn-svg" onclick="exportSvgCanvas()">🖼️ Exporteer Volledige SVG (.svg)</button>
    </div>

    <!-- Planimeter Telemetrie -->
    <div class="card">
      <div class="card-title"><span>Kinematica & Shao Yong</span><span>#573</span></div>
      <div class="kv"><span>Actieve Azimut (θ):</span><b class="hl-gold" id="hud-theta">0.00°</b></div>
      <div class="kv"><span>Shao Yong Sector (1/64):</span><b class="hl-cyan" id="hud-sy">#31 (111111)</b></div>
      <div class="kv"><span>Scharnier G(x,y):</span><b id="hud-gx-gy">[-3.48, +6.65] cm</b></div>
      <button class="btn" onclick="resetToBeginstand()">🎯 Reset naar Beginstand [0]</button>
    </div>
  </aside>

  <!-- RECHTER VIEWPORT -->
  <main id="viewport">
    <div class="viewport-overlay">
      <div>VOLGSTIFT: <b id="vp-pos" style="color:var(--gold)">[0.00, +10.75] cm</b> | NONIUS: <b id="vp-nonius">3630</b></div>
      <div>TOETSEN: <b>[G]</b> Vrij/Vast | <b>[T]</b> Stempel Meetpunt | <b>[0]</b> Reset</div>
    </div>

    <svg id="geosint-svg" viewBox="-480 -480 960 960" preserveAspectRatio="xMidYMid meet">
      <defs>
        <pattern id="grid-fine" width="20" height="20" patternUnits="userSpaceOnUse">
          <path d="M 20 0 L 0 0 0 20" fill="none" stroke="rgba(45, 212, 191, 0.08)" stroke-width="0.6"/>
        </pattern>
        <pattern id="grid-major" width="100" height="100" patternUnits="userSpaceOnUse">
          <rect width="100" height="100" fill="url(#grid-fine)"/>
          <path d="M 100 0 L 0 0 0 100" fill="none" stroke="rgba(45, 212, 191, 0.18)" stroke-width="1"/>
        </pattern>
      </defs>

      <!-- Achtergrond Raster -->
      <rect x="-480" y="-480" width="960" height="960" fill="url(#grid-major)"/>

      <!-- Ingeladen Afbeeldingslaag (Viewer Image) -->
      <image id="user-viewer-image" href="" x="-480" y="-480" width="960" height="960" preserveAspectRatio="xMidYMid meet" opacity="0.5" style="display:none;" />

      <!-- Shao Yong Ring -->
      <g id="layer-shao"></g>

      <!-- Magnesium Stempel / Overtrek Laag -->
      <g id="layer-stamps"></g>

      <!-- Planimeter Laag -->
      <g id="layer-planimeter"></g>
    </svg>
  </main>

  <script>
    const PX_PER_CM = 40;
    const R_KOMPAS_PX = 10.749 * PX_PER_CM;

    const state = {
      tx: 0,
      ty: -R_KOMPAS_PX,
      mouseActive: true,
      stamps: []
    };

    function initHUD() {
      const syGroup = document.getElementById('layer-shao');
      let sHtml = `<circle cx="0" cy="0" r="${R_KOMPAS_PX}" fill="none" stroke="#00e5ff" stroke-width="1.5" opacity="0.75"/>`;
      for (let i = 0; i < 64; i++) {
        const ang = (i * 5.625 - 90) * Math.PI / 180;
        const x1 = Math.cos(ang) * (R_KOMPAS_PX - 25);
        const y1 = Math.sin(ang) * (R_KOMPAS_PX - 25);
        const x2 = Math.cos(ang) * R_KOMPAS_PX;
        const y2 = Math.sin(ang) * R_KOMPAS_PX;
        sHtml += `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="#00e5ff" stroke-width="0.8"/>`;
      }
      syGroup.innerHTML = sHtml;
      updatePlanimeter(0, -R_KOMPAS_PX);
    }

    function updatePlanimeter(tx, ty) {
      state.tx = tx;
      state.ty = ty;

      const px = 0, py = -300;
      const R = 300, L = 430;
      const dx = tx - px, dy = ty - py;
      let d = Math.hypot(dx, dy);
      if (d > R + L - 2) d = R + L - 2;
      if (d < Math.abs(R - L) + 2) d = Math.abs(R - L) + 2;

      const a = (R * R - L * L + d * d) / (2 * d);
      const h = Math.sqrt(Math.max(0, R * R - a * a));
      const mx = px + a * (dx / d);
      const my = py + a * (dy / d);
      const gx = mx - h * (dy / d);
      const gy = my + h * (dx / d);

      const deg = (Math.atan2(ty, tx) * 180 / Math.PI + 90 + 360) % 360;
      const nonius = Math.round((deg / 360) * 3630);
      const area = (nonius * 0.1).toFixed(1);
      const syIdx = Math.floor(deg / 5.625) % 64;

      const pGroup = document.getElementById('layer-planimeter');
      let pHtml = '';
      pHtml += `<line x1="${px}" y1="${py}" x2="${gx}" y2="${gy}" stroke="#d4af37" stroke-width="14" stroke-linecap="round"/>`;
      pHtml += `<line x1="${gx}" y1="${gy}" x2="${tx}" y2="${ty}" stroke="#eab308" stroke-width="10" stroke-linecap="round"/>`;
      pHtml += `<circle cx="${px}" cy="${py}" r="7" fill="#92400e" stroke="#fde047" stroke-width="2"/>`;
      pHtml += `<circle cx="${gx}" cy="${gy}" r="9" fill="#451a03" stroke="#facc15" stroke-width="2"/>`;
      pHtml += `<circle cx="${tx}" cy="${ty}" r="9" fill="rgba(0,229,255,0.25)" stroke="#00e5ff" stroke-width="2"/>`;
      pHtml += `<circle cx="${tx}" cy="${ty}" r="2.5" fill="#ffffff"/>`;
      pGroup.innerHTML = pHtml;

      const xCm = (tx / PX_PER_CM).toFixed(2);
      const yCm = (-ty / PX_PER_CM).toFixed(2);
      document.getElementById('hud-tx-ty').textContent = `[${xCm}, ${yCm}] cm`;
      document.getElementById('hud-gx-gy').textContent = `[${(gx / PX_PER_CM).toFixed(2)}, ${(-gy / PX_PER_CM).toFixed(2)}] cm`;
      document.getElementById('hud-nonius').textContent = `${nonius} / 3630 (${area} cm²)`;
      document.getElementById('hud-theta').textContent = `${deg.toFixed(2)}°`;
      document.getElementById('hud-sy').textContent = `#${syIdx}`;
      document.getElementById('vp-pos').textContent = `[${xCm}, ${yCm}] cm`;
      document.getElementById('vp-nonius').textContent = nonius;
    }

    function stampPoint() {
      state.stamps.push({ x: state.tx, y: state.ty, nonius: document.getElementById('vp-nonius').textContent });
      renderStamps();
    }

    function renderStamps() {
      const group = document.getElementById('layer-stamps');
      let html = '';
      state.stamps.forEach((s, idx) => {
        html += `<circle cx="${s.x}" cy="${s.y}" r="5" fill="#50ffb0" stroke="#000" stroke-width="1.5"/>`;
        html += `<text x="${s.x + 8}" y="${s.y + 3}" fill="#50ffb0" font-size="9" font-family="monospace">M${idx+1}</text>`;
      });
      group.innerHTML = html;
    }

    function loadViewerImage(event) {
      const file = event.target.files[0];
      if (!file) return;
      const url = URL.createObjectURL(file);
      const imgEl = document.getElementById('user-viewer-image');
      imgEl.setAttribute('href', url);
      imgEl.style.display = 'block';
    }

    function setImageOpacity(val) {
      document.getElementById('lbl-img-op').textContent = val + '%';
      document.getElementById('user-viewer-image').setAttribute('opacity', val / 100);
    }

    function saveSessionReport() {
      const data = [
        "=== VORTEX OTT NR. 573 PLANIMETER RAPPORT ===",
        `Tijdstip: ${new Date().toISOString()}`,
        `Volgstift Positie T(x,y): ${document.getElementById('hud-tx-ty').textContent}`,
        `Nonius Eindstand: ${document.getElementById('hud-nonius').textContent}`,
        `Actieve Azimut Hoek: ${document.getElementById('hud-theta').textContent}`,
        `Aantal Gestempelde Punten: ${state.stamps.length}`
      ].join('\n');

      const blob = new Blob([data], { type: 'text/plain' });
      const a = document.createElement('a');
      a.href = URL.createObjectURL(blob);
      a.download = `vortex_rapport_${Date.now()}.txt`;
      a.click();
    }

    function exportSvgCanvas() {
      const svgOuter = document.getElementById('geosint-svg').outerHTML;
      const blob = new Blob([svgOuter], { type: 'image/svg+xml' });
      const a = document.createElement('a');
      a.href = URL.createObjectURL(blob);
      a.download = `vortex_hud_export_${Date.now()}.svg`;
      a.click();
    }

    function resetToBeginstand() {
      updatePlanimeter(0, -R_KOMPAS_PX);
    }

    const svgEl = document.getElementById('geosint-svg');
    svgEl.addEventListener('mousemove', (e) => {
      if (!state.mouseActive) return;
      const pt = svgEl.createSVGPoint();
      pt.x = e.clientX; pt.y = e.clientY;
      const cursor = pt.matrixTransform(svgEl.getScreenCTM().inverse());
      updatePlanimeter(cursor.x, cursor.y);
    });

    window.addEventListener('keydown', (e) => {
      if (e.key === '0' || e.key === 'Home') resetToBeginstand();
      if (e.key === 't' || e.key === 'T' || e.key === 'Enter') stampPoint();
      if (e.key === 'g' || e.key === 'G') {
        state.mouseActive = !state.mouseActive;
        document.getElementById('lbl-mouse-mode').textContent = state.mouseActive ? "Vrij Bewegend (Actief)" : "Vergrendeld";
      }
    });

    initHUD();
  </script>
</body>
</html>
HTMLEOF

echo "Bestand succesvol aangemaakt: vortex_planimeter_viewer_v154.7.html"
xdg-open vortex_planimeter_viewer_v154.7.html 2>/dev/null &
