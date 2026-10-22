import http.server
import socketserver
import json

PORT = 8000

class VortexHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith("/api/status"):
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            response = {
                "status": "online", 
                "system": "VORTEX OS", 
                "location": "Laren (Poolanker P)",
                "target": "Maan"
            }
            self.wfile.write(json.dumps(response).encode("utf-8"))
            return
        super().do_GET()

# Zorg ervoor dat de poort direct hergebruikt kan worden na een herstart
class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True

Handler = VortexHandler
with ReusableTCPServer(("", PORT), Handler) as httpd:
    print(f"VORTEX OS Server gestart op http://127.0.0.1:{PORT}")
    httpd.serve_forever()
