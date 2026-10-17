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
