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
