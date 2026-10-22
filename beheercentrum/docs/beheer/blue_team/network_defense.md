# 🌐 Netwerk, DNS & WebRTC DataChannel Defensie
**Architectuur:** BIND9 (UDP 53) | Matrix/Conduit (8448) | WebRTC P2P DataChannels

## 1. Beveiligd Verzenden & Ontvangen met DataChannels
- Alle WebRTC DataChannels gebruiken verplichte **DTLS** (Datagram Transport Layer Security) encryptie over SCTP.
- Berichten gaan peer-to-peer zonder tussenkomst van externe cloud-opslag.

## 2. DNS & Poortbeheer
- BIND9 verzorgt lokale DNS-resolutie.
- Onderdruk valse 404-ruis (zoals `/favicon.ico`) via `204 No Content` en inline SVG-headers.
