/**
 * =====================================================================
 * VORTEX OS - GeoCentrum
 * Module: DXF Export Module
 * Doel: Geodetische coördinaten en lijnen exporteren naar CAD-formaat (.dxf)
 * =====================================================================
 */

export class VortexDxfExport {
    constructor(filename = "vortex_kadaster_export") {
        this.filename = filename;
        this.entities = [];
        this.layerName = "VORTEX_GEODESY";
        console.log(`📐 [DXF EXPORT] Geïnitialiseerd. Target: ${this.filename}.dxf`);
    }

    /**
     * Voegt een lijn toe aan de DXF export.
     * @param {number} x1 - Start X (Longitude)
     * @param {number} y1 - Start Y (Latitude)
     * @param {number} x2 - Eind X (Longitude)
     * @param {number} y2 - Eind Y (Latitude)
     */
    addLine(x1, y1, x2, y2) {
        const line = `  0\nLINE\n  8\n${this.layerName}\n 10\n${x1.toFixed(6)}\n 20\n${y1.toFixed(6)}\n 30\n0.0\n 11\n${x2.toFixed(6)}\n 21\n${y2.toFixed(6)}\n 31\n0.0`;
        this.entities.push(line);
    }

    /**
     * Verwerkt een GeoJSON Feature (LineString) naar DXF lijnen.
     * @param {Object} geojsonFeature - De GeoJSON LineString
     */
    addGeoJsonLineString(geojsonFeature) {
        if (geojsonFeature.geometry.type !== "LineString") {
            console.warn("⚠️ [DXF EXPORT] Ondersteunt momenteel alleen LineStrings.");
            return;
        }

        const coords = geojsonFeature.geometry.coordinates;
        for (let i = 0; i < coords.length - 1; i++) {
            const [x1, y1] = coords[i];
            const [x2, y2] = coords[i + 1];
            this.addLine(x1, y1, x2, y2);
        }
        console.log(`✅ [DXF EXPORT] GeoJSON LineString toegevoegd (${coords.length - 1} segmenten).`);
    }

    /**
     * Genereert de ruwe tekst voor het .dxf bestand.
     */
    generateDxfString() {
        const header = "  0\nSECTION\n  2\nENTITIES";
        const footer = "  0\nENDSEC\n  0\nEOF";
        return `${header}\n${this.entities.join("\n")}\n${footer}`;
    }

    /**
     * Forceert een download van het .dxf bestand in de browser.
     */
    export() {
        if (this.entities.length === 0) {
            console.warn("⚠️ [DXF EXPORT] Geen entiteiten om te exporteren.");
            return;
        }

        const dxfString = this.generateDxfString();
        const blob = new Blob([dxfString], { type: "application/dxf" });
        const url = URL.createObjectURL(blob);

        const a = document.createElement("a");
        a.href = url;
        a.download = `${this.filename}_${Date.now()}.dxf`;
        
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        console.log(`📥 [DXF EXPORT] Bestand succesvol gedownload als .dxf`);
    }
}
