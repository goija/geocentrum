/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Spectrogram Waterfall
 * Doel: Real-time datastromen (frequenties, attractoren) visueel weergeven
 * =====================================================================
 */

export class VortexSpectrogramWaterfall {
    constructor(canvasId, width = 800, height = 300) {
        this.canvas = document.getElementById(canvasId);
        if (!this.canvas) {
            console.error(`⚠️ [SPECTROGRAM] Canvas met id '${canvasId}' niet gevonden.`);
            return;
        }
        
        this.ctx = this.canvas.getContext('2d', { alpha: false });
        this.width = width;
        this.height = height;
        this.canvas.width = this.width;
        this.canvas.height = this.height;

        // Initieer met een zwarte achtergrond
        this.ctx.fillStyle = '#000000';
        this.ctx.fillRect(0, 0, this.width, this.height);
        
        this.rowHeight = 2; // Hoeveel pixels de waterval per stap opschuift
        console.log(`🌊 [SPECTROGRAM] Waterfall geïnitialiseerd op '${canvasId}'.`);
    }

    /**
     * Zet een numerieke waarde (0-255) om naar een warmte-kleur.
     * Zwart -> Donkerblauw -> Cyaan -> Groen -> Geel -> Rood
     */
    getColor(value) {
        if (value < 20) return '#000000';
        if (value < 60) return `rgb(0, 0, ${value * 4})`;
        if (value < 120) return `rgb(0, ${(value - 60) * 4}, 255)`;
        if (value < 180) return `rgb(${(value - 120) * 4}, 255, ${(180 - value) * 4})`;
        if (value < 230) return `rgb(255, ${(230 - value) * 5}, 0)`;
        return `rgb(255, 0, 0)`;
    }

    /**
     * Tekent één nieuwe regel data bovenaan het canvas en schuift de rest naar beneden.
     * @param {Array<number>} dataArray - Array met intensiteitswaarden (0-255).
     */
    drawRow(dataArray) {
        if (!this.ctx) return;

        // Schuif het bestaande beeld naar beneden
        const imageData = this.ctx.getImageData(0, 0, this.width, this.height - this.rowHeight);
        this.ctx.putImageData(imageData, 0, this.rowHeight);

        // Bepaal de breedte per datablokje
        const segmentWidth = this.width / dataArray.length;

        // Teken de nieuwe rij bovenaan
        for (let i = 0; i < dataArray.length; i++) {
            this.ctx.fillStyle = this.getColor(dataArray[i]);
            this.ctx.fillRect(Math.floor(i * segmentWidth), 0, Math.ceil(segmentWidth), this.rowHeight);
        }
    }

    /**
     * Test-functie: Genereert willekeurige ruisdata om de waterval te testen.
     */
    startMockData() {
        console.log("🧪 [SPECTROGRAM] Mock data gestart...");
        setInterval(() => {
            const mockData = Array.from({ length: 100 }, () => Math.floor(Math.random() * 256));
            
            // Simuleer een 'signaal piek' op een willekeurige frequentie
            const peak = Math.floor(Math.random() * 80) + 10;
            for(let i = 0; i < 5; i++) {
                if (mockData[peak + i]) mockData[peak + i] = 255;
            }

            this.drawRow(mockData);
        }, 50); // 20 frames per seconde
    }
}
