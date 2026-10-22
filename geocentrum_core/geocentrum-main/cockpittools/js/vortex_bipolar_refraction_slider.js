/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Bipolar Refraction Slider
 * Doel: UI component voor fijnmazige, bipolaire aanpassing van refractiewaarden
 * =====================================================================
 */

export class VortexBipolarRefractionSlider {
    constructor(containerId, min = -10.0, max = 10.0, step = 0.01, initial = 0.0) {
        this.container = document.getElementById(containerId);
        this.min = min;
        this.max = max;
        this.step = step;
        this.value = initial;
        this.callbacks = [];

        if (this.container) {
            this.render();
        } else {
            console.error(`⚠️ [SLIDER] Container '${containerId}' niet gevonden.`);
        }
    }

    /**
     * Tekent de slider en de actuele waarde in het gekoppelde HTML-element.
     */
    render() {
        this.container.innerHTML = `
            <div class="vortex-slider-container" style="padding: 15px; background: rgba(0,0,0,0.4); border-radius: 6px; border: 1px solid rgba(255,255,255,0.1); color: #e0e1dd; font-family: monospace; width: 100%; box-sizing: border-box;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                    <span style="opacity: 0.8;">Refractie Coëfficiënt (k)</span>
                    <span id="slider-val-${this.container.id}" style="color: #00b4d8; font-weight: bold; font-size: 1.1rem;">${this.value.toFixed(2)}</span>
                </div>
                <input type="range" id="slider-input-${this.container.id}" min="${this.min}" max="${this.max}" step="${this.step}" value="${this.value}" style="width: 100%; cursor: pointer; accent-color: #00b4d8;">
                <div style="display: flex; justify-content: space-between; font-size: 0.8rem; opacity: 0.5; margin-top: 8px;">
                    <span>${this.min}</span>
                    <span>0</span>
                    <span>${this.max}</span>
                </div>
            </div>
        `;

        this.sliderElement = document.getElementById(`slider-input-${this.container.id}`);
        this.valueLabel = document.getElementById(`slider-val-${this.container.id}`);

        // Koppel het input-event om waarden live te updaten
        this.sliderElement.addEventListener('input', (e) => {
            this.value = parseFloat(e.target.value);
            this.valueLabel.innerText = this.value.toFixed(2);
            this.triggerCallbacks(this.value);
        });
        
        console.log(`🎚️ [SLIDER] Geïnitialiseerd in container '${this.container.id}'`);
    }

    /**
     * Koppel een functie die wordt aangeroepen zodra de slider beweegt.
     * @param {Function} callback 
     */
    onChange(callback) {
        if (typeof callback === 'function') {
            this.callbacks.push(callback);
        }
    }

    triggerCallbacks(val) {
        for (let cb of this.callbacks) {
            cb(val);
        }
    }
}
