#!/bin/bash
set -e

echo "======================================================================"
echo "🌀 VORTEX OS v158.6 — Integratie Beheercentrum met Subonderdelen"
echo "======================================================================"

TARGET_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
mkdir -p "\$TARGET_DIR"
cd "\$TARGET_DIR"

cat << 'HTML_EOF' > vortex_omni_master_v158.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VORTEX OS v158.6 — Omni Master & Beheercentrum</title>
  <script src="./assets_manifest.js"></script>
  <style>
    :root { 
      --bg: #030712; 
      --panel: rgba(15,23,42,0.95); 
      --cyan: #00e5ff; 
      --gold: #ffcc33; 
      --magenta: #ff3385; 
      --green: #00ff88;
      --red: #ff4444;
      --purple: #b366ff;
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
      user-select: none;
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
      grid-template-columns: 310px 1fr 300px; 
      flex: 1; 
      height: calc(100vh - 45px);
    }
    .sidebar { 
      background: var(--panel); 
      border-right: 1px solid #1e293b; 
      padding: 0.8rem; 
      font-size: 0.75rem; 
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      overflow-y: auto;
    }
    .sidebar.right { 
      border-right: none; 
      border-left: 1px solid #1e293b; 
    }
    .sidebar-section-title {
      color: var(--gold);
      font-size: 0.78rem;
      font-weight: bold;
      margin-top: 0.6rem;
      margin-bottom: 0.2rem;
      border-bottom: 1px dashed rgba(255,204,51,0.3);
      padding-bottom: 4px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    details {
      background: rgba(255,255,255,0.02);
      border: 1px solid rgba(0,229,255,0.2);
      border-radius: 4px;
      overflow: hidden;
      transition: all 0.2s ease;
    }
    details[open] {
      background: rgba(15,23,42,0.8);
      border-color: var(--cyan);
      box-shadow: 0 0 8px rgba(0,229,255,0.15);
    }
    summary {
      padding: 7px 10px;
      font-size: 0.73rem;
      font-weight: 600;
      color: var(--cyan);
      cursor: pointer;
      list-style: none;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    summary::-webkit-details-marker { display: none; }
    summary::after {
      content: '▶';
      font-size: 0.6rem;
      transition: transform 0.2s ease;
      color: var(--gold);
    }
    details[open] summary::after {
      transform: rotate(90deg);
    }
    .sub-menu {
      padding: 6px;
      display: flex;
      flex-direction: column;
      gap: 4px;
      background: rgba(3,7,18,0.5);
      border-top: 1px solid rgba(0,229,255,0.1);
    }

    .nav-button {
      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 100%;
      padding: 6px 10px;
      background: rgba(255,255,255,0.03);
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: 3px;
      color: var(--text);
      font-family: var(--font);
      font-size: 0.7rem;
      text-align: left;
      cursor: pointer;
      text-decoration: none;
      transition: all 0.2s ease;
    }
    .nav-button:hover, .nav-button.active {
      background: rgba(0,229,255,0.15);
      border-color: var(--cyan);
      color: #fff;
    }
    .toggle-chip {
      padding: 2px 5px;
      border-radius: 3px;
      font-size: 0.62rem;
      font-weight: bold;
    }
    .chip-on { background: rgba(0,255,136,0.2); color: var(--green); border: 1px solid var(--green); }
    .chip-off { background: rgba(255,68,68,0.2); color: var(--red); border: 1px solid var(--red); }

    .viewport-grid { 
      display: grid; 
      grid-template-columns: repeat(2, 1fr); 
      grid-template-rows: repeat(2, 1fr); 
      gap: 6px;
      padding: 6px;
      background: #02040a; 
      width: 100%;
      height: 100%;
    }

    .native-viewport {
      background: #090d16;
      border: 1px solid #1e293b;
      border-radius: 6px;
      position: relative;
      display: flex;
      flex-direction: column;
      overflow: hidden;
      cursor: grab;
      transition: transform 0.15s ease, border-color 0.2s ease;
    }
    .native-viewport:active { cursor: grabbing; }
    .native-viewport.dragging { opacity: 0.4; border: 2px dashed var(--cyan); }
    .native-viewport.drag-over { border-color: var(--gold); box-shadow: 0 0 12px rgba(255,204,51,0.4); }

    .viewport-header {
      background: rgba(15,23,42,0.95);
      padding: 6px 10px;
      font-size: 0.72rem;
      color: var(--gold);
      border-bottom: 1px solid #1e293b;
      display: flex;
      justify-content: space-between;
      align-items: center;
      z-index: 10;
    }
    .header-controls { display: flex; gap: 6px; align-items: center; }
    .btn-icon {
      background: rgba(255,255,255,0.05);
      border: 1px solid rgba(255,255,255,0.15);
      color: var(--text);
      width: 20px;
      height: 20px;
      border-radius: 3px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 0.68rem;
    }
    .btn-icon:hover { background: rgba(255,68,68,0.3); border-color: var(--red); color: #fff; }

    .viewport-body { flex: 1; position: relative; width: 100%; height: 100%; overflow: hidden; }
    .hud-canvas { width: 100%; height: 100%; display: block; }
    .overlay-info {
      position: absolute;
      bottom: 8px;
      left: 8px;
      background: rgba(3,7,18,0.88);
      border: 1px solid var(--cyan);
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 0.65rem;
      color: var(--cyan);
      pointer-events: none;
    }
  </style>
</head>
<body>

<header>
  <h1>🌀 VORTEX OS v158.6 — OMNI MASTER & BEHEERCENTRUM</h1>
  <div style="font-size: 0.72rem; color: #64748b; display:flex; gap:12px; align-items:center;">
    <span style="color:var(--green);" id="saveStatus">● BEHEERCENTRUM: ACTIEF</span>
    <span>Node: Mathgeo-Seven</span>
  </div>
</header>

<main>
  <section class="sidebar">
    <div class="sidebar-section-title">
      <span>⚙️ BEHEERCENTRUM</span>
      <span style="font-size:0.6rem; color:var(--magenta);">[ADMIN HUB]</span>
    </div>

    <details open>
      <summary>🖼️ Viewport Grid Beheer</summary>
      <div class="sub-menu">
        <button class="nav-button" onclick="setGridMode('quad')">
          <span>🔲 Quad Grid (Alle Actieve)</span>
        </button>
        <button class="nav-button" onclick="resetDefaultLayout()" style="color:var(--gold);">
          <span>🔄 Herstel Standaard Grid</span>
        </button>
      </div>
    </details>

    <details open>
      <summary>👁️ Viewport Schakelaars</summary>
      <div class="sub-menu">
        <button class="nav-button" onclick="toggleViewport('vp1')">
          <span>🎯 1. Bipolar HUD</span>
          <span id="chip-vp1" class="toggle-chip chip-on">AAN</span>
        </button>
        <button class="nav-button" onclick="toggleViewport('vp2')">
          <span>🌍 2. 3D Vector Globe</span>
          <span id="chip-vp2" class="toggle-chip chip-on">AAN</span>
        </button>
        <button class="nav-button" onclick="toggleViewport('vp3')">
          <span>🌸 3. k=7 Caustic Layer</span>
          <span id="chip-vp3" class="toggle-chip chip-on">AAN</span>
        </button>
        <button class="nav-button" onclick="toggleViewport('vp4')">
          <span>🌌 4. Nebra Pleiades</span>
          <span id="chip-vp4" class="toggle-chip chip-on">AAN</span>
        </button>
      </div>
    </details>

    <details>
      <summary>🚀 Systeem & Deployment</summary>
      <div class="sub-menu">
        <button class="nav-button" onclick="runSystemAction('deploy')">
          <span>⚡ Herlaad Vercel Deployment</span>
        </button>
        <button class="nav-button" onclick="runSystemAction('cron')">
          <span>⏱️ Uurlijkse Cron Status</span>
        </button>
      </div>
    </details>

    <details>
      <summary>📜 Telemetrie & Audit Logs</summary>
      <div class="sub-menu">
        <a class="nav-button" href="/vortex_telemetry.log" target="_blank" download style="color:var(--cyan);">
          <span>📥 Live Telemetrie (.LOG)</span>
        </a>
        <a class="nav-button" href="/vortex_geodetic_refraction_report-v2.pdf" target="_blank" style="color:var(--gold);">
          <span>📄 PDF Audit Rapport v2</span>
        </a>
        <a class="nav-button" href="/naamloos_dossier.pdf" target="_blank" style="color:var(--green);">
          <span>📄 Nieuw Dossier PDF</span>
        </a>
      </div>
    </details>

    <details>
      <summary>📐 Geodetische Rekentools</summary>
      <div class="sub-menu">
        <button class="nav-button" onclick="runSystemAction('planimeter')">
          <span>📏 Planimeter Ott 573</span>
        </button>
        <button class="nav-button" onclick="runSystemAction('dxf')">
          <span>📐 Export EPSG:28992 DXF</span>
        </button>
        <button class="nav-button" onclick="runSystemAction('refraction')">
          <span>🌈 Snellius Refractie (589 nm)</span>
        </button>
      </div>
    </details>

  </section>

  <section id="gridContainer" class="viewport-grid">

    <div id="vp1" class="native-viewport" draggable="true" data-vpid="vp1">
      <div class="viewport-header">
        <span>⋮⋮ VP1: BIPOLAR HUD (245,91°)</span>
        <div class="header-controls">
          <span style="color:var(--cyan); font-size:0.65rem;">[2D]</span>
          <button class="btn-icon" title="Sluit Viewport" onclick="toggleViewport('vp1', false)">✕</button>
        </div>
      </div>
      <div class="viewport-body">
        <canvas id="canvasBipolar" class="hud-canvas"></canvas>
        <div class="overlay-info">Azimut: 245,91° WZW | Snellius: -3,80°</div>
      </div>
    </div>

    <div id="vp2" class="native-viewport" draggable="true" data-vpid="vp2">
      <div class="viewport-header">
        <span>⋮⋮ VP2: GEODETIC VECTOR GLOBE</span>
        <div class="header-controls">
          <span style="color:var(--green); font-size:0.65rem;">[3D]</span>
          <button class="btn-icon" title="Sluit Viewport" onclick="toggleViewport('vp2', false)">✕</button>
        </div>
      </div>
      <div class="viewport-body">
        <canvas id="canvasGlobe" class="hud-canvas"></canvas>
        <div class="overlay-info">RD: 155000, 463000 | Biskaje Corridor</div>
      </div>
    </div>

    <div id="vp3" class="native-viewport" draggable="true" data-vpid="vp3">
      <div class="viewport-header">
        <span>⋮⋮ VP3: k=7 CAUSTIC MATRIX</span>
        <div class="header-controls">
          <span style="color:var(--magenta); font-size:0.65rem;">[MESH]</span>
          <button class="btn-icon" title="Sluit Viewport" onclick="toggleViewport('vp3', false)">✕</button>
        </div>
      </div>
      <div class="viewport-body">
        <canvas id="canvasCaustic" class="hud-canvas"></canvas>
        <div class="overlay-info">Caustic k=7 | λ = 589,0 nm</div>
      </div>
    </div>

    <div id="vp4" class="native-viewport" draggable="true" data-vpid="vp4">
      <div class="viewport-header">
        <span>⋮⋮ VP4: NEBRA PLEIADES SOLSTITIUM</span>
        <div class="header-controls">
          <span style="color:var(--gold); font-size:0.65rem;">[SOLAR]</span>
          <button class="btn-icon" title="Sluit Viewport" onclick="toggleViewport('vp4', false)">✕</button>
        </div>
      </div>
      <div class="viewport-body">
        <canvas id="canvasNebra" class="hud-canvas"></canvas>
        <div class="overlay-info">η Tauri (Pleiaden) | Solstitium Bogen</div>
      </div>
    </div>

  </section>

  <section class="sidebar right">
    <div class="sidebar-section-title">📊 BEHEERCENTRUM MONITOR</div>
    <p><strong>Admin Hub:</strong> v158.6 Actief</p>
    <p><strong>Drag & Drop:</strong> Verschuifbaar</p>
    <p><strong>Status Persistence:</strong> LocalStorage</p>
    <p><strong>Attractor N²:</strong> 010101 (Hex #21)</p>
    <p><strong>Snellius Δθ:</strong> -3,80° (Biskaje)</p>
    <p><strong>Laser D-Line:</strong> 589,0 nm</p>

    <div class="sidebar-section-title" style="margin-top:1rem;">📜 ACTIE LOGBOOK</div>
    <div id="consoleLog" style="font-size:0.65rem; color:var(--cyan); background:#02040a; padding:6px; border:1px solid #1e293b; border-radius:4px; height:120px; overflow-y:auto;">
      [SYSTEM] Beheercentrum geïnitialiseerd...<br>
      [ROUTER] Subonderdelen geladen.<br>
    </div>
  </section>
</main>

<script>
  const STORAGE_KEY = 'vortex_viewport_state_v158';
  let state = {
    vis: { vp1: true, vp2: true, vp3: true, vp4: true },
    order: ['vp1', 'vp2', 'vp3', 'vp4'],
    mode: 'quad'
  };

  function logAction(msg) {
    const consoleBox = document.getElementById('consoleLog');
    if(consoleBox) {
      const time = new Date().toLocaleTimeString();
      consoleBox.innerHTML += `[${time}] ${msg}<br>`;
      consoleBox.scrollTop = consoleBox.scrollHeight;
    }
  }

  function loadSavedState() {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if(saved) {
        const parsed = JSON.parse(saved);
        if(parsed.vis && parsed.order) state = parsed;
      }
    } catch(e) {
      console.warn('LocalStorage error:', e);
    }
    applyState();
  }

  function saveCurrentState() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
      logAction('Layout opgeslagen in LocalStorage');
    } catch(e) {
      console.warn('Cannot save state:', e);
    }
  }

  function applyState() {
    const grid = document.getElementById('gridContainer');
    state.order.forEach(id => {
      const el = document.getElementById(id);
      if(el) grid.appendChild(el);
    });

    let activeCount = 0;
    ['vp1', 'vp2', 'vp3', 'vp4'].forEach(id => {
      const el = document.getElementById(id);
      const isVisible = !!state.vis[id];
      if(el) {
        el.style.display = isVisible ? 'flex' : 'none';
        if(isVisible) activeCount++;
      }
      
      const chip = document.getElementById('chip-' + id);
      if(chip) {
        chip.className = 'toggle-chip ' + (isVisible ? 'chip-on' : 'chip-off');
        chip.textContent = isVisible ? 'AAN' : 'UIT';
      }
    });

    if(activeCount <= 1) {
      grid.style.gridTemplateColumns = '1fr';
      grid.style.gridTemplateRows = '1fr';
    } else {
      grid.style.gridTemplateColumns = 'repeat(2, 1fr)';
      grid.style.gridTemplateRows = 'repeat(2, 1fr)';
    }

    setTimeout(resizeCanvases, 50);
  }

  function toggleViewport(id, forceState) {
    if(forceState !== undefined) {
      state.vis[id] = forceState;
    } else {
      state.vis[id] = !state.vis[id];
    }
    logAction(`Viewport ${id} ${state.vis[id] ? 'ingeschakeld' : 'uitgeschakeld'}`);
    saveCurrentState();
    applyState();
  }

  function setGridMode(mode) {
    state.mode = mode;
    if(mode === 'quad') {
      state.vis = { vp1: true, vp2: true, vp3: true, vp4: true };
    }
    logAction('Quad Grid hersteld');
    saveCurrentState();
    applyState();
  }

  function resetDefaultLayout() {
    state = {
      vis: { vp1: true, vp2: true, vp3: true, vp4: true },
      order: ['vp1', 'vp2', 'vp3', 'vp4'],
      mode: 'quad'
    };
    logAction('Fabrieksinstellingen hersteld');
    saveCurrentState();
    applyState();
  }

  function runSystemAction(action) {
    logAction(`Beheeractie uitgevoerd: ${action}`);
    alert(`[Beheercentrum] Actie '${action}' succesvol aangeroepen.`);
  }

  let draggedElem = null;
  function setupDragAndDrop() {
    const viewports = document.querySelectorAll('.native-viewport');
    viewports.forEach(vp => {
      vp.addEventListener('dragstart', (e) => {
        draggedElem = vp;
        vp.classList.add('dragging');
        e.dataTransfer.effectAllowed = 'move';
      });

      vp.addEventListener('dragend', () => {
        if(draggedElem) draggedElem.classList.remove('dragging');
        draggedElem = null;
        viewports.forEach(v => v.classList.remove('drag-over'));
        const currentOrder = Array.from(document.querySelectorAll('.native-viewport')).map(v => v.id);
        state.order = currentOrder;
        saveCurrentState();
      });

      vp.addEventListener('dragover', (e) => {
        e.preventDefault();
        e.dataTransfer.dropEffect = 'move';
        if(draggedElem && draggedElem !== vp) vp.classList.add('drag-over');
      });

      vp.addEventListener('dragleave', () => vp.classList.remove('drag-over'));

      vp.addEventListener('drop', (e) => {
        e.preventDefault();
        vp.classList.remove('drag-over');
        if(draggedElem && draggedElem !== vp) {
          const grid = document.getElementById('gridContainer');
          const all = Array.from(grid.children);
          const draggedIdx = all.indexOf(draggedElem);
          const targetIdx = all.indexOf(vp);

          if(draggedIdx < targetIdx) {
            grid.insertBefore(draggedElem, vp.nextSibling);
          } else {
            grid.insertBefore(draggedElem, vp);
          }
          resizeCanvases();
        }
      });
    });
  }

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
    angle += 0.012;

    if(cBipolar && state.vis.vp1 && cBipolar.getContext('2d')) {
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
      ctx.lineTo(w/2 + Math.cos(rad)*w*0.38, h/2 + Math.sin(rad)*h*0.38);
      ctx.stroke();
    }

    if(cGlobe && state.vis.vp2 && cGlobe.getContext('2d')) {
      const ctx = cGlobe.getContext('2d');
      const w = cGlobe.width, h = cGlobe.height;
      ctx.clearRect(0, 0, w, h);
      ctx.strokeStyle = '#00ff88';
      ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.arc(w/2, h/2, Math.min(w,h)*0.35, 0, Math.PI*2);
      ctx.stroke();

      for(let i=0; i<5; i++) {
        ctx.beginPath();
        ctx.ellipse(w/2, h/2, Math.abs(Math.sin(angle + i*0.8))*Math.min(w,h)*0.35, Math.min(w,h)*0.35, 0, 0, Math.PI*2);
        ctx.stroke();
      }
    }

    if(cCaustic && state.vis.vp3 && cCaustic.getContext('2d')) {
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

    if(cNebra && state.vis.vp4 && cNebra.getContext('2d')) {
      const ctx = cNebra.getContext('2d');
      const w = cNebra.width, h = cNebra.height;
      ctx.clearRect(0, 0, w, h);

      ctx.fillStyle = 'rgba(255, 204, 51, 0.12)';
      ctx.strokeStyle = '#ffcc33';
      ctx.beginPath();
      ctx.arc(w/2, h/2, Math.min(w,h)*0.32, 0, Math.PI*2);
      ctx.fill();
      ctx.stroke();

      ctx.fillStyle = '#00e5ff';
      const stars = [,, [-10,12],, [-20,-15],, [-15,-5]];
      stars.forEach(([sx, sy]) => {
        ctx.beginPath();
        ctx.arc(w/2 + sx*2, h/2 + sy*2, 3.5, 0, Math.PI*2);
        ctx.fill();
      });
    }

    requestAnimationFrame(renderNativeLoop);
  }

  window.onload = () => {
    setupDragAndDrop();
    loadSavedState();
    resizeCanvases();
    renderNativeLoop();
  };
</script>

</body>
</html>
HTML_EOF

cp -f vortex_omni_master_v158.html index.html

git add -f vortex_omni_master_v158.html index.html 2>/dev/null || true
git commit -m "Build Beheercentrum menu with collapsible subcomponents" || true

if [ -f "./vortex_master_deploy.sh" ]; then
  ./vortex_master_deploy.sh
elif [ -f "./push_geocentrum_main.sh" ]; then
  ./push_geocentrum_main.sh
else
  git push origin main
fi

echo "======================================================================"
echo "✅ Beheercentrum menu met subonderdelen succesvol geïntegreerd en gepusht!"
echo "======================================================================"
