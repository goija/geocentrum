/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Laren Global Anchor & Geodetic Grid
 * Doel: Tekenen van het primaire ijkpunt (52.257° N, 5.225° E) en concentrische cirkels
 * =====================================================================
 */

export class VortexLarenAnchorGrid {
    constructor(mapInstance, sourceId = 'laren-anchor-source') {
        this.map = mapInstance;
        this.sourceId = sourceId;
        this.anchorCoords = [5.225, 52.257]; // [Lng, Lat]
        console.log(`Anchor [GIS]: Laren Global Anchor geladen op [${this.anchorCoords}]`);
    }

    /**
     * Genereert een cirkel (Polygon) in GeoJSON op basis van een middelpunt en straal in kilometers.
     */
    createCirclePolygon(centerLngLat, radiusKm, points = 64) {
        const coords = [];
        const kmDeg = 1 / 111.32; // Benadering van km naar graden op aardoppervlak

        for (let i = 0; i < points; i++) {
            const theta = (i / points) * (2 * Math.PI);
            const dx = radiusKm * Math.cos(theta) * kmDeg;
            const dy = radiusKm * Math.sin(theta) * kmDeg;
            
            // Correctie voor lengtegraad afhankelijk van breedtegraad
            const lng = centerLngLat[0] + (dx / Math.cos(Math.radians(centerLngLat[1])));
            const lat = centerLngLat[1] + dy;
            coords.push([lng, lat]);
        }
        coords.push(coords[0]); // Sluit de polygoon

        return {
            type: 'Feature',
            geometry: {
                type: 'Polygon',
                coordinates: [coords]
            },
            properties: { radius: radiusKm }
        };
    }

    /**
     * Voegt het ijkpunt en de referentiecirkels toe aan de MapLibre kaart.
     */
    initAnchorLayer() {
        const features = [
            // 1. Het centrale ijkpunt (Marker punt)
            {
                type: 'Feature',
                geometry: {
                    type: 'Point',
                    coordinates: this.anchorCoords
                },
                properties: { title: 'Laren Global Anchor', type: 'anchor' }
            },
            // 2. Concentrische cirkels (straal 5km en 15km)
            this.createCirclePolygon(this.anchorCoords, 5),
            this.createCirclePolygon(this.anchorCoords, 15)
        ];

        const geojson = {
            type: 'FeatureCollection',
            features: features
        };

        if (!this.map.getSource(this.sourceId)) {
            this.map.addSource(this.sourceId, {
                type: 'geojson',
                data: geojson
            });

            // Lagen voor de cirkels
            this.map.addLayer({
                id: `${this.sourceId}-circles`,
                type: 'line',
                source: this.sourceId,
                filter: ['==', '$type', 'Polygon'],
                paint: {
                    'line-color': '#00b4d8',
                    'line-width': 1.5,
                    'line-dasharray': [2, 2],
                    'line-opacity': 0.6
                }
            });

            // Laag voor het ankerpunt
            this.map.addLayer({
                id: `${this.sourceId}-point`,
                type: 'circle',
                source: this.sourceId,
                filter: ['==', '$type', 'Point'],
                paint: {
                    'circle-radius': 8,
                    'circle-color': '#ff3366',
                    'circle-stroke-width': 2,
                    'circle-stroke-color': '#ffffff'
                }
            });

            console.log("🌐 [ANCHOR GRID] Laren Global Anchor referentiegrid succesvol gerenderd.");
        }
    }
}

// Helper voor radialen in cirkelberekening
if (!Math.radians) {
    Math.radians = function(degrees) {
        return degrees * Math.PI / 180;
    };
}
