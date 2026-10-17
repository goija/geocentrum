#!/bin/bash
set -e

echo "🌀 VORTEX OS v158.4 — Native Quad Viewport Architecture (No Iframes)..."

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
cd "$TARGET_DIR"

cat << 'HTML_EOF' > vortex_omni_master_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.4 — Native Multi-Viewport Cockpit</title>
  <script src="./assets_manifest.js"></script>
  <style>
    :root { 
      --bg: #030712; 
      --panel: rgba(15,23,42,0.95); 
      --cyan: #00e5ff; 
      --gold: #ffcc33; 
      --magenta: #ff3385; 
      --green: #00ff88;
      --text: #f1f5f9; 
      --font: 'Fira Code', monospace; 
    }
    * { box-sizing: border-box; margin:0; padding:0; }
    body { 
      background: var(--bg); 
      color: var(--text); 
      font-family: var(--font); 
      height: 100vh; 
      display: flex; 
      flex-direction: column; 
      overflow: hidden;
    }
    header { 
      background: #0f172a; 
      padding: 0.6rem 1.2rem; 
      border-bottom: 1px solid #1e293b; 
      display: flex; 
      justify-content: space-between; 
      align-items: center;
    }
    h1 { font-size: 1.1rem; color: var(--cyan); }
    main { 
      display: grid; 
      grid-template-columns: 280px 1fr 300px; 
      flex: 1; 
      height: calc(100vh - 45px);
    }
    .sidebar { 
      background: var(--panel); 
      border-right: 1px solid #1e293b; 
      padding: 1rem; 
      font-size: 0.75rem; 
      display: flex;
      flex-direction: column;
      gap: 0.6rem;
      overflow-y: auto;
    }
    .sidebar.right { 
      border-right: none; 
      border-left: 1px solid #1e293b; 
    }
    .nav-button {
      display: block;
      width: 100%;
      padding: 8px 12px;
      background: rgba(255,255,255,0.03);
      border: 1px solid rgba(0,229,255,0.25);
      border-radius: 4px;
      color: var(--cyan);
      font-family: var(--font);
      font-size: 0.75rem;
      text-align: left;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    .nav-button:hover, .nav-button.active {
      background: rgba(0,229,255,0.15);
      border-color: var(--cyan);
      color: #fff;
      box-shadow: 0 0 10px rgba(0,229,255,0.3);
    }
    .viewport-grid { 
      display: grid; 
      grid-template-columns: 1fr 1fr; 
      grid-template-rows: 1fr 1fr; 
      gap: 4px;
      padding: 4px;
      background: #02040a; 
      width: 100%;
      height: 100%;
    }
    .viewport-grid.single-mode {
      grid-template-columns: 1fr;
      grid-template-rows: 1fr;
    }
    .native-viewport {
      background: #090d16;
      border: 1px solid #1e293b;
      border-radius: 4px;
      position: relative;
      display: flex;
      flex-direction: column;
      overflow: hidden;
    }
    .viewport-header {
      background: rgba(15,23,42,0.9);
      padding: 4px 8px;
      font-size: 0.7rem;
      color: var(--gold);
      border-bottom: 1px solid #1e293b;
      display: flex;
      justify-content: space-between;
      align-items: center;
      z-index: 10;
    }
    .viewport-body {
      flex: 1;
      position: relative;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
    .hud-canvas {
      width: 100%;
      height: 100%;
      display: block;
    }
    .overlay-info {
      position: absolute;
      bottom: 10px;
      left: 10px;
      background: rgba(3,7,18,0.85);
      border: 1px solid var(--cyan);
      padding: 6px 10px;
      border-radius: 4px;
      font-size: 0.68rem;
      color: var(--cyan);
      pointer-events: none;
    }
  </style>
</head>
<body>

<header>
  <h1>🌀 VORTEX OS v158.4 — NATIVE MULTI-VIEWPORT ENGINE</h1>
  <div style="font-size: 0.72rem; color: #64748b; display:flex; gap:12px; align-items:center;">
    <span style="color:var(--green);">● NATIVE CANVAS: ACTIVE</span>
    <span>Node: Mathgeo-Seven</span>
  </div>
</header>

<main>
  <section class="sidebar">
    <h3 style="color:var(--gold); margin-bottom:0.2rem;">🧭 VIEWPORT CONTROLS</h3>
    <button class="nav-button active" onclick="switchMode('quad')">🔲 Quad Viewport Grid (4x)</button>
    <button class="nav-button" onclick="switchMode('bipolar')">🎯 Viewport 1: Bipolar HUD</button>
    <button class="nav-button" onclick="switchMode('globe')">🌍 Viewport 2: 3D Vector Globe</button>
    <button class="nav-button" onclick="switchMode('caustic')">🌸 Viewport 3: k=7 Caustic Layer</button>
    <button class="nav-button" onclick="switchMode('nebra')">🌌 Viewport 4: Nebra Pleiades</button>
    <hr style="border-color:#1e293b; margin:4px 0;">
    <a class="nav-button" href="/vortex_geodetic_refraction_report-v2.pdf" target="_blank" style="color:var(--gold); text-decoration:none;">📄 PDF Audit Rapport v2</a>
    <a class="nav-button" href="/naamloos_dossier.pdf" target="_blank" style="color:var(--green); text-decoration:none;">📄 Nieuw Dossier PDF</a>
  </section>

  <section id="gridContainer" class="viewport-grid">
    <div id="vp1" class="native-viewport">
      <div class="viewport-header">
        <span>VP1: BIPOLAR HUD & VISOR (245,91°)</span>
        <span style="color:var(--cyan);">[CANVAS 2D]</span>
      </div>
      <div class="viewport-body">
        <canvas id="canvasBipolar" class="hud-canvas"></canvas>
        <div class="overlay-info">Azimut: 245,91° WZW | Refractie: -3,80°</div>
      </div>
    </div>

    <div id="vp2" class="native-viewport">
      <div class="viewport-header">
        <span>VP2: GEODETIC VECTOR GLOBE</span>
        <span style="color:var(--green);">[WEBGL / MAPLIBRE]</span>
      </div>
      <div class="viewport-body">
        <canvas id="canvasGlobe" class="hud-canvas"></canvas>
        <div class="overlay-info">RD: 155000, 463000 | Biskaje Corridor</div>
      </div>
    </div>

    <div id="vp3" class="native-viewport">
      <div class="viewport-header">
        <span>VP3: k=7 CAUSTIC MATRIX</span>
        <span style="color:var(--magenta);">[SPECTRAL MESH]</span>
      </div>
      <div class="viewport-body">
        <canvas id="canvasCaustic" class="hud-canvas"></canvas>
        <div class="overlay-info">Caustic k=7 | λ = 589,0 nm</div>
      </div>
    </div>

    <div id="vp4" class="native-viewport">
      <div class="viewport-header">
        <span>VP4: NEBRA PLEIADES SOLSTITIUM</span>
        <span style="color:var(--gold);">[CELESTIAL OVERLAY]</span>
      </div>
      <div class="viewport-body">
        <canvas id="canvasNebra" class="hud-canvas"></canvas>
        <div class="overlay-info">η Tauri (Pleiaden) | Solstitium Bogen</div>
      </div>
    </div>
  </section>

  <section class="sidebar right">
    <h3 style="color:var(--gold); margin-bottom:0.5rem;">📊 NATIVE ENGINE STATUS</h3>
    <p><strong>Architecture:</strong> Single-DOM Viewports</p>
    <p><strong>Render Loop:</strong> requestAnimationFrame</p>
    <p><strong>Attractor N²:</strong> 010101 (Hex #21)</p>
    <p><strong>Snellius Δθ:</strong> -3,80° (Biskaje)</p>
    <p><strong>Laser D-Line:</strong> 589,0 nm</p>
  </section>
</main>

<script>
  const cBipolar = document.getElementById('canvasBipolar');
  const cGlobe = document.getElementById('canvasGlobe');
  const cCaustic = document.getElementById('canvasCaustic');
  const cNebra = document.getElementById('canvasNebra');

  function resizeCanvases() {
    [cBipolar, cGlobe, cCaustic, cNebra].forEach(c => {
      if(c && c.parentElement) {
        c.width = c.parentElement.clientWidth;
        c.height = c.parentElement.clientHeight;
      }
    });
  }
  window.addEventListener('resize', resizeCanvases);

  let angle = 0;
  function renderNativeLoop() {
    angle += 0.01;
    resizeCanvases();

    // VP1: Bipolar Compass
    if(cBipolar && cBipolar.getContext('2d')) {
      const ctx = cBipolar.getContext('2d');
      const w = cBipolar.width, h = cBipolar.height;
      ctx.clearRect(0, 0, w, h);
      ctx.strokeStyle = '#00e5ff';
      ctx.lineWidth = 1.5;
      ctx.beginPath();
      ctx.arc(w/2, h/2, Math.min(w,h)*0.3, 0, Math.PI*2);
      ctx.stroke();

      const rad = (245.91 - 90) * Math.PI / 180;
      ctx.strokeStyle = '#ff3385';
      ctx.beginPath();
      ctx.moveTo(w/2, h/2);
      ctx.lineTo(w/2 + Math.cos(rad)*w*0.4, h/2 + Math.sin(rad)*h*0.4);
      ctx.stroke();
    }

    // VP2: Globe Orthographic Mesh
    if(cGlobe && cGlobe.getContext('2d')) {
      const ctx = cGlobe.getContext('2d');
      const w = cGlobe.width, h = cGlobe.height;
      ctx.clearRect(0, 0, w, h);
      ctx.strokeStyle = '#00ff88';
      ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.arc(w/2, h/2, Math.min(w,h)*0.35, 0, Math.PI*2);
      ctx.stroke();

      for(let i=0; i<6; i++) {
        ctx.beginPath();
        ctx.ellipse(w/2, h/2, Math.abs(Math.sin(angle + i))*Math.min(w,h)*0.35, Math.min(w,h)*0.35, 0, 0, Math.PI*2);
        ctx.stroke();
      }
    }

    // VP3: k=7 Caustic
    if(cCaustic && cCaustic.getContext('2d')) {
      const ctx = cCaustic.getContext('2d');
      const w = cCaustic.width, h = cCaustic.height;
      ctx.clearRect(0, 0, w, h);
      ctx.strokeStyle = '#ffcc33';
      ctx.lineWidth = 1;

      ctx.beginPath();
      for(let t=0; t<Math.PI*2; t+=0.02) {
        const r = Math.sin(7 * t + angle) * Math.min(w,h) * 0.35;
        const x = w/2 + r * Math.cos(t);
        const y = h/2 + r * Math.sin(t);
        if(t===0) ctx.moveTo(x,y); else ctx.lineTo(x,y);
      }
      ctx.stroke();
    }

    // VP4: Nebra Star Cluster
    if(cNebra && cNebra.getContext('2d')) {
      const ctx = cNebra.getContext('2d');
      const w = cNebra.width, h = cNebra.height;
      ctx.clearRect(0, 0, w, h);

      ctx.fillStyle = 'rgba(255, 204, 51, 0.15)';
      ctx.strokeStyle = '#ffcc33';
      ctx.beginPath();
      ctx.arc(w/2, h/2, Math.min(w,h)*0.32, 0, Math.PI*2);
      ctx.fill();
      ctx.stroke();

      ctx.fillStyle = '#00e5ff';
      const stars = [[0,0], [15,-10], [-10,12], [20,15], [-20,-15], [5,25], [-15,-5]];
      stars.forEach(([sx, sy]) => {
        ctx.beginPath();
        ctx.arc(w/2 + sx*2, h/2 + sy*2, 3, 0, Math.PI*2);
        ctx.fill();
      });
    }

    requestAnimationFrame(renderNativeLoop);
  }

  function switchMode(mode) {
    const grid = document.getElementById('gridContainer');
    const vps = [document.getElementById('vp1'), document.getElementById('vp2'), document.getElementById('vp3'), document.getElementById('vp4')];
    document.querySelectorAll('.nav-button').forEach(btn => btn.classList.remove('active'));

    if(mode === 'quad') {
      grid.classList.remove('single-mode');
      vps.forEach(vp => vp.style.display = 'flex');
      event.target.classList.add('active');
    } else {
      grid.classList.add('single-mode');
      vps.forEach(vp => vp.style.display = 'none');
      if(mode === 'bipolar') vps[0].style.display = 'flex';
      if(mode === 'globe') vps[1].style.display = 'flex';
      if(mode === 'caustic') vps[2].style.display = 'flex';
      if(mode === 'nebra') vps[3].style.display = 'flex';
      event.target.classList.add('active');
    }
    setTimeout(resizeCanvases, 50);
  }

  window.onload = () => {
    resizeCanvases();
    renderNativeLoop();
  };
</script>

</body>
</html>
HTML_EOF

cp -f vortex_omni_master_v158.html index.html

# 2. Deployen naar Git en Vercel
git add -f vortex_omni_master_v158.html index.html vercel.json 2>/dev/null || true
git commit -m "Upgrade to native DOM viewports and Canvas 2D engine" || true
./vortex_master_deploy.sh
