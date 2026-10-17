export const VORTEX_ASSETS_MANIFEST = {
  version: "158.1",
  timestamp: new Date().toISOString(),
  anchors: {
    poolanker_p: { name: 'Poolanker P (Laren / NL)', lat: 52.2500, lng: 5.2200, rdX: 141120, rdY: 473200 },
    scherpenisse: { name: 'Scherpenisse (Zeeland)', lat: 51.546389, lng: 4.103889, rdX: 65985.24, rdY: 396053.23 },
    tholen_stad: { name: 'Tholen Stad', lat: 51.533056, lng: 4.216111, rdX: 73745.01, rdY: 394438.89 }
  },
  vectors: {
    scherpenisse_tholen: {
      rdGridAzimuthDeg: 101.75,
      wgs84AzimuthDeg: 100.74,
      meridianConvergenceDeg: -1.01,
      distanceMeters: 7925.92,
      hexagonalAxesDeg: [101.75, 161.75, 221.75, 281.75, 341.75, 41.75]
    }
  },
  duogramCalibration: {
    index: { x: 0, y: 8 },
    azimuthDeg: 45.0,
    rhoCm: -8.20,
    nonius: -264,
    kingWenHex: 'KW #9 (110111)',
    attractor: "010101 (01)"
  }
};
