/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Kadaster DXF Loader & Parser
 * Doel: DXF-bestanden inladen, parsen naar GeoJSON en renderen (MapLibre)
 * =====================================================================
 */

export class VortexKadasterDxfLoader {
    constructor(mapInstance, sourceId = 'kadaster-dxf-source') {
        this.map = mapInstance;
        this.sourceId = sourceId;
        this.layerId = `${sourceId}-layer`;
        console.log(`📐 [DXF LOADER] Geïnitialiseerd voor source: ${this.sourceId}`);
    }

    /**
     * Laadt een DXF bestand in via fetch en start de parsing.
     * @param {string} filePath - Relatief pad naar de .dxf (bijv. '../data/kadaster.dxf')
     */
    async loadAndRenderDxf(filePath) {
        console.log(`[DXF LOADER] Start inladen van: ${filePath}...`);
        try {
            const response = await fetch(filePath);
            if (!response.ok) throw new Error(`HTTP fout! Status: ${response.status}`);
            
            const dxfText = await response.text();
            const geojson = this.parseDxfToGeoJson(dxfText);
            
            this.addSourceAndLayer(geojson);
            console.log(`✅ [DXF LOADER] Bestand geparst en succesvol op de kaart gerenderd.`);
        } catch (error) {
            console.error(`❌ [DXF LOADER] Fout bij laden van DXF:`, error);
        }
    }

    /**
     * Eenvoudige state-machine parser om DXF LINE entiteiten om te zetten naar GeoJSON.
     * @param {string} dxfText - De ruwe tekst van het DXF bestand
     * @returns {Object} GeoJSON FeatureCollection
     */
    parseDxfToGeoJson(dxfText) {
        const lines = dxfText.split(/\r?\n/).map(l => l.trim());
        const features = [];
        
        let inEntitiesSection = false;
        let currentEntity = null;
        let x1 = null, y1 = null, x2 = null, y2 = null;

        for (let i = 0; i < lines.length; i++) {
            const code = lines[i];
            const value = lines[i + 1];

            if (code === '2' && value === 'ENTITIES') inEntitiesSection = true;
            if (code === '0' && value === 'ENDSEC' && inEntitiesSection) break;

            if (inEntitiesSection) {
                if (code === '0' && value === 'LINE') {
                    // Sla de vorige op indien compleet
                    if (x1 !== null && y1 !== null && x2 !== null && y2 !== null) {
                        features.push(this.createLineFeature(x1, y1, x2, y2));
                    }
                    currentEntity = 'LINE';
                    x1 = y1 = x2 = y2 = null; // Reset
                }

                if (currentEntity === 'LINE') {
                    if (code === '10') x1 = parseFloat(value);
                    if (code === '20') y1 = parseFloat(value);
                    if (code === '11') x2 = parseFloat(value);
                    if (code === '21') y2 = parseFloat(value);
                }
            }
            i++; // Sla de value-regel over in de loop
        }

        // Voeg de laatste entiteit toe
        if (x1 !== null && y1 !== null && x2 !== null && y2 !== null) {
            features.push(this.createLineFeature(x1, y1, x2, y2));
        }

        console.log(`[DXF LOADER] Parsing voltooid. ${features.length} lijnen gevonden.`);
        
        return {
            type: "FeatureCollection",
            features: features
        };
    }

    createLineFeature(x1, y1, x2, y2) {
        return {
            type: "Feature",
            geometry: {
                type: "LineString",
                coordinates: [[x1, y1], [x2, y2]]
            },
            properties: { layer: "VORTEX_KADASTER" }
        };
    }

    /**
     * Voegt de resulterende GeoJSON toe aan de MapLibre kaart als vectorlaag.
     */
    addSourceAndLayer(geojson) {
        if (this.map.getSource(this.sourceId)) {
            this.map.getSource(this.sourceId).setData(geojson);
        } else {
            this.map.addSource(this.sourceId, {
                type: 'geojson',
                data: geojson
            });

            this.map.addLayer({
                id: this.layerId,
                type: 'line',
                source: this.sourceId,
                layout: {
                    'line-join': 'miter',
                    'line-cap': 'square'
                },
                paint: {
                    'line-color': '#f4a261', // Opvallende kadastrale oranje kleur
                    'line-width': 2,
                    'line-opacity': 0.8
                }
            });
        }
    }
}
