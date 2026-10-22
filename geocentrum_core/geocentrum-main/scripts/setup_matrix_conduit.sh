#!/bin/bash
set +H

echo "🚀 VORTEX OS - Matrix/Conduit Signaling Server Setup..."

# Maak een dedicated map aan voor de Matrix server
mkdir -p matrix_server/data
cd matrix_server

echo "⚙️ conduit.toml configuratiebestand genereren..."
cat << 'TOML_EOF' > conduit.toml
[global]
# Server instellingen
server_name = "vortex.local"
database_backend = "sqlite"
database_path = "/var/lib/matrix-conduit/"
port = 6167
max_request_size = 20_000_000

# Soevereine modus: geen externe registraties of federatie
allow_registration = false
allow_federation = false
allow_check_for_updates = false
trusted_servers = ["vortex.local"]

# WebRTC TURN/STUN configuratie (tbv VORTEX P2P Viewports)
turn_uris = [
    "turn:turn.vortex.local:3478?transport=udp", 
    "turn:turn.vortex.local:3478?transport=tcp"
]
turn_secret = "vortex_webrtc_p2p_secure_key"
TOML_EOF

echo "🐳 docker-compose.yml genereren..."
cat << 'DOCKER_EOF' > docker-compose.yml
version: '3.8'
services:
  conduit:
    image: matrixconduit/matrix-conduit:latest
    container_name: vortex_matrix_conduit
    restart: unless-stopped
    ports:
      - "6167:6167"
    volumes:
      - ./conduit.toml:/srv/conduit/conduit.toml
      - ./data:/var/lib/matrix-conduit/
    environment:
      - CONDUIT_CONFIG=/srv/conduit/conduit.toml
DOCKER_EOF

echo "✅ Matrix/Conduit infrastructuur succesvol klaargezet in de map 'matrix_server/'."
echo "💡 Typ 'cd matrix_server && docker-compose up -d' om de signaling server live te brengen."
