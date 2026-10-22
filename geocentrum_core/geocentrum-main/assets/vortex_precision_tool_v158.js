/**
 * VORTEX OS v158.0 - Geodetische & Optische Precision Tooling
 * Inclusief Hinge Duogram Calibration Point (0, 8) & King Wen #9 -> N² Attractor 010101
 * Scherpenisse -> Tholen Vector (101.75° RD Grid Azimut) & Cellarius Grid Rotatie
 */

export const VORTEX_BIPOLAR_HUD = {
  version: '158.0',
  
  anchors: {
    poolanker_p: { name: 'Poolanker P (Laren / NL)', lat: 52.2500, lng: 5.2200, rdX: 141120, rdY: 473200 },
    scherpenisse: { name: 'Scherpenisse (Zeeland)', lat: 51.546389, lng: 4.103889, rdX: 65985.24, rdY: 396053.23 },
    tholen_stad: { name: 'Tholen Stad', lat: 51.533056, lng: 4.216111, rdX: 73745.01, rdY: 394438.89 },
    taurus_aldebaran: { name: 'Aldebaran / Taurus Anker', azimuth: 51.40, elevation: -3.7, constellation: 'Taurus' },
    mercurius_eclips: { name: 'Mercurius / Eclips Corridor', azimuth: 245.91, elevation: -4.2, constellation: 'Libra' },
    n2_core: { name: 'N² Kern (Dept. 41/18 Bourges)', lat: 47.2500, lng: 1.8500 },
    exit_biskaje: { name: 'Uittreedknoop Dept. 17/85 (Biskaje)', lat: 46.2500, lng: -1.2500 },
    eclips_landfall: { name: 'Eclips Landfall 12-Aug-2026 (Asturië)', lat: 43.5500, lng: -6.5000 }
  },

  duogramCalibration: {
    thetaDeg: 45.00,
    rhoCm: -8.20,
    noniusValue: -264,
    matrixIndex: { x: 0, y: 8 },
    kingWenNumber: 9,
    kingWenBinary: '110111',
    n2Attractor: '010101 (01)',
    jacobianDet: -1.00,
    originInversionActive: true
  },

  tholenVector: {
    wgs84ForwardAzimuthDeg: 100.74,
    rdGridAzimuthDeg: 101.75,
    meridianConvergenceDeg: -1.01,
    ellipsoidalDistanceM: 7926.05,
    rdGridDistanceM: 7925.92,
    cellariusGridRotationOffsetDeg: 101.75,
    hexagonalAxesDeg: [101.75, 161.75, 221.75, 281.75, 341.75, 41.75]
  },

  constants: {
    laserWavelengthNm: 589.0,
    opticalPathLength_cm: 16.675,
    nAir: 1.0003,
    nSea: 1.3330,
    ottArmR_cm: 15.00,
    ottArmL_cm: 16.67,
    meetcirkelArea_cm2: 363.00,
    jacobianDet: -1.00
  },

  calculateDuogramPosition(thetaDeg, noniusVal) {
    const noniusNorm = Math.abs(noniusVal) / 26214.0;
    const xIdx = Math.floor(noniusNorm * 64);
    const yIdx = Math.floor(((thetaDeg % 360) / 360.0) * 64);

    return {
      theta: thetaDeg,
      nonius: noniusVal,
      xIndex: xIdx,
      yIndex: yIdx,
      matrixCoords: `(${xIdx}, ${yIdx})`,
      kingWenHex: xIdx === 0 && yIdx === 8 ? 'KW #9 (110111)' : 'DYNAMIC',
      attractor: '010101 (01)'
    };
  },

  calculateTholenVectorTransformation() {
    const rdAz = this.tholenVector.rdGridAzimuthDeg;
    const gamma = this.tholenVector.meridianConvergenceDeg;
    const wgsAz = rdAz + gamma;
    
    return {
      vectorName: 'Scherpenisse -> Tholen Stad',
      rdGridAzimuth: rdAz,
      meridianConvergence: gamma,
      correctedWgs84Azimuth: parseFloat(wgsAz.toFixed(2)),
      cellariusRotationOffset: rdAz,
      hexagonalAxes: this.tholenVector.hexagonalAxesDeg,
      alignmentStatus: 'LOCKED_TO_POLDER_GRID'
    };
  }
};
