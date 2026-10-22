# 🌐 Netwerk, DNS & WebRTC DataChannel Defensie
**Architectuur:** BIND9 (`UDP 53`) | Python API (`8000`) | Rust RSS (`8081`) | Web (`8080`)

## 1. WebRTC DataChannels (DTLS over SCTP)
- Verkeer over WebRTC DataChannels is standaard end-to-end versleuteld via **DTLS**.
- Geen centrale tussenopslag; verificatie verloopt via zowel de browser-loopback als `./webrtc_test_runner.sh`.

## 2. Log-Hygiëne
- Valse 404-meldingen (zoals `/favicon.ico`) zijn geëlimineerd met inline SVG-data-URI's zodat verkeerslogs zuiver blijven.
