/**
 * VORTEX OS v155.0 - MapLibre GL JS CustomLayerInterface voor 3D Globe
 * Rendert de 245,91° Mercurius-laserstraal (Fraunhofer D 589 nm) & geodetische knooppunten.
 */
class VortexLaserGlobeLayer {
  constructor() {
    this.id = 'vortex-laser-globe-layer';
    this.type = 'custom';
    this.renderingMode = '3d';
    this.shaderMap = new Map();
  }

  onAdd(map, gl) {
    this.map = map;
    this.gl = gl;

    const pNL   = maplibregl.MercatorCoordinate.fromLngLat({ lng: 5.2200,  lat: 52.2500 }); // Poolanker P (NL)
    const n2FR  = maplibregl.MercatorCoordinate.fromLngLat({ lng: 1.8500,  lat: 47.2500 }); // Dept. 41/18 Kern
    const d46   = maplibregl.MercatorCoordinate.fromLngLat({ lng: 1.6000,  lat: 44.6000 }); // Dept. 46 (Lot)
    const uExit = maplibregl.MercatorCoordinate.fromLngLat({ lng: -1.2500, lat: 46.2500 }); // Dept. 17/85 Biskaje
    const eEcl  = maplibregl.MercatorCoordinate.fromLngLat({ lng: -6.5000, lat: 43.5500 }); // Eclips Landfall Spanje

    const vertices = new Float32Array([
      pNL.x,   pNL.y,   1.00, 0.80, 0.20, 1.0,
      n2FR.x,  n2FR.y,  0.00, 0.90, 1.00, 1.0,
      d46.x,   d46.y,   0.95, 0.65, 0.15, 1.0,
      uExit.x, uExit.y, 0.00, 0.90, 1.00, 1.0,
      eEcl.x,  eEcl.y,  0.92, 0.28, 0.60, 1.0
    ]);

    this.vertexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
  }

  getShader(gl, shaderDescription) {
    if (this.shaderMap.has(shaderDescription.variantName)) {
      return this.shaderMap.get(shaderDescription.variantName);
    }

    const vertexSource = `#version 300 es
      ${shaderDescription.vertexShaderPrelude}
      ${shaderDescription.define}
      in vec2 a_pos;
      in vec4 a_color;
      out highp vec4 v_color;
      void main() {
          v_color = a_color;
          gl_Position = projectTile(a_pos);
          gl_PointSize = 8.0;
      }`;

    const fragmentSource = `#version 300 es
      precision highp float;
      in highp vec4 v_color;
      out vec4 fragColor;
      void main() {
          fragColor = v_color;
      }`;

    const vertexShader = gl.createShader(gl.VERTEX_SHADER);
    gl.shaderSource(vertexShader, vertexSource);
    gl.compileShader(vertexShader);

    const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    gl.shaderSource(fragmentShader, fragmentSource);
    gl.compileShader(fragmentShader);

    const program = gl.createProgram();
    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program);

    this.aPos = gl.getAttribLocation(program, 'a_pos');
    this.aColor = gl.getAttribLocation(program, 'a_color');
    this.shaderMap.set(shaderDescription.variantName, program);

    return program;
  }

  render(gl, args) {
    const program = this.getShader(gl, args.shaderData);
    gl.useProgram(program);

    gl.uniformMatrix4fv(gl.getUniformLocation(program, 'u_projection_fallback_matrix'), false, args.defaultProjectionData.fallbackMatrix);
    gl.uniformMatrix4fv(gl.getUniformLocation(program, 'u_projection_matrix'), false, args.defaultProjectionData.mainMatrix);
    gl.uniform4f(gl.getUniformLocation(program, 'u_projection_tile_mercator_coords'), ...args.defaultProjectionData.tileMercatorCoords);
    gl.uniform4f(gl.getUniformLocation(program, 'u_projection_clipping_plane'), ...args.defaultProjectionData.clippingPlane);
    gl.uniform1f(gl.getUniformLocation(program, 'u_projection_transition'), args.defaultProjectionData.projectionTransition);

    gl.bindBuffer(gl.ARRAY_BUFFER, this.vertexBuffer);

    gl.enableVertexAttribArray(this.aPos);
    gl.vertexAttribPointer(this.aPos, 2, gl.FLOAT, false, 24, 0);

    gl.enableVertexAttribArray(this.aColor);
    gl.vertexAttribPointer(this.aColor, 4, gl.FLOAT, false, 24, 8);

    gl.enable(gl.BLEND);
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);

    gl.drawArrays(gl.LINE_STRIP, 0, 5);
    gl.drawArrays(gl.POINTS, 0, 5);
  }

  onRemove(map, gl) {
    if (this.vertexBuffer) gl.deleteBuffer(this.vertexBuffer);
  }
}
