// ==============================================================================
// VORTEX OS v158.1 — Spectrale Waterval (Spectrogram) Module (589 nm Fraunhofer D)
// ==============================================================================

const VortexSpectrogramWaterfall = (() => {
  let canvas = null;
  let ctx = null;
  let analyser = null;
  let isRunning = false;
  let tempCanvas = null;
  let tempCtx = null;

  function initCanvas(containerId = 'vortex-spectrogram-container') {
    let container = document.getElementById(containerId);
    if (!container) {
      container = document.createElement('div');
      container.id = containerId;
      container.style.cssText = `
        position: fixed;
        bottom: 16px;
        left: 16px;
        width: 320px;
        height: 180px;
        background: rgba(8, 12, 20, 0.9);
        border: 1px solid rgba(255, 204, 0, 0.4);
        border-radius: 8px;
        padding: 8px;
        box-shadow: 0 0 15px rgba(255, 204, 0, 0.2);
        z-index: 9998;
        font-family: 'JetBrains Mono', monospace;
        backdrop-filter: blur(6px);
      `;
      document.body.appendChild(container);
    }

    container.innerHTML = `
      <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px; font-size:10px; color:#ffcc00; font-weight:bold;">
        <span>🌈 LASER SPECTROGRAM (589 nm D-LINE)</span>
        <span id="vortex-laser-status" style="color:#00ff88;">LOCKED</span>
      </div>
      <canvas id="vortex-waterfall-canvas" width="304" height="150" style="width:100%; height:150px; background:#04060a; border-radius:4px; display:block;"></canvas>
    `;

    canvas = document.getElementById('vortex-waterfall-canvas');
    ctx = canvas.getContext('2d');

    tempCanvas = document.createElement('canvas');
    tempCanvas.width = canvas.width;
    tempCanvas.height = canvas.height;
    tempCtx = tempCanvas.getContext('2d');
  }

  function getFraunhoferColor(intensity, isLaserPeak) {
    if (isLaserPeak) {
      return `rgb(255, ${Math.floor(200 + intensity * 55)}, 0)`;
    }
    const r = Math.floor(intensity * 255);
    const g = Math.floor(Math.sin(intensity * Math.PI) * 200);
    const b = Math.floor((1 - intensity) * 150);
    return `rgb(${r}, ${g}, ${b})`;
  }

  function renderFrame(dataArray) {
    if (!ctx || !canvas) return;

    const w = canvas.width;
    const h = canvas.height;

    tempCtx.drawImage(canvas, 0, 0);
    ctx.drawImage(tempCanvas, 0, 1);

    const numBins = dataArray ? dataArray.length : 128;
    const binWidth = w / numBins;

    for (let i = 0; i < numBins; i++) {
      const val = dataArray ? dataArray[i] / 255 : (0.2 + 0.3 * Math.sin(i * 0.1 + Date.now() * 0.005));
      const isFraunhoferPeak = (i >= 40 && i <= 44);
      const intensity = isFraunhoferPeak ? Math.min(1.0, val * 1.5 + 0.3) : val;

      ctx.fillStyle = getFraunhoferColor(intensity, isFraunhoferPeak);
      ctx.fillRect(i * binWidth, 0, binWidth + 0.5, 1);
    }

    const laserX = (42 / numBins) * w;
    ctx.fillStyle = 'rgba(255, 204, 0, 0.2)';
    ctx.fillRect(laserX - 2, 0, 4, h);
  }

  function start(analyserNode) {
    if (isRunning) return;
    analyser = analyserNode;
    isRunning = true;
    initCanvas();

    const dataArray = analyser ? new Uint8Array(analyser.frequencyBinCount) : null;

    function loop() {
      if (!isRunning) return;
      if (analyser && dataArray) {
        analyser.getByteFrequencyData(dataArray);
      }
      renderFrame(dataArray);
      requestAnimationFrame(loop);
    }
    loop();
  }

  function stop() {
    isRunning = false;
  }

  return { start, stop, initCanvas, renderFrame };
})();

if (typeof window !== 'undefined') {
  window.VortexSpectrogramWaterfall = VortexSpectrogramWaterfall;
  document.addEventListener('DOMContentLoaded', () => {
    VortexSpectrogramWaterfall.start(null);
  });
}
