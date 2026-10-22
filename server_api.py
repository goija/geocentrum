import http.server
import socketserver
import json

PORT = 8080

class VortexHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/api/status") or self.path.startswith("/api/maan"):
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            response = {"status": "online", "system": "VORTEX OS", "port": PORT, "location": "Laren (Poolanker P)"}
            self.wfile.write(json.dumps(response).encode("utf-8"))
            return
        super().do_GET()

class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True

print(f"🌐 VORTEX OS Backend API gestart op http://127.0.0.1:{PORT}")
with ReusableTCPServer(("", PORT), VortexHandler) as httpd:
    httpd.serve_forever()
