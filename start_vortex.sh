#!/bin/bash
# VORTEX OS - Master Systeem Startscript

BASE_DIR="/home/ontwerp/VORTEX_OS"
GEO_DIR="$BASE_DIR/geocentrum_core/geocentrum-main"
POD_DIR="$BASE_DIR/podcast_server"

echo "[1/4] Netwerkpoorten opschonen..."
sudo fuser -k 8000/tcp 8080/tcp 8081/tcp 2>/dev/null
sleep 2

echo "[2/4] Podcast RSS Server (Rust) starten..."
cd "$POD_DIR" && cargo run &
sleep 3

echo "[3/4] Python API Backend starten..."
cd "$GEO_DIR" && python3 server_api.py &
sleep 2

echo "[4/4] Statische Webserver starten..."
cd "$GEO_DIR" && python3 -m http.server 8080 &
sleep 2

if command -v xdg-open &> /dev/null; then
xdg-open "http://127.0.0.1:8080"
fi
wait
