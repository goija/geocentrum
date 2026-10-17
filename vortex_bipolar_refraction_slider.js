// ==============================================================================
// VORTEX OS v158.1 — Live Biskaje Refractiehoek Slider Module (-3,80°)
// ==============================================================================

const VortexRefractionSlider = (() => {
  let sliderEl = null, valueDisplay = null, currentAngle = -3.80;

  function createSliderWidget(containerId = 'vortex-bipolar-hud-container') {
    if (document.getElementById('vortex-refraction-slider-widget')) return;

    const style = document.createElement('style');
    style.textContent = `
      #vortex-refraction-slider-widget {
        position: fixed; bottom: 16px; right: 16px; width: 310px;
        background: rgba(10, 16, 28, 0.92); border: 1px solid rgba(0, 229, 255, 0.4);
        border-radius: 8px; padding: 10px 14px; box-shadow: 0 0 15px rgba(0, 229, 255, 0.2);
        z-index: 9999; font-family: 'JetBrains Mono', monospace; backdrop-filter: blur(6px); color: #e0e6ed;
      }
      .vortex-slider-header {
        display: flex; justify-content: space-between; align-align: center;
        font-size: 11px; color: #00e5ff; font-weight: bold; margin-bottom: 8px;
      }
      .vortex-slider-input { width: 100%; accent-color: #00e5ff; cursor: pointer; }
      .vortex-slider-labels { display: flex; justify-content: space-between; font-size: 9px; color: #88a0c0; margin-top: 4px; }
    `;
    document.head.appendChild(style);

    const widget = document.createElement('div');
    widget.id = 'vortex-refraction-slider-widget';
    widget.innerHTML = `
      <div class="vortex-slider-header">
        <span>🌊 BISKAJE REFRACTIE (SNELL)</span>
        <span id="vortex-refraction-val" style="color:#00ff88;">-3.80°</span>
      </div>
      <input type="range" id="vortex-refraction-range" class="vortex-slider-input" min="-10.0" max="5.0" step="0.05" value="-3.80">
      <div class="vortex-slider-labels">
        <span>-10.00° (Extreem)</span>
        <span style="color:#ffcc00;">-3.80° (Biskaje)</span>
        <span>+5.00°</span>
      </div>
    `;

    const parent = document.getElementById(containerId) || document.body;
    parent.appendChild(widget);

    sliderEl = document.getElementById('vortex-refraction-range');
    valueDisplay = document.getElementById('vortex-refraction-val');

    sliderEl.addEventListener('input', (e) => {
      currentAngle = parseFloat(e.target.value);
      valueDisplay.textContent = currentAngle.toFixed(2) + '°';
      window.dispatchEvent(new CustomEvent('vortex:refractionChange', {
        detail: { refractionAngle: currentAngle, effectiveVector: 245.91 + currentAngle }
      }));
    });
  }

  function init() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', () => createSliderWidget());
    } else {
      createSliderWidget();
    }
  }

  return { init, getAngle: () => currentAngle };
})();

if (typeof window !== 'undefined') {
  window.VortexRefractionSlider = VortexRefractionSlider;
  VortexRefractionSlider.init();
}
