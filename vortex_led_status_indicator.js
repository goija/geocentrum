const VortexLEDIndicator = (() => {
  const STATUS_URL = '/systeemdiagnose/update/telemetry_deploy_status.json';
  let containerEl = null;

  function createLEDWidget() {
    if (document.getElementById('vortex-led-status-widget')) return;

    const style = document.createElement('style');
    style.textContent = `
      #vortex-led-status-widget {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(10, 15, 25, 0.85);
        border: 1px solid rgba(0, 229, 255, 0.3);
        border-radius: 20px;
        padding: 4px 12px;
        font-family: 'JetBrains Mono', monospace;
        font-size: 11px;
        color: #e0e6ed;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(4px);
        z-index: 9999;
      }
      .vortex-led-dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        display: inline-block;
        transition: background 0.3s, box-shadow 0.3s;
      }
      .vortex-led-green {
        background: #00ff88;
        box-shadow: 0 0 8px #00ff88, 0 0 15px #00ff88;
        animation: vortex-pulse-green 2s infinite;
      }
      .vortex-led-red {
        background: #ff3366;
        box-shadow: 0 0 8px #ff3366, 0 0 15px #ff3366;
        animation: vortex-blink-red 0.8s infinite;
      }
      .vortex-led-orange {
        background: #ffaa00;
        box-shadow: 0 0 8px #ffaa00, 0 0 12px #ffaa00;
        animation: vortex-pulse-orange 1.5s infinite;
      }
      @keyframes vortex-pulse-green {
        0%, 100% { opacity: 1; transform: scale(1); }
        50% { opacity: 0.7; transform: scale(0.92); }
      }
      @keyframes vortex-blink-red {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.2; }
      }
      @keyframes vortex-pulse-orange {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
      }
    `;
    document.head.appendChild(style);

    containerEl = document.createElement('div');
    containerEl.id = 'vortex-led-status-widget';
    containerEl.innerHTML = `
      <span id="vortex-led-dot" class="vortex-led-dot vortex-led-orange"></span>
      <span id="vortex-led-text">DEPLOY: CONNECTING...</span>
    `;

    const targetHeader = document.querySelector('header') || document.querySelector('.vortex-top-bar') || document.querySelector('.navbar');
    if (targetHeader) {
      targetHeader.appendChild(containerEl);
    } else {
      containerEl.style.position = 'fixed';
      containerEl.style.top = '12px';
      containerEl.style.right = '16px';
      document.body.appendChild(containerEl);
    }
  }

  async function checkStatus() {
    try {
      const res = await fetch(STATUS_URL + '?t=' + Date.now());
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const data = await res.json();
      updateUI(data.status, data.timestamp);
    } catch (err) {
      updateUI('OFFLINE', null);
    }
  }

  function updateUI(status, timestamp) {
    const dot = document.getElementById('vortex-led-dot');
    const text = document.getElementById('vortex-led-text');
    if (!dot || !text) return;

    dot.className = 'vortex-led-dot';

    if (status === 'SUCCESS') {
      dot.classList.add('vortex-led-green');
      text.textContent = 'DEPLOY: LIVE (OK)';
      text.style.color = '#00ff88';
    } else if (status === 'FAILED') {
      dot.classList.add('vortex-led-red');
      text.textContent = 'DEPLOY: ERROR';
      text.style.color = '#ff3366';
    } else if (status === 'NO_LOG' || status === 'RUNNING') {
      dot.classList.add('vortex-led-orange');
      text.textContent = 'DEPLOY: SYNCING...';
      text.style.color = '#ffaa00';
    } else {
      dot.classList.add('vortex-led-orange');
      text.textContent = 'DEPLOY: IDLE';
      text.style.color = '#88a0c0';
    }

    if (window.VortexAudioChime && typeof window.VortexAudioChime.handleStatusUpdate === 'function') {
      window.VortexAudioChime.handleStatusUpdate(status);
    }
  }

  function init() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', () => {
        createLEDWidget();
        checkStatus();
        setInterval(checkStatus, 15000);
      });
    } else {
      createLEDWidget();
      checkStatus();
      setInterval(checkStatus, 15000);
    }
  }

  return { init, checkStatus };
})();

if (typeof window !== 'undefined') {
  window.VortexLEDIndicator = VortexLEDIndicator;
  VortexLEDIndicator.init();
}
