#!/bin/bash
set -e

echo "🌀 VORTEX OS v158.1 — Complete Asset & Beheer Structuur Opbouwen..."

BASE_DIR="/home/ontwerp/Bureaublad/geocentrum"

mkdir -p "\$BASE_DIR/assets"
mkdir -p "\$BASE_DIR/cockpittools"
mkdir -p "\$BASE_DIR/images"
mkdir -p "\$BASE_DIR/systeemdiagnose/update"
mkdir -p "\$BASE_DIR/txt"

echo "📁 Mappenstructuur gecontroleerd op: \$BASE_DIR"

# 1. GENERATE ASSETS MANIFEST
cat << 'JS_EOF' > "\$BASE_DIR/assets/assets_manifest.js"
export const VORTEX_ASSETS_MANIFEST = {
  version: "158.1",
  timestamp: new Date().toISOString(),
  anchors: {
    poolanker_p: { name: 'Poolanker P (Laren / NL)', lat: 52.2500, lng: 5.2200, rdX: 141120, rdY: 473200 },
    scherpenisse: { name: 'Scherpenisse (Zeeland)', lat: 51.546389, lng: 4.103889, rdX: 65985.24, rdY: 396053.23 },
    tholen_stad: { name: 'Tholen Stad', lat: 51.533056, lng: 4.216111, rdX: 73745.01, rdY: 394438.89 }
  },
  vectors: {
    scherpenisse_tholen: {
      rdGridAzimuthDeg: 101.75,
      wgs84AzimuthDeg: 100.74,
      meridianConvergenceDeg: -1.01,
      distanceMeters: 7925.92,
      hexagonalAxesDeg: [101.75, 161.75, 221.75, 281.75, 341.75, 41.75]
    }
  },
  duogramCalibration: {
    index: { x: 0, y: 8 },
    azimuthDeg: 45.0,
    rhoCm: -8.20,
    nonius: -264,
    kingWenHex: 'KW #9 (110111)',
    attractor: "010101 (01)"
  }
};
JS_EOF
echo "✅ assets/assets_manifest.js aangemaakt."

# 2. GENERATE VORTEX PRECISION TOOL V158
cat << 'JS_EOF' > "\$BASE_DIR/assets/vortex_precision_tool_v158.js"
/**
 * VORTEX OS v158.0 - Geodetische & Optische Precision Tooling
 * Inclusief Hinge Duogram Calibration Point (0, 8) & King Wen #9 -> N² Attractor 010101
 * Scherpenisse -> Tholen Vector (101.75° RD Grid Azimut) & Cellarius Grid Rotatie
 */

