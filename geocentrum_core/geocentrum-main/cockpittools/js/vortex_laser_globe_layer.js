/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: Laser Globe Layer (MapLibre/Mapbox 3D)
 * Doel: Renderen van geodetische vectoren met een neon/laser visueel effect
 * =====================================================================
 */

export class VortexLaserGlobeLayer {
    constructor(mapInstance, sourceId = "vortex-laser-source") {
        this.map = mapInstance;
        this.sourceId = sourceId;
        this.features = [];
        this.isInitialized = false;
    }

    /**
     * Initialiseert de GeoJSON source en de rendering lagen (Outer Glow + Inner Core).
     */
    initLayer() {
        if (!this.map.getSource(this.sourceId)) {
            this.map.addSource(this.sourceId, {
                type: 'geojson',
                data: { type: 'FeatureCollection', features: [] }
            });
        }

        // 1. Outer Glow (Zachte, gekleurde gloed)
        if (!this.map.getLayer(`${this.sourceId}-glow`)) {
            this.map.addLayer({
                id: `${this.sourceId}-glow`,
                type: 'line',
                source: this.sourceId,
                layout: { 'line-join': 'round', 'line-cap': 'round' },
                paint: {
                    'line-color': ['get', 'color'],
                    'line-width': 8,
                    'line-opacity': 0.5,
                    'line-blur': 4
                }
            });
        }

        // 2. Inner Core (Harde, witte kern van de laser)
        if (!this.map.getLayer(`${this.sourceId}-core`)) {
            this.map.addLayer({
                id: `${this.sourceId}-core`,
                type: 'line',
                source: this.sourceId,
                layout: { 'line-join': 'round', 'line-cap': 'round' },
                paint: {
                    'line-color': '#FFFFFF',
                    'line-width': 2,
                    'line-opacity': 1.0
                }
            });
        }

        this.isInitialized = true;
        console.log(`🌐 [LASER LAYER] Geïnitialiseerd met ID: ${this.sourceId}`);
    }

    /**
     * Tekent een nieuwe laserstraal tussen twee coördinaten.
     * @param {Array} startLngLat - [longitude, latitude] van startpunt
     * @param {Array} endLngLat - [longitude, latitude] van eindpunt
     * @param {string} color - HEX code van de laser (bijv. #00FFCC)
     */
    fireLaser(startLngLat, endLngLat, color = '#FF0055') {
        if (!this.isInitialized) this.initLayer();

        const newLaser = {
            type: 'Feature',
            geometry: {
                type: 'LineString',
                // Binnen een MapLibre 'globe' projectie wordt een LineString 
                // automatisch gebogen over de sfeer van de aarde.
                coordinates: [startLngLat, endLngLat] 
            },
            properties: { color: color }
        };

        this.features.push(newLaser);
        this.updateSource();
        console.log(`⚡ [LASER LAYER] Vector toegevoegd naar [${endLngLat}]`);
    }

    /**
     * Wist alle getekende lasers van de globe.
     */
    clearLasers() {
        this.features = [];
        this.updateSource();
        console.log(`🧹 [LASER LAYER] Alle vectoren gewist.`);
    }

    /**
     * Update de MapLibre source met de nieuwe feature array.
     */
    updateSource() {
        const source = this.map.getSource(this.sourceId);
        if (source) {
            source.setData({
                type: 'FeatureCollection',
                features: this.features
            });
        }
    }
}
