#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
VORTEX OS — Master API Server & Rekencentrum Backend
Gecorrigeerde en uitgebreide versie met /api/maan, /api/rd, /api/refractie en /api/planimeter.
"""
import http.server
import socketserver
import json
import urllib.parse
import math
import sys
import os

PORT = 8080
if len(sys.argv) > 1:
    try:
        PORT = int(sys.argv[1])
    except ValueError:
        pass

class ReusableHTTPServer(socketserver.TCPServer):
    allow_reuse_address = True

class VortexAPIServer(http.server.BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

    def do_GET(self):
        parsed_path = urllib.parse.urlparse(self.path)
        path = parsed_path.path

        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.end_headers()

        response_data = {}

        if path == "/api/health" or path == "/":
            response_data = {
                "status": "online",
                "system": "VORTEX OS Rekencentrum",
                "port": PORT,
                "version": "v28.6-stable"
            }
        elif path == "/api/maan" or path == "/maan":
            response_data = {
                "success": True,
                "moon_phase": "Waxing Gibbous",
                "illumination": "84.2%",
                "azimuth": 110.10,
                "elevation": 58.67,
                "rise": "16:34",
                "set": "01:08"
            }
        elif path == "/api/rd" or path == "/rd":
            response_data = {
                "success": True,
                "system": "Rijksdriehoekstelsel (RD)",
                "origin": "Amersfoort",
                "X_range": [0, 300000],
                "Y_range": [300000, 620000]
            }
        else:
            response_data = {"error": "Endpoint niet gevonden", "path": path}

        self.wfile.write(json.dumps(response_data, indent=2).encode('utf-8'))

    def do_POST(self):
        parsed_path = urllib.parse.urlparse(self.path)
        path = parsed_path.path
        
        content_length = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(content_length).decode('utf-8')
        
        try:
            data = json.loads(body) if body else {}
        except json.JSONDecodeError:
            data = {}

        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.end_headers()

        response_data = {}

        if path == "/api/refractie" or path == "/refractie":
            try:
                elev = float(data.get('elevatie', data.get('elev', 10.0)))
                safe_elev = elev if elev > -5 else -4.9
                refractie_arcmin = 1.02 / math.tan(math.radians(safe_elev + 10.3 / (safe_elev + 5.11)))
                refractie_deg = refractie_arcmin / 60.0
                schijnbare_elev = elev + refractie_deg

                response_data = {
                    "success": True,
                    "ware_elevatie": elev,
                    "refractie_graden": round(refractie_deg, 4),
                    "schijnbare_elevatie": round(schijnbare_elev, 4),
                    "correctie_arcmin": round(refractie_arcmin, 2)
                }
            except Exception as e:
                response_data = {"success": False, "error": str(e)}

        elif path == "/api/planimeter" or path == "/planimeter":
            try:
                start = float(data.get('start', 0.0))
                eind = float(data.get('eind', 0.0))
                factor = float(data.get('factor', 10.0))
                oppervlakte = abs(eind - start) * factor
                response_data = {
                    "success": True,
                    "start": start,
                    "eind": eind,
                    "factor": factor,
                    "oppervlakte_m2": round(oppervlakte, 2)
                }
            except Exception as e:
                response_data = {"success": False, "error": str(e)}
        else:
            response_data = {"success": False, "error": "Onbekende API POST route", "path": path}

        self.wfile.write(json.dumps(response_data, indent=2).encode('utf-8'))

def run_server():
    server_address = ('0.0.0.0', PORT)
    try:
        httpd = ReusableHTTPServer(server_address, VortexAPIServer)
        print("======================================================================")
        print(f"🌀 VORTEX OS API Server Actief op Poort {PORT} (0.0.0.0:{PORT})")
        print(f"   • API Health:  http://localhost:{PORT}/api/health")
        print(f"   • API Maan:    http://localhost:{PORT}/api/maan")
        print(f"   • API RD:      http://localhost:{PORT}/api/rd")
        print(f"   • Refractie:   http://localhost:{PORT}/api/refractie (POST)")
        print(f"   • Planimeter:  http://localhost:{PORT}/api/planimeter (POST)")
        print("======================================================================")
        sys.stdout.flush()
        httpd.serve_forever()
    except Exception as e:
        print(f"❌ Fout bij starten server op poort {PORT}: {e}")
        sys.exit(1)

if __name__ == '__main__':
    run_server()