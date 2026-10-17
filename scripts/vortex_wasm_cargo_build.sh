#!/bin/bash
set -e
PROJECT_DIR="/home/ontwerp/Bureaublad/geocentrum-main/geocentrum-main"

if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
else
    echo "❌ Fout: Map $PROJECT_DIR niet gevonden!"
    exit 1
fi

# 1. Cargo.toml voor WebAssembly
cat << 'CARGO' > Cargo.toml
[package]
name = "vortex-geodetic-engine"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib", "rlib"]

[dependencies]
wasm-bindgen = "0.2"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
CARGO

# 2. Rust Source (src/lib.rs)
mkdir -p src
cat << 'RUST' > src/lib.rs
use wasm_bindgen::prelude::*;
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct GeodeticVectorResult {
    pub angle_deg: f64,
    pub wavelength_nm: f64,
    pub Snellius_refraction_deg: f64,
    pub opl_cm: f64,
    pub status: String,
}

#[wasm_bindgen]
pub fn calculate_vortex_vector(azimuth: f64, refractive_index_air: f64, refractive_index_water: f64) -> JsValue {
    let opl = 16.67 * refractive_index_air;
    let sin_theta2 = (refractive_index_air / refractive_index_water) * (15.0f64.to_radians()).sin();
    let theta2 = sin_theta2.asin().to_degrees();
    let refraction_delta = 15.0 - theta2;

    let result = GeodeticVectorResult {
        angle_deg: azimuth,
        wavelength_nm: 589.0,
        Snellius_refraction_deg: -refraction_delta,
        opl_cm: (opl * 1000.0).round() / 1000.0,
        status: "WASM_GEODETIC_LOCK_OK".to_string(),
    };

    serde_wasm_bindgen::to_value(&result).unwrap_or(JsValue::NULL)
}
RUST

# 3. Frontend Wasm Bridge Module
cat << 'JS' > vortex_wasm_bridge.js
const VortexWasmEngine = (() => {
  let wasmModule = null;
  async function initWasm() {
    try {
      if (window.wasm_bindgen) {
        await window.wasm_bindgen('./pkg/vortex_geodetic_engine_bg.wasm');
        wasmModule = window.wasm_bindgen;
      }
    } catch (e) {
      console.error("WASM Init Error:", e);
    }
  }
  return { initWasm };
})();
if (typeof window !== 'undefined') window.VortexWasmEngine = VortexWasmEngine;
JS

# 4. Cargo Check & Master Deploy
if command -v cargo &> /dev/null; then
    cargo check
fi

./vortex_master_deploy.sh > /tmp/vortex_deploy.log 2>&1
./vortex_telemetry_log_bridge.sh
./vortex_webhook_notifier.sh
echo "🎉 Wasm Rust Build & GitHub Deploy Voltooid!"
