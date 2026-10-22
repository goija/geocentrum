const VORTEX_HASH_ANKERS = {
    "PAGE-01":    { label: "GEOCENTRUM", theta_deg: 245.91, rho_cm: 10.75, nonius: 2476,  sigma: -1.0 },
    "MAP-OW":     { label: "Omgevingsw (MAP-OW)", theta_deg: 29.00,  rho_cm: 10.25, nonius: 12960, sigma:  1.0 },
    "SUB-OW-BAL": { label: "DSO / Bal (SUB-OW-BAL)", theta_deg: 108.00, rho_cm: 10.50, nonius: 12960, sigma: -1.0 },
    "ANNEROSE":   { label: "Annerose D", theta_deg: 62.10,  rho_cm: 8.88,  nonius: 1489,  sigma: -1.0 },
    "NEBRA":      { label: "nebra-plei", theta_deg: 45.00,  rho_cm: 10.75, nonius: 26214, sigma: -1.0 },
    "REIMERSWAAL":{ label: "Verdronken", theta_deg: 226.40, rho_cm: 9.50,  nonius: 14062, sigma: -1.0 }
};

function evaluateLocalPlanimeter(input) {
    const rad = input.theta_deg * Math.PI / 180.0;
    const r = Math.abs(input.rho_cm);
    const x_cm = Math.round(r * Math.sin(rad) * 100) / 100;
    const y_cm = Math.round(-r * Math.cos(rad) * 100) / 100;

    const lon_geojson = 1.85 + 0.78 * x_cm;
    const lat_neg = 47.25 + 0.52 * y_cm;
    const lat_plat = 47.25 - 0.338 * y_cm;

    const norm_theta = ((input.theta_deg % 360) + 360) % 360;
    const sector = Math.floor(norm_theta / 5.625) & 0x3F;
    const bits_val = sector < 32 ? (63 - sector) : (sector - 32);
    const t_val = (bits_val >> 2) & 0b11;
    const n2_val = (t_val << 4) | (t_val << 2) | t_val;

    const nonius_norm = Math.min(1.0, Math.max(0.0, Math.abs(input.nonius) / 26214.0));
    const matrix_x = Math.min(63, Math.floor(nonius_norm * 64.0));
    const matrix_y = sector;

    return {
        label: input.label,
        x_cm,
        y_cm,
        theta_deg: input.theta_deg,
        rho_cm: input.rho_cm,
        sigma: input.sigma,
        nonius: input.nonius,
        area_cm2: input.nonius * 0.1,
        lon_geojson,
        lat_plat,
        lat_neg,
        hinge: {
            sector_64: sector,
            bits_str: bits_val.toString(2).padStart(6, '0'),
            hinge_t: t_val.toString(2).padStart(2, '0'),
            n2_bits: n2_val.toString(2).padStart(6, '0'),
            matrix_x,
            matrix_y
        }
    };
}

function resolveHashAnker() {
    const hash = window.location.hash.replace(/^#/, '');
    const params = new URLSearchParams(hash);
    const submapId = params.get('submapId');
    const mapId = params.get('mapId');
    const pageId = params.get('pageId');

    return VORTEX_HASH_ANKERS[submapId]
        || VORTEX_HASH_ANKERS[mapId]
        || VORTEX_HASH_ANKERS[pageId]
        || { label: "Laren P (52.250°N, 5.220°E)", theta_deg: 45.0, rho_cm: -8.20, nonius: -264, sigma: -1.0 };
}

function syncFromHash() {
    const anker = resolveHashAnker();
    const sTheta = document.getElementById('sliderTheta');
    const sRho = document.getElementById('sliderRho');
    const sSigma = document.getElementById('sliderSigma');
    const iNonius = document.getElementById('inputNonius');
    if (sTheta) sTheta.value = anker.theta_deg;
    if (sRho) sRho.value = anker.rho_cm;
    if (sSigma) sSigma.value = anker.sigma;
    if (iNonius) iNonius.value = anker.nonius;
    updateDashboardUI(evaluateLocalPlanimeter(anker));
}

function updateDashboardUI(data) {
    const elAnker = document.getElementById('lblAnker');
    if (!elAnker) return;
    elAnker.innerText = `${data.label} [${window.location.hash || '#PAGE-01'}]`;
    document.getElementById('valNonius').innerText = `${data.nonius} (${data.area_cm2.toFixed(1)} cm²)`;
    document.getElementById('valTheta').innerText = `${data.theta_deg.toFixed(2)}° | ρ = ${data.rho_cm.toFixed(2)} cm (x=${data.x_cm} cm, y=${data.y_cm} cm)`;
    document.getElementById('valHinge').innerText = `(${data.hinge.bits_str}) → N²=${data.hinge.n2_bits} [Hinge t=${data.hinge.hinge_t}]`;
    document.getElementById('valGeo').innerText = `PLAT: ${data.lat_plat.toFixed(4)}°N, ${data.lon_geojson.toFixed(4)}°E | NEG: ${data.lat_neg.toFixed(4)}°N`;
    renderMatrixPoint(data.hinge.matrix_x, data.hinge.matrix_y);
}

function sendTelemetryUpdate() {
    const payload = {
        label: resolveHashAnker().label,
        theta_deg: parseFloat(document.getElementById('sliderTheta').value),
        rho_cm: parseFloat(document.getElementById('sliderRho').value),
        sigma: parseFloat(document.getElementById('sliderSigma').value),
        nonius: parseInt(document.getElementById('inputNonius').value, 10) || 12960
    };
    updateDashboardUI(evaluateLocalPlanimeter(payload));
}

function renderMatrixPoint(x, y) {
    const canvas = document.getElementById('matrixCanvas');
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    ctx.fillStyle = 'rgba(10, 18, 24, 0.3)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.strokeStyle = '#1e3a4c';
    for (let i = 0; i <= 64; i += 8) {
        ctx.beginPath(); ctx.moveTo(i * 8, 0); ctx.lineTo(i * 8, 512); ctx.stroke();
        ctx.beginPath(); ctx.moveTo(0, i * 8); ctx.lineTo(512, i * 8); ctx.stroke();
    }
    // Markeer MAP-OW (31,5) en SUB-OW-BAL (31,19) referentiepunten
    ctx.fillStyle = '#ffbf00';
    ctx.fillRect(31 * 8, 5 * 8, 8, 8);
    ctx.fillRect(31 * 8, 19 * 8, 8, 8);
    // Actief punt
    ctx.fillStyle = '#00ffcc';
    ctx.fillRect(x * 8, y * 8, 8, 8);
}

window.addEventListener('hashchange', syncFromHash);
window.addEventListener('DOMContentLoaded', syncFromHash);
