import os
import sys
import json
import time
import math
from http.server import HTTPServer, SimpleHTTPRequestHandler
from urllib.parse import parse_qs, urlparse

class VortexAPIServer(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200, "ok")
        self.end_headers()

    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path
        query = parse_qs(parsed.query)

        # /api/refractie endpoint
        if path == '/api/refractie':
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            
            try:
                h = float(query.get('elevatie', [10])[0])
            except ValueError:
                h = 10.0

            # Saemundsson atmosferische refractie formule (boogminuten)
            if h > -1.0:
                r_arcmin = 1.02 / math.tan(math.radians(h + 10.3 / (h + 5.11)))
            else:
                r_arcmin = 0.0

            resp = {
                "status": "ok",
                "ware_elevatie_deg": h,
                "refractie_boogminuten": round(r_arcmin, 3),
                "schijnbare_elevatie_deg": round(h + (r_arcmin / 60.0), 4),
                "atmosferische_druk_hpa": 1013.25,
                "temperatuur_c": 15.0,
                "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ")
            }
            self.wfile.write(json.dumps(resp, indent=2).encode('utf-8'))
            return

        # /api/status endpoint
        if path in ['/api/status', '/api/telemetry']:
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            resp = {
                "status": "ok",
                "server": "VORTEX OS API Backend",
                "port": 8080,
                "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ")
            }
            self.wfile.write(json.dumps(resp, indent=2).encode('utf-8'))
            return

        # /api/maan endpoint
        if path.startswith('/api/maan'):
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            maan_data = {
                "object": "Maan (Luna)",
                "timestamp_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ"),
                "rechte_klimming_ra_deg": 191.20,
                "declinatie_dec_deg": 13.30,
                "azimut_deg": 303.23,
                "elevatie_deg": 10.0,
                "refractie_boogminuten": 5.41,
                "verlichting_percentage": 51.4
            }
            self.wfile.write(json.dumps(maan_data, indent=2).encode('utf-8'))
            return

        # /api/rd endpoint
        if path.startswith('/api/rd'):
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            rd_data = {
                "systeem": "Stelsel van de Rijksdriehoeksmeting (EPSG:28992)",
                "poolanker_p": {"x": 143652, "y": 473575, "lat": 52.2500, "lon": 5.2200}
            }
            self.wfile.write(json.dumps(rd_data, indent=2).encode('utf-8'))
            return

        return super().do_GET()

class ReusableHTTPServer(HTTPServer):
    allow_reuse_address = True

def run_server(port=8080):
    server_address = ('0.0.0.0', port)
    httpd = ReusableHTTPServer(server_address, VortexAPIServer)
    print(f"🌀 VORTEX OS API Server LIVE op http://localhost:{port}")
    httpd.serve_forever()

if __name__ == '__main__':
    port = 8080
    if len(sys.argv) > 1:
        try: port = int(sys.argv[1])
        except ValueError: pass
    run_server(port)
