const VortexDXFExporter = (() => {
  function generateDXF(refractionAngle = -3.80) {
    const baseVector = 245.91;
    const effectiveVector = baseVector + refractionAngle; // 242.11°
    const x0 = 155000.00, y0 = 463000.00, lengthMeters = 50000.00;
    const rad = (90 - effectiveVector) * (Math.PI / 180.0);
    const x1 = x0 + lengthMeters * Math.cos(rad);
    const y1 = y0 + lengthMeters * Math.sin(rad);

    return `0\nSECTION\n2\nHEADER\n9\n$INSUNITS\n70\n6\n0\nENDSEC\n0\nSECTION\n2\nENTITIES\n0\nPOINT\n8\nVORTEX_NODES\n10\n${x0.toFixed(2)}\n20\n${y0.toFixed(2)}\n30\n0.0\n0\nPOINT\n8\nVORTEX_NODES\n10\n${x1.toFixed(2)}\n20\n${y1.toFixed(2)}\n30\n0.0\n0\nLINE\n8\nVORTEX_245_91_REFRACTED\n10\n${x0.toFixed(2)}\n20\n${y0.toFixed(2)}\n30\n0.0\n11\n${x1.toFixed(2)}\n21\n${y1.toFixed(2)}\n31\n0.0\n0\nTEXT\n8\nVORTEX_ANNOTATIONS\n10\n${x0.toFixed(2)}\n20\n${(y0 - 500).toFixed(2)}\n30\n0.0\n40\n250.0\n1\nVORTEX RD OORSPRONG (155000, 463000)\n0\nTEXT\n8\nVORTEX_ANNOTATIONS\n10\n${((x0 + x1) / 2).toFixed(2)}\n20\n${((y0 + y1) / 2 + 500).toFixed(2)}\n30\n0.0\n40\n200.0\n1\nEFFECTIEVE VECTOR: ${effectiveVector.toFixed(2)} DEG (BASE: ${baseVector} + SNELL: ${refractionAngle.toFixed(2)} DEG)\n0\nENDSEC\n0\nEOF`;
  }

  function downloadDXF(filename = 'vortex_nodes_epsg28992.dxf', refractionAngle = -3.80) {
    const dxfContent = generateDXF(refractionAngle);
    const blob = new Blob([dxfContent], { type: 'application/dxf' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = filename;
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    URL.revokeObjectURL(url);
  }

  return { generateDXF, downloadDXF };
})();

if (typeof window !== 'undefined') window.VortexDXFExporter = VortexDXFExporter;