export const VORTEX_BIPOLAR_HUD = {
  version: '158.0',
  
  anchors: {
    poolanker_p: { name: 'Poolanker P (Laren / NL)', lat: 52.2500, lng: 5.2200, rdX: 141120, rdY: 473200 },
    scherpenisse: { name: 'Scherpenisse (Zeeland)', lat: 51.546389, lng: 4.103889, rdX: 65985.24, rdY: 396053.23 },
    tholen_stad: { name: 'Tholen Stad', lat: 51.533056, lng: 4.216111, rdX: 73745.01, rdY: 394438.89 },
    taurus_aldebaran: { name: 'Aldebaran / Taurus Anker', azimuth: 51.40, elevation: -3.7, constellation: 'Taurus' },
    mercurius_eclips: { name: 'Mercurius / Eclips Corridor', azimuth: 245.91, elevation: -4.2, constellation: 'Libra' },
    n2_core: { name: 'N² Kern (Dept. 41/18 Bourges)', lat: 47.2500, lng: 1.8500 },
    exit_biskaje: { name: 'Uittreedknoop Dept. 17/85 (Biskaje)', lat: 46.2500, lng: -1.2500 },
    eclips_landfall: { name: 'Eclips Landfall 12-Aug-2026 (Asturië)', lat: 43.5500, lng: -6.5000 }
  },

  duogramCalibration: {
    thetaDeg: 45.00,
    rhoCm: -8.20,
    noniusValue: -264,
    matrixIndex: { x: 0, y: 8 },
    kingWenNumber: 9,
    kingWenBinary: '110111',
    n2Attractor: '010101 (01)',
    jacobianDet: -1.00,
    originInversionActive: true
  },

  tholenVector: {
    wgs84ForwardAzimuthDeg: 100.74,
    rdGridAzimuthDeg: 101.75,
    meridianConvergenceDeg: -1.01,
    ellipsoidalDistanceM: 7926.05,
    rdGridDistanceM: 7925.92,
    cellariusGridRotationOffsetDeg: 101.75,
    hexagonalAxesDeg: [101.75, 161.75, 221.75, 281.75, 341.75, 41.75]
  },

  constants: {
    laserWavelengthNm: 589.0,
    opticalPathLength_cm: 16.675,
    nAir: 1.0003,
    nSea: 1.3330,
    ottArmR_cm: 15.00,
    ottArmL_cm: 16.67,
    meetcirkelArea_cm2: 363.00,
    jacobianDet: -1.00
  },

  calculateDuogramPosition(thetaDeg, noniusVal) {
    const noniusNorm = Math.abs(noniusVal) / 26214.0;
    const xIdx = Math.floor(noniusNorm * 64);
    const yIdx = Math.floor(((thetaDeg % 360) / 360.0) * 64);

    return {
      theta: thetaDeg,
      nonius: noniusVal,
      xIndex: xIdx,
      yIndex: yIdx,
      matrixCoords: `(${xIdx}, ${yIdx})`,
      kingWenHex: xIdx === 0 && yIdx === 8 ? 'KW #9 (110111)' : 'DYNAMIC',
      attractor: '010101 (01)'
    };
  },

  calculateTholenVectorTransformation() {
    const rdAz = this.tholenVector.rdGridAzimuthDeg;
    const gamma = this.tholenVector.meridianConvergenceDeg;
    const wgsAz = rdAz + gamma;
    
    return {
      vectorName: 'Scherpenisse -> Tholen Stad',
      rdGridAzimuth: rdAz,
      meridianConvergence: gamma,
      correctedWgs84Azimuth: parseFloat(wgsAz.toFixed(2)),
      cellariusRotationOffset: rdAz,
      hexagonalAxes: this.tholenVector.hexagonalAxesDeg,
      alignmentStatus: 'LOCKED_TO_POLDER_GRID'
    };
  }
};
JS_EOF
echo "✅ assets/vortex_precision_tool_v158.js aangemaakt."

# 3. GENERATE DUOGRAM MATRIX WIDGET
cat << 'JS_EOF' > "\$BASE_DIR/assets/vortex_duogram_matrix_widget.js"
/**
 * VORTEX OS v158.0 — 64x64 Hinge Duogram Matrix Canvas Widget
 * Inclusief IJkpunt (0, 8) voor θ = 45.00°, ρ = -8.20 cm, Nonius -264
 * King Wen #9 (110111) -> N² Attractor 010101 (01)
 */

export class VortexDuogramMatrixWidget {
  constructor(canvasId, options = {}) {
    this.canvas = document.getElementById(canvasId);
    if (!this.canvas) return;
    this.ctx = this.canvas.getContext('2d');
    
    this.activeNode = options.activeNode || { x: 0, y: 8, theta: 45.0, rho: -8.20, nonius: -264, kw: 9 };
    this.gridSize = 64;
    
    this.init();
  }

  init() {
    this.resize();
    window.addEventListener('resize', () => this.resize());
  }

  resize() {
    if (!this.canvas) return;
    this.width = this.canvas.parentElement.clientWidth || 600;
    this.height = this.canvas.parentElement.clientHeight || 600;
    this.canvas.width = this.width;
    this.canvas.height = this.height;
    this.render();
  }

