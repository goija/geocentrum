# 🌐 Netwerk, DNS & WebRTC Defensie
**Componenten:** BIND9 (UDP 53), Matrix/Conduit (8448), WebRTC Data Channels

## 1. WebRTC DTLS Beveiliging
- P2P Data Channels zijn standaard versleuteld via **DTLS** bovenop SCTP.
- Lokale loopback- en integratietests draaien geïsoleerd in `./venv/bin/python3 test_webrtc_channel.py`.

## 2. DNS Soevereiniteit (BIND9)
- Lokale naamresolutie voorkomt DNS-lekkage naar externe resolvers.
