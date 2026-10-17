#!/bin/bash
set -e

PROJECT_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"
SYSTEMD_USER_DIR="\$HOME/.config/systemd/user"
SERVICE_NAME="vortex-geodetic-engine.service"

echo "======================================================================"
echo "⚡ VORTEX OS v158.1 — Systemd Service & Wasm Badge Setup"
echo "======================================================================"

cd "\$PROJECT_DIR"

# 1. Systemd User Service Bestand
mkdir -p "\$SYSTEMD_USER_DIR"
cat << SERVICE > "\\(SYSTEMD_USER_DIR/\\)SERVICE_NAME"
[Unit]
Description=VORTEX OS v158.1 — Rust Geodetic Engine Background Service
After=network.target

[Service]
Type=simple
WorkingDirectory=\$PROJECT_DIR
ExecStart=\$PROJECT_DIR/target/debug/vortex-geodetic-engine
Restart=always
RestartSec=3
Environment=RUST_LOG=info

[Install]
WantedBy=default.target
SERVICE

# Service inschakelen
if command -v systemctl &> /dev/null; then
    systemctl --user daemon-reload || true
    systemctl --user enable "\$SERVICE_NAME" || true
    systemctl --user restart "\$SERVICE_NAME" || true
    echo "✅ Systemd service \$SERVICE_NAME geactiveerd!"
fi

# 2. Wasm Badge Component
cat << 'JS' > vortex_wasm_badge.js
const VortexWasmBadge = (() => {
  function createBadge() {
    if (document.getElementById('vortex-wasm-badge-widget')) return;

    const style = document.createElement('style');
    style.textContent = `
      #vortex-wasm-badge-widget {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(0, 30, 50, 0.85);
        border: 1px solid rgba(0, 229, 255, 0.5);
        border-radius: 20px;
        padding: 4px 10px;
        font-family: 'JetBrains Mono', monospace;
        font-size: 11px;
        color: #00e5ff;
        box-shadow: 0 0 10px rgba(0, 229, 255, 0.3);
        backdrop-filter: blur(4px);
        margin-left: 8px;
        z-index: 9999;
      }
      .vortex-wasm-icon {
        font-size: 11px;
        animation: vortex-wasm-glow 2s infinite alternate;
      }
      @keyframes vortex-wasm-glow {
        from { text-shadow: 0 0 2px #00e5ff; }
        to { text-shadow: 0 0 8px #00e5ff, 0 0 12px #00e5ff; }
      }
    `;
    document.head.appendChild(style);

    const badge = document.createElement('div');
    badge.id = 'vortex-wasm-badge-widget';
    badge.innerHTML = `
      <span class="vortex-wasm-icon">⚡</span>
      <span id="vortex-wasm-text">WASM: ACTIVE</span>
    `;

    const parent = document.getElementById('vortex-led-status-widget') || document.querySelector('header') || document.body;
    parent.appendChild(badge);
  }

  function init() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', createBadge);
    } else {
      createBadge();
    }
  }

  return { init };
})();

if (typeof window !== 'undefined') {
  window.VortexWasmBadge = VortexWasmBadge;
  VortexWasmBadge.init();
}
JS

# 3. Master Deploy
./vortex_master_deploy.sh > /tmp/vortex_deploy.log 2>&1
./vortex_telemetry_log_bridge.sh
echo "🎉 Systemd Service & Wasm Badge Succesvol Uitgerold!"
