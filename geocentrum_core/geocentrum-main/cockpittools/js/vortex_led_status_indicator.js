/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: LED Status Indicator
 * Doel: Visuele real-time UI feedback voor systeemprocessen en netwerk
 * =====================================================================
 */

export class VortexLED {
    constructor(elementId, label = "System Status") {
        this.container = document.getElementById(elementId);
        this.label = label;
        this.state = 'standby'; // states: standby, active, warning, error, offline
        
        if (this.container) {
            this.render();
        } else {
            console.warn(`[LED] Waarschuwing: DOM element '${elementId}' niet gevonden.`);
        }
    }

    /**
     * Bouwt de interne HTML-structuur van de LED-indicator
     */
    render() {
        this.container.innerHTML = `
            <div class="vortex-led-wrapper" style="display: inline-flex; align-items: center; font-family: monospace; font-size: 0.9rem; padding: 5px 10px; background: rgba(0,0,0,0.3); border-radius: 4px; border: 1px solid rgba(255,255,255,0.1);">
                <div class="vortex-led-light" style="width: 12px; height: 12px; border-radius: 50%; margin-right: 10px; box-shadow: 0 0 8px currentColor; transition: all 0.3s ease;"></div>
                <span class="vortex-led-label" style="color: #e0e1dd;">${this.label}</span>
            </div>
        `;
        this.ledLight = this.container.querySelector('.vortex-led-light');
        this.updateColor();
    }

    /**
     * Werkt de kleur en de "glow" van de LED bij op basis van de status
     */
    updateColor() {
        if (!this.ledLight) return;
        
        const colors = {
            'standby': '#f4a261', // Oranje (wachtend)
            'active': '#2a9d8f',  // Groen (draait)
            'warning': '#e9c46a', // Geel (waarschuwing)
            'error': '#e76f51',   // Rood (fout)
            'offline': '#8d99ae'  // Grijs (uit)
        };
        
        const currentColor = colors[this.state] || colors['offline'];
        this.ledLight.style.backgroundColor = currentColor;
        this.ledLight.style.color = currentColor; // Gebruikt voor de CSS box-shadow
    }

    /**
     * Wijzig de systeemstatus
     * @param {string} newState - 'active', 'standby', 'error', 'warning', 'offline'
     */
    setStatus(newState) {
        this.state = newState;
        this.updateColor();
        console.log(`🚥 [LED] '${this.label}' status gewijzigd naar: ${newState}`);
    }

    /**
     * Laat de LED even knipperen (handig bij inkomende datapakketten)
     */
    blink() {
        if (!this.ledLight) return;
        this.ledLight.style.opacity = '0.2';
        setTimeout(() => {
            this.ledLight.style.opacity = '1.0';
        }, 150);
    }
}
