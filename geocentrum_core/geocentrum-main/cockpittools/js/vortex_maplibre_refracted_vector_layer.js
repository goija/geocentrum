/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Atmospheric Refraction Vector Layer (MapLibre GL JS)
 * Model: Saemundsson Refraction Equation
 * =====================================================================
 */

export class VortexRefractedVectorLayer {
    constructor(mapInstance, sourceId = 'vortex-refraction-source') {
        this.map = mapInstance;
        this.sourceId = sourceId;
    }

    /**
     * Saemundsson's formule voor atmosferische refractie.
     * @param {number} h - Ware elevatiehoek in graden (True Altitude).
     * @returns {number} - Refractiecorrectie in graden.
     */
    static calculateSaemundssonRefraction(h) {
        if (h <= -5.0) return 0; // Buiten atmosferische invloedssfeer

        // R (in boogminuten) = 1.02 / tan(h + 10.3 / (h + 5.11))
        const correctionDeg = 10.3 / (h + 5.11);
        const tanArg = (h + correctionDeg) * (Math.PI / 180);
        
        const rArcMin = 1.02 / Math.tan(tanArg);
        return rArcMin / 60.0; // Conversie naar graden voor MapLibre projecties
    }

    /**
     * Berekent de schijnbare elevatie op basis van de ware elevatie.
     * @param {number} trueAltitude - Ware elevatiehoek.
     * @returns {number} - Schijnbare elevatiehoek (Apparent Altitude).
     */
    static getApparentAltitude(trueAltitude) {
        const refraction = this.calculateSaemundssonRefraction(trueAltitude);
        return trueAltitude + refraction;
    }

    /**
     * Voegt de GeoJSON data source toe aan de MapLibre instantie.
     * @param {Object} geojson - De berekende vector data.
     */
    addRefractedSource(geojson) {
        if (!this.map.getSource(this.sourceId)) {
            this.map.addSource(this.sourceId, {
                type: 'geojson',
                data: geojson
            });
            console.log(`🌐 GeoJSON source '${this.sourceId}' toegevoegd aan MapLibre.`);
        } else {
            this.map.getSource(this.sourceId).setData(geojson);
        }
    }

    /**
     * Voegt de visuele render-laag toe aan de kaart.
     * @param {string} layerId - Unieke ID voor de kaartlaag.
     * @param {string} color - HEX of RGB kleurcode.
     */
    addVectorLayer(layerId = 'vortex-refraction-layer', color = '#FF3366') {
        if (!this.map.getLayer(layerId)) {
            this.map.addLayer({
                id: layerId,
                type: 'line',
                source: this.sourceId,
                layout: {
                    'line-join': 'round',
                    'line-cap': 'round'
                },
                paint: {
                    'line-color': color,
                    'line-width': 3,
                    'line-opacity': 0.8
                }
            });
            console.log(`✅ Refracted vector layer '${layerId}' succesvol gerenderd.`);
        }
    }
}
