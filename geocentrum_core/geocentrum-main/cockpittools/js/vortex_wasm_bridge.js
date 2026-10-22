/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: WebAssembly (WASM) Bridge
 * Doel: Communicatie tussen JavaScript frontend en Rust/C++ rekenkernen
 * =====================================================================
 */

export class VortexWasmBridge {
    constructor() {
        this.wasmInstance = null;
        this.isLoaded = false;
    }

    /**
     * Laadt een gecompileerd WebAssembly (.wasm) bestand in de browser.
     * @param {string} wasmPath - Het relatieve pad naar het .wasm bestand.
     * @returns {Promise<boolean>} - True als de module succesvol is geladen.
     */
    async loadModule(wasmPath) {
        try {
            console.log(`⏳ WASM module laden vanaf: ${wasmPath}...`);
            const response = await fetch(wasmPath);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const buffer = await response.arrayBuffer();
            
            // Import object voor functies die WASM mag aanroepen in JS (zoals console.log)
            const importObject = {
                env: {
                    console_log: (arg) => console.log(`[WASM LOG]: ${arg}`)
                }
            };

            const module = await WebAssembly.instantiate(buffer, importObject);
            this.wasmInstance = module.instance.exports;
            this.isLoaded = true;
            
            console.log(`✅ WASM module '${wasmPath}' succesvol geïnitialiseerd.`);
            return true;
        } catch (error) {
            console.error(`❌ Fout bij het laden van WASM module '${wasmPath}':`, error);
            this.isLoaded = false;
            return false;
        }
    }

    /**
     * Voorbeeld: Voert een zware wiskundige berekening uit in de Rust kern.
     * @param {number} seed - De initiële seed voor de LFSR generator.
     * @returns {number} - Het berekende resultaat uit WebAssembly.
     */
    runGaloisLFSR(seed) {
        if (!this.isLoaded || !this.wasmInstance.next_lfsr_bit) {
            console.warn("⚠️ WASM module is niet geladen of functie 'next_lfsr_bit' ontbreekt.");
            return null;
        }
        
        // Roep de geëxporteerde Rust-functie aan
        const result = this.wasmInstance.next_lfsr_bit(seed);
        return result;
    }
}
