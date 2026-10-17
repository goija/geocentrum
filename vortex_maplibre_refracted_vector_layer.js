const VortexMapLibreRefractedLayer = (() => {
  function addRefractedVectorLayer(map) {
    if (!map) return;

    function setupLayers() {
      if (map.getSource('vortex-refracted-vector-src')) return;

      map.addSource('vortex-refracted-vector-src', {
        type: 'geojson',
        data: './vortex_refracted_vector.geojson'
      });

      map.addLayer({
        id: 'vortex-refracted-vector-line',
        type: 'line',
        source: 'vortex-refracted-vector-src',
        filter: ['==', ['geometry-type'], 'LineString'],
        layout: { 'line-join': 'round', 'line-cap': 'round' },
        paint: { 'line-color': '#ffcc00', 'line-width': 4, 'line-opacity': 0.9 }
      });

      map.addLayer({
        id: 'vortex-refracted-vector-nodes',
        type: 'circle',
        source: 'vortex-refracted-vector-src',
        filter: ['==', ['geometry-type'], 'Point'],
        paint: {
          'circle-radius': 7,
          'circle-color': '#00e5ff',
          'circle-stroke-width': 2,
          'circle-stroke-color': '#ffffff'
        }
      });
    }

    if (map.isStyleLoaded()) {
      setupLayers();
    } else {
      map.on('load', setupLayers);
    }
  }

  return { addRefractedVectorLayer };
})();

if (typeof window !== 'undefined') {
  window.VortexMapLibreRefractedLayer = VortexMapLibreRefractedLayer;
}
