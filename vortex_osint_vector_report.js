const VortexOsintVectorReport = (() => {
  function renderReportWidget(containerId = 'vortex-osint-report-container') {
    let container = document.getElementById(containerId);
    if (!container) {
      container = document.createElement('div');
      container.id = containerId;
      container.style.cssText = `
        margin: 20px auto; max-width: 900px; background: rgba(10, 16, 28, 0.95);
        border: 1px solid rgba(0, 229, 255, 0.4); border-radius: 8px; padding: 18px;
        font-family: 'JetBrains Mono', monospace; color: #e0e6ed; box-shadow: 0 0 20px rgba(0, 229, 255, 0.15);
      `;
      const target = document.querySelector('main') || document.body;
      target.appendChild(container);
    }

    container.innerHTML = `
      <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid rgba(0,229,255,0.3); padding-bottom:10px; margin-bottom:15px;">
        <h3 style="margin:0; color:#00e5ff; font-size:14px; letter-spacing:1px;">
          📡 OSINT & GEODETISCHE VECTOR RAPPORTAGE (EPSG:28992 / WGS84)
        </h3>
        <span style="background:rgba(0,255,136,0.2); color:#00ff88; border:1px solid #00ff88; padding:2px 8px; border-radius:12px; font-size:10px;">
          REFRACTIE: -3.80° SNELL
        </span>
      </div>

      <table style="width:100%; border-collapse:collapse; font-size:11px; text-align:left;">
        <thead>
          <tr style="border-bottom:1px solid rgba(255,255,255,0.2); color:#88a0c0;">
            <th style="padding:6px;">Knoop / Anker ID</th>
            <th style="padding:6px;">RD-Coördinaten (EPSG:28992)</th>
            <th style="padding:6px;">WGS84 Coördinaten</th>
            <th style="padding:6px;">Azimut & Refractie</th>
            <th style="padding:6px;">Status</th>
          </tr>
        </thead>
        <tbody>
          <tr style="border-bottom:1px solid rgba(255,255,255,0.08);">
            <td style="padding:8px; color:#ffcc00; font-weight:bold;">RD_OORSPRONG</td>
            <td style="padding:8px;">X: 155.000,00 m<br>Y: 463.000,00 m</td>
            <td style="padding:8px;">52,155174° N<br>5,387206° E</td>
            <td style="padding:8px;">0,00° (Referentie Center)</td>
            <td style="padding:8px; color:#00ff88;">LOCKED (Amersfoort)</td>
          </tr>
          <tr style="border-bottom:1px solid rgba(255,255,255,0.08);">
            <td style="padding:8px; color:#00e5ff; font-weight:bold;">BISKAJE_END_NODE</td>
            <td style="padding:8px;">X: 110.807,31 m<br>Y: 439.610,48 m</td>
            <td style="padding:8px;">51,944258° N<br>4,740883° E</td>
            <td style="padding:8px; color:#00e5ff;">242,11° WZW<br><span style="font-size:9px; color:#88a0c0;">(245,91° - 3,80°)</span></td>
            <td style="padding:8px; color:#00ff88;">CALIBRATED (50km)</td>
          </tr>
        </tbody>
      </table>

      <div style="margin-top:16px; padding:12px; background:rgba(0,0,0,0.5); border:1px solid rgba(0,229,255,0.2); border-radius:6px; display:flex; justify-content:space-between; align-items:center;">
        <div>
          <span style="font-size:11px; color:#ffcc00; font-weight:bold; display:block; margin-bottom:2px;">📥 DIRECTE EXPORT-DOWNLOADS</span>
          <span style="font-size:10px; color:#a0b0c0;">Gekalibreerde vectorbestanden voor QGIS, MapLibre & CAD-software</span>
        </div>
        <div style="display:flex; gap:10px;">
          <a href="./vortex_refracted_vector.geojson" download="vortex_refracted_vector.geojson" style="background:rgba(0,229,255,0.15); color:#00e5ff; border:1px solid #00e5ff; padding:6px 12px; border-radius:4px; font-size:11px; text-decoration:none; font-weight:bold;">
            🗺️ GEOJSON EXPORT
          </a>
          <a href="./vortex_nodes_epsg28992.dxf" download="vortex_nodes_epsg28992.dxf" style="background:rgba(255,204,0,0.15); color:#ffcc00; border:1px solid #ffcc00; padding:6px 12px; border-radius:4px; font-size:11px; text-decoration:none; font-weight:bold;">
            📐 CAD DXF EXPORT
          </a>
        </div>
      </div>
    `;
  }

  function init() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', () => renderReportWidget());
    } else {
      renderReportWidget();
    }
  }

  return { init, renderReportWidget };
})();

if (typeof window !== 'undefined') {
  window.VortexOsintVectorReport = VortexOsintVectorReport;
  VortexOsintVectorReport.init();
}