  render() {
    const ctx = this.ctx;
    const w = this.width, h = this.height;
    ctx.clearRect(0, 0, w, h);

    const pad = 40;
    const size = Math.min(w - 2 * pad, h - 2 * pad);
    const cell = size / 64;
    const originX = pad;
    const originY = h - pad;

    ctx.fillStyle = '#04060d';
    ctx.fillRect(0, 0, w, h);

    for (let y = 0; y < 64; y++) {
      for (let x = 0; x < 64; x++) {
        const px = originX + x * cell;
        const py = originY - (y + 1) * cell;
        const intensity = ((x + y) % 64) / 64;
        ctx.fillStyle = `rgba(0, 229, 255, ${0.03 + intensity * 0.08})`;
        ctx.fillRect(px, py, cell, cell);
      }
    }

    ctx.strokeStyle = '#1e293b';
    ctx.lineWidth = 1;
    for (let k = 0; k <= 64; k += 8) {
      const pos = k * cell;
      ctx.beginPath(); ctx.moveTo(originX, originY - pos); ctx.lineTo(originX + size, originY - pos); ctx.stroke();
      ctx.beginPath(); ctx.moveTo(originX + pos, originY); ctx.lineTo(originX + pos, originY - size); ctx.stroke();
    }

    const lineY = originY - 8.5 * cell;
    ctx.strokeStyle = '#ffcc33';
    ctx.setLineDash([4, 4]);
    ctx.lineWidth = 1.5;
    ctx.beginPath(); ctx.moveTo(originX, lineY); ctx.lineTo(originX + size, lineY); ctx.stroke();
    ctx.setLineDash([]);

    const activePx = originX + 0 * cell;
    const activePy = originY - 9 * cell;

    ctx.fillStyle = '#00e5ff';
    ctx.fillRect(activePx, activePy, cell, cell);

    ctx.strokeStyle = '#ffcc33';
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.arc(activePx + cell/2, activePy + cell/2, cell * 1.8, 0, Math.PI * 2);
    ctx.stroke();

    ctx.fillStyle = '#94a3b8';
    ctx.font = '10px monospace';
    ctx.fillText('θ = 0°', originX, originY + 15);
    ctx.fillText('θ = 360°', originX, originY - size - 8);
    ctx.fillText('X = 0', originX - 30, originY);
    ctx.fillText('X = 63', originX + size - 15, originY + 15);

    ctx.fillStyle = 'rgba(13, 21, 39, 0.92)';
    ctx.strokeStyle = '#00e5ff';
    ctx.lineWidth = 1;
    ctx.fillRect(originX + size * 0.35, originY - size * 0.95, 230, 110);
    ctx.strokeRect(originX + size * 0.35, originY - size * 0.95, 230, 110);

    ctx.fillStyle = '#ffffff';
    ctx.font = 'bold 11px monospace';
    ctx.fillText('🎯 IJKPUNT (0, 8) MATRIX', originX + size * 0.35 + 10, originY - size * 0.95 + 20);

    ctx.fillStyle = '#00e5ff';
    ctx.font = '10px monospace';
    ctx.fillText(`• Azimut (θ): 45.00°`, originX + size * 0.35 + 10, originY - size * 0.95 + 40);
    ctx.fillText(`• Straal (ρ): -8.20 cm`, originX + size * 0.35 + 10, originY - size * 0.95 + 55);
    ctx.fillText(`• Nonius: -264`, originX + size * 0.35 + 10, originY - size * 0.95 + 70);

    ctx.fillStyle = '#ffcc33';
    ctx.fillText(`• KW #9 → N² = 010101 (01)`, originX + size * 0.35 + 10, originY - size * 0.95 + 90);
  }
}
JS_EOF
echo "✅ assets/vortex_duogram_matrix_widget.js aangemaakt."

echo "\$(date) - VORTEX OS v158.1 Complete assets build geslaagd op \\(BASE_DIR" > "\\)BASE_DIR/txt/geocentrum_manifest_build.log"

echo "=============================================================================="
echo "✅ Alle VORTEX OS v158.1 assets-bestanden en modules succesvol aangemaakt!"
echo "=============================================================================="
