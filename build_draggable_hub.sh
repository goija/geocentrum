#!/usr/bin/env bash
echo "Genereren van verplaatsbare viewport hub..."

cat << 'HTMLEOF' > verplaatsbare_viewport_hub.html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Geocentrum PDF-Hulpmiddelen & Verplaatsbare Viewport Hub</title>
  <style>
    :root {
      --bg: #f8f7fc;
      --card: #ffffff;
      --dark-panel: #0b111e;
      --dark-card: #131f35;
      --accent: #7542e5;
      --accent-soft: #ede6ff;
      --cyan: #00e5ff;
      --gold: #ffcc33;
      --magenta: #ff3385;
      --text: #1c1b22;
      --muted: #5b5b66;
      --border: #e2e0ec;
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      background: var(--bg);
      color: var(--text);
      line-height: 1.5;
      padding: 20px;
      min-height: 100vh;
      position: relative;
    }
    .container { max-width: 1420px; margin: 0 auto; padding-bottom: 200px; }

    /* Topbar */
    .topbar {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      margin-bottom: 18px;
    }
    .btn-back {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 7px 18px;
      border: 2px solid var(--accent);
      border-radius: 999px;
      background: #fff;
      color: var(--accent);
      font-weight: 600;
      font-size: 0.9rem;
      text-decoration: none;
    }
    .btn-back:hover { background: var(--accent-soft); }
    .ext-links { display: flex; flex-wrap: wrap; gap: 8px; }
    .ext-link {
      font-size: 0.8rem;
      padding: 6px 12px;
      border-radius: 8px;
      background: var(--dark-panel);
      color: #fff;
      text-decoration: none;
      border: 1px solid #2b4c7e;
    }
    .ext-link:hover { border-color: var(--cyan); color: var(--cyan); }

    .hero { margin-bottom: 16px; }
    .hero h1 { font-size: 1.6rem; margin-bottom: 4px; }
    .hero p { color: var(--muted); font-size: 0.94rem; }

    /* Firefox 8 PDF Hulpmiddelen Grid */
    .features-shell {
      background: var(--card);
      border-radius: 18px;
      padding: 24px;
      box-shadow: 0 4px 20px rgba(28, 27, 34, 0.06);
      border: 1px solid var(--border);
      margin-bottom: 22px;
    }
    .filter-bar { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 16px; }
    .filter-btn {
      padding: 6px 14px;
      border-radius: 999px;
      border: 1px solid var(--border);
      background: #fff;
      cursor: pointer;
      font-size: 0.84rem;
      font-weight: 600;
      color: var(--muted);
    }
    .filter-btn.active { background: var(--accent); color: #fff; border-color: var(--accent); }
    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 16px 24px;
    }
    .feature-item {
      display: flex;
      align-items: flex-start;
      gap: 14px;
      padding: 12px;
      border-radius: 12px;
      cursor: pointer;
      border: 1px solid transparent;
      transition: background 0.15s, transform 0.15s;
    }
    .feature-item:hover { background: #f4f0ff; border-color: #d3c4fc; transform: translateY(-1px); }
    .icon-circle {
      width: 50px;
      height: 50px;
      min-width: 50px;
      border-radius: 50%;
      background: var(--accent-soft);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.25rem;
    }
    .feature-item h3 { font-size: 0.98rem; margin-bottom: 2px; }
    .feature-item p { font-size: 0.85rem; color: var(--muted); }

    /* Lokale Dossiers Paneel */
    .panel {
      background: var(--card);
      border-radius: 16px;
      padding: 18px;
      border: 1px solid var(--border);
      margin-bottom: 24px;
    }
    .panel h2 { font-size: 1.02rem; margin-bottom: 12px; }
    .file-drop {
      border: 2px dashed #b9a6f8;
      background: #f6f3ff;
      padding: 12px;
      border-radius: 10px;
      text-align: center;
      font-size: 0.82rem;
      margin-bottom: 14px;
    }
    .dossier-list { list-style: none; display: flex; flex-direction: column; gap: 8px; }
    .dossier-item {
      padding: 10px 12px;
      border-radius: 10px;
      background: #f9f8fd;
      border: 1px solid var(--border);
      font-size: 0.82rem;
      display: flex;
      flex-direction: column;
      gap: 4px;
    }
    .dossier-actions { display: flex; flex-wrap: wrap; gap: 6px; margin-top: 4px; }
    .btn-sm {
      padding: 4px 10px;
      font-size: 0.76rem;
      border-radius: 6px;
      border: 1px solid var(--accent);
      background: var(--accent);
      color: #fff;
      cursor: pointer;
      text-decoration: none;
      font-weight: 600;
    }
    .btn-sm.outline { background: transparent; color: var(--accent); }

    /* ========================================================================= */
    /* VERPLAATBARE & HERSCHAALBARE VIEWPORT (DRAGGABLE & RESIZABLE FLOATING WINDOW) */
    /* ========================================================================= */
    #floatingViewport {
      position: fixed;
      top: 120px;
      right: 40px;
      width: 720px;
      height: 580px;
      min-width: 380px;
      min-height: 300px;
      background: var(--card);
      border-radius: 14px;
      box-shadow: 0 12px 40px rgba(0,0,0,0.28);
      border: 2px solid var(--accent);
      display: flex;
      flex-direction: column;
      z-index: 1000;
      resize: both;
      overflow: hidden;
    }
    .pdf-toolbar {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      padding: 10px 14px;
      background: #1b1b24;
      color: #fff;
      cursor: grab;
      align-items: center;
      user-select: none;
    }
    .pdf-toolbar:active { cursor: grabbing; }
    .tool-btn {
      padding: 5px 10px;
      border-radius: 6px;
      border: 1px solid #3f3d4d;
      background: #2b2a37;
      color: #fff;
      font-size: 0.78rem;
      cursor: pointer;
    }
    .tool-btn:hover { background: var(--accent); }
    .status-banner {
      padding: 6px 14px;
      font-size: 0.78rem;
      background: #132238;
      color: #bae6fd;
      border-bottom: 1px solid #1e3a5f;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .viewer-stage {
      position: relative;
      flex: 1;
      background: #323237;
      display: flex;
      overflow: hidden;
    }
    .sidebar-drawer {
      width: 220px;
      background: #232329;
      color: #e2e8f0;
      padding: 12px;
      font-size: 0.78rem;
      border-right: 1px solid #3f3f46;
      overflow-y: auto;
    }
    .sidebar-drawer.hidden { display: none; }
    .sidebar-drawer h4 {
      color: var(--gold);
      margin: 8px 0 4px;
      font-size: 0.8rem;
      border-bottom: 1px solid #3f3f46;
      padding-bottom: 3px;
    }
    .contour-link {
      display: block;
      padding: 4px 6px;
      color: #cbd5e1;
      text-decoration: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .contour-link:hover { background: #3b3b46; color: #fff; }
    .pdf-canvas-wrap {
      flex: 1;
      position: relative;
      display: flex;
      flex-direction: column;
      padding: 10px;
      overflow: auto;
    }
    .pdf-frame {
      width: 100%;
      height: 100%;
      border: none;
      background: #fff;
      border-radius: 6px;
    }
    .overlay-layer { position: absolute; inset: 10px; pointer-events: none; }
    .sticky-note {
      position: absolute;
      width: 180px;
      background: #fef08a;
      color: #1c1917;
      padding: 8px;
      border-radius: 6px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.35);
      font-size: 0.76rem;
      pointer-events: auto;
      border-top: 6px solid #eab308;
    }
    .sig-badge {
      position: absolute;
      padding: 6px 12px;
      border: 2px solid #1d4ed8;
      background: rgba(219, 234, 254, 0.92);
      color: #1e3a8a;
      font-family: cursive, serif;
      font-size: 1rem;
      border-radius: 6px;
      pointer-events: auto;
    }
    .alt-badge {
      position: absolute;
      padding: 6px 10px;
      background: rgba(11, 17, 30, 0.92);
      color: #fff;
      border: 1px solid var(--cyan);
      border-radius: 8px;
      font-size: 0.75rem;
      pointer-events: auto;
    }

    /* VORTEX Cockpit Modules Grid */
    .geo-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(390px, 1fr));
      gap: 20px;
      margin-top: 24px;
    }
    .dark-panel {
      background: var(--dark-panel);
      color: #e0f2fe;
      border-radius: 16px;
      padding: 18px;
      border: 1px solid #1e3a5f;
    }
    .dark-panel h3 { color: var(--gold); font-size: 0.98rem; margin-bottom: 4px; text-transform: uppercase; }
    .dark-panel .sub { font-size: 0.76rem; color: #94a3b8; margin-bottom: 12px; }
    .stat-pill {
      display: flex;
      justify-content: space-between;
      background: var(--dark-card);
      padding: 6px 10px;
      border-radius: 6px;
      margin-bottom: 6px;
      font-size: 0.8rem;
      border-left: 3px solid var(--cyan);
    }
    .stat-pill strong { color: var(--cyan); }
  </style>
</head>
<body>
<div class="container">
  <!-- Topbar -->
  <div class="topbar">
    <a href="https://geocentrum.vercel.app/" class="btn-back">&lt; Terug naar Geocentrum (Root)</a>
    <div class="ext-links">
      <a class="ext-link" href="https://geocentrum.vercel.app/" target="_blank">geocentrum.vercel.app</a>
      <a class="ext-link" href="https://mathgeo-seven.vercel.app/" target="_blank">Mathgeo-Seven Dashboard</a>
    </div>
  </div>

  <div class="hero">
    <h1>🦊 Firefox-PDF-hulpmiddelen — Verplaatsbare Viewport & VORTEX Hub</h1>
    <p>Sleep de PDF-viewer aan de bovenste werkbalk, schaal de hoeken bij of laad lokale dossiers in.</p>
  </div>

  <!-- 8 Firefox PDF Hulpmiddelen -->
  <section class="features-shell">
    <div class="filter-bar">
      <button class="filter-btn active" onclick="filterFeatures('all', this)">Alle 8 hulpmiddelen</button>
      <button class="filter-btn" onclick="filterFeatures('edit', this)">Bewerken, opmaken en ordenen (5)</button>
      <button class="filter-btn" onclick="filterFeatures('view', this)">Weergave, presentatie en navigatie (3)</button>
    </div>
    <div class="features-grid">
      <div class="feature-item" data-cat="edit" onclick="activateTool('order')">
        <div class="icon-circle">📄</div>
        <div><h3>Pagina's ordenen</h3><p>Pagina's herschikken, verwijderen, samenvoegen en exporteren.</p></div>
      </div>
      <div class="feature-item" data-cat="edit" onclick="activateTool('signature')">
        <div class="icon-circle">✍️</div>
        <div><h3>Handtekeningen opslaan</h3><p>Maak meerdere handtekeningen aan en voeg deze aan formulieren toe.</p></div>
      </div>
      <div class="feature-item" data-cat="edit" onclick="activateTool('note')">
        <div class="icon-circle">💬</div>
        <div><h3>Notities toevoegen</h3><p>Laat opmerkingen en herinneringen achter tijdens het lezen.</p></div>
      </div>
      <div class="feature-item" data-cat="edit" onclick="activateTool('markup')">
        <div class="icon-circle">🖍️</div>
        <div><h3>PDF's opmaken</h3><p>Voeg tekst, markeringen en tekeningen toe.</p></div>
      </div>
      <div class="feature-item" data-cat="edit" onclick="activateTool('alt')">
        <div class="icon-circle">🖼️</div>
        <div><h3>Toegankelijke afbeeldingen uploaden</h3><p>Voeg alternatieve tekst toe, zodat afbeeldingen voor meer mensen werken.</p></div>
      </div>
      <div class="feature-item" data-cat="view" onclick="activateTool('layout')">
        <div class="icon-circle">📖</div>
        <div><h3>Kies uw weergave</h3><p>Scrol verticaal of horizontaal, of wissel pagina-indelingen.</p></div>
      </div>
      <div class="feature-item" data-cat="view" onclick="activateTool('fullscreen')">
        <div class="icon-circle">🖥️</div>
        <div><h3>PDF's in volledig scherm presenteren</h3><p>Deel een schoon beeld in presentatiemodus.</p></div>
      </div>
      <div class="feature-item" data-cat="view" onclick="activateTool('details')">
        <div class="icon-circle">🔍</div>
        <div><h3>Vind details sneller</h3><p>Gebruik contouren, bijlagen en eigenschappen om door PDF's te bladeren.</p></div>
      </div>
    </div>
  </section>

  <!-- Lokale Dossiers Paneel -->
  <section class="panel" style="max-width: 500px;">
    <h2>📂 Geocentrum Dossiers Laden</h2>
    <div class="file-drop">
      <label for="pdfFileInput" style="cursor:pointer; font-weight:600; color:var(--accent);">
        + Selecteer of sleep lokale PDF-bestanden
      </label>
      <input type="file" id="pdfFileInput" accept=".pdf" multiple style="margin-top:8px; width:100%; font-size:0.76rem;">
    </div>

    <ul class="dossier-list">
      <li class="dossier-item">
        <strong>1. Planitaire Data (Ott Nr. 573)</strong>
        <span>1c66d21e-6829-4aca-9cc7-b29b0b1d5b07_Planitaire_data.pdf</span>
        <div class="dossier-actions">
          <button class="btn-sm" onclick="loadPdf('1c66d21e-6829-4aca-9cc7-b29b0b1d5b07_Planitaire_data.pdf', 'Planitaire Data')">Laad in Viewport</button>
        </div>
      </li>
      <li class="dossier-item">
        <strong>2. Metingen Petrus Schenk</strong>
        <span>7a74d769-2330-4e19-a1ca-d141a17feb71_metingen_petrus_schenk.pdf</span>
        <div class="dossier-actions">
          <button class="btn-sm" onclick="loadPdf('7a74d769-2330-4e19-a1ca-d141a17feb71_metingen_petrus_schenk.pdf', 'Metingen Petrus Schenk')">Laad in Viewport</button>
        </div>
      </li>
      <li class="dossier-item">
        <strong>3. Historisch onderzoeksdossier</strong>
        <span>West-Brabant, Zeeland en de Vlaamse kust</span>
        <div class="dossier-actions">
          <button class="btn-sm" onclick="loadPdf('7808126e-544c-4512-b8fc-2fbd6e860183_Historisch-archeologisch_onderzoeksdossier__West-Brabant_Zeeland_en_de_Vlaamse_kust.pdf', 'Onderzoeksdossier West-Brabant & Zeeland')">Laad in Viewport</button>
        </div>
      </li>
      <li class="dossier-item">
        <strong>4. Anonymous Dossier</strong>
        <span>anonymous_dossier.pdf</span>
        <div class="dossier-actions">
          <button class="btn-sm" onclick="loadPdf('anonymous_dossier.pdf', 'Anonymous Dossier')">Laad in Viewport</button>
        </div>
      </li>
    </ul>
  </section>

  <!-- ========================================================================= -->
  <!-- VERPLAATBARE & HERSCHAALBARE VIEWPORT CONTAINER -->
  <!-- ========================================================================= -->
  <div id="floatingViewport">
    <div class="pdf-toolbar" id="viewportHeader">
      <strong id="activeDocTitle" style="margin-right:auto; font-size:0.86rem; color:var(--cyan);">
        Viewport: Planitaire Data
      </strong>
      <button class="tool-btn" onclick="activateTool('details')">🔍 Contouren</button>
      <button class="tool-btn" onclick="activateTool('note')">💬 + Notitie</button>
      <button class="tool-btn" onclick="activateTool('signature')">✍️ + Teken</button>
      <button class="tool-btn" onclick="activateTool('alt')">🖼️ + Alt</button>
      <button class="tool-btn" onclick="clearOverlays()">🗑️ Wis</button>
    </div>
    <div class="status-banner">
      <span id="statusText">Versleep deze viewport aan de bovenste balk of schaal de hoek rechtsonder.</span>
      <span style="font-family:monospace; font-size:0.75rem;">VORTEX v154.5</span>
    </div>
    <div class="viewer-stage">
      <div class="sidebar-drawer hidden" id="sidebarDrawer">
        <h4>Contouren & Modules</h4>
        <a class="contour-link">1. Ott Nr. 573 & Shao Yong</a>
        <a class="contour-link">2. VORTEX Multi-As & M1-M4</a>
        <a class="contour-link">3. Laser & Spectrale Tools</a>
      </div>
      <div class="pdf-canvas-wrap">
        <iframe id="pdfFrame" class="pdf-frame" src="1c66d21e-6829-4aca-9cc7-b29b0b1d5b07_Planitaire_data.pdf"></iframe>
        <div class="overlay-layer" id="overlayLayer"></div>
      </div>
    </div>
  </div>

  <!-- VORTEX Cockpit Info Modules -->
  <div class="geo-grid">
    <div class="dark-panel">
      <h3>1. A. Ott Nr. 573 Planimeter & Shao Yong (64)</h3>
      <div class="sub">Meetcirkel A = 363,00 cm² | 1452 vakjes</div>
      <div class="stat-pill"><span>Totale Cirkel:</span><strong>363,00 cm² | 3630 nonius</strong></div>
      <div class="stat-pill"><span>Shao Yong Sector (1/64):</span><strong>5,672 cm²</strong></div>
    </div>
    <div class="dark-panel">
      <h3>2. VORTEX Cockpit Telemetrie</h3>
      <div class="sub">Multi-As Wielen | det J = -1.00</div>
      <div class="stat-pill"><span>Arm-Hoeken:</span><strong>α = 171.9° | β = 185.6° | γ = 166.4°</strong></div>
    </div>
  </div>
</div>

<script>
  function filterFeatures(cat, btn) {
    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.querySelectorAll('.feature-item').forEach(el => {
      el.style.display = (cat === 'all' || el.dataset.cat === cat) ? 'flex' : 'none';
    });
  }

  function loadPdf(path, title) {
    document.getElementById('pdfFrame').src = path;
    document.getElementById('activeDocTitle').textContent = 'Viewport: ' + title;
  }

  // Lokale bestandskiezer
  document.getElementById('pdfFileInput').addEventListener('change', function(e) {
    Array.from(e.target.files).forEach(file => {
      const blobUrl = URL.createObjectURL(file);
      loadPdf(blobUrl, file.name);
    });
  });

  function activateTool(tool) {
    const layer = document.getElementById('overlayLayer');
    const drawer = document.getElementById('sidebarDrawer');

    if (tool === 'details') {
      drawer.classList.toggle('hidden');
    } else if (tool === 'note') {
      const note = document.createElement('div');
      note.className = 'sticky-note';
      note.style.top = (35 + Math.random() * 100) + 'px';
      note.style.left = (35 + Math.random() * 150) + 'px';
      note.contentEditable = true;
      note.innerHTML = '<strong>VORTEX Notitie:</strong><br>Ott Nr. 573 viewport geactiveerd.';
      layer.appendChild(note);
    } else if (tool === 'signature') {
      const sig = document.createElement('div');
      sig.className = 'sig-badge';
      sig.style.bottom = '30px';
      sig.style.right = '30px';
      sig.textContent = 'Geocentrum // VORTEX';
      layer.appendChild(sig);
    } else if (tool === 'alt') {
      const alt = document.createElement('div');
      alt.className = 'alt-badge';
      alt.style.top = '20px';
      alt.style.right = '20px';
      alt.innerHTML = '🖼️ <strong>Viewport actief</strong>';
      layer.appendChild(alt);
    }
  }

  function clearOverlays() { document.getElementById('overlayLayer').innerHTML = ''; }

  // =========================================================================
  // DRAG & DROP LOGICA VOOR DE VIEWPORT (VERPLAATBAAR MAKEN)
  // =========================================================================
  const viewport = document.getElementById('floatingViewport');
  const header = document.getElementById('viewportHeader');

  let isDragging = false;
  let startX, startY, initialLeft, initialTop;

  header.addEventListener('mousedown', (e) => {
    isDragging = true;
    startX = e.clientX;
    startY = e.clientY;
    const rect = viewport.getBoundingClientRect();
    initialLeft = rect.left;
    initialTop = rect.top;
    viewport.style.position = 'fixed';
    viewport.style.left = initialLeft + 'px';
    viewport.style.top = initialTop + 'px';
    viewport.style.right = 'auto';
    e.preventDefault();
  });

  document.addEventListener('mousemove', (e) => {
    if (!isDragging) return;
    const dx = e.clientX - startX;
    const dy = e.clientY - startY;
    viewport.style.left = (initialLeft + dx) + 'px';
    viewport.style.top = (initialTop + dy) + 'px';
  });

  document.addEventListener('mouseup', () => {
    isDragging = false;
  });
</script>
</body>
</html>
HTMLEOF

echo "Bestand succesvol aangemaakt: verplaatsbare_viewport_hub.html"
xdg-open verplaatsbare_viewport_hub.html 2>/dev/null &
