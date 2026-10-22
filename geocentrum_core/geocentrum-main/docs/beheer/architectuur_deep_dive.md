# 🛠️ Deep Dive: De Architectuur, Technologische Stack en Open Standaarden van VORTEX OS

VORTEX OS en het GeoCentrum vormen samen een lokaal gehost, soeverein besturingssysteem en rekenplatform. De fundamentele ontwerpfilosofie: **Zero-Cloud**. Geen afhankelijkheid van Big Tech of externe datacenters. Om dit te bereiken op bare-metal hardware (zoals Debian Bookworm, Raspberry Pi, en Tiny Servers), is het systeem fundamenteel opgebouwd uit open-source technologieën en strikte internetstandaarden.

In dit dossier ontleden we de technologische stack over de 5 OSI-geïnspireerde lagen en koppelen we de gebruikte technieken aan de formele documentatie van de W3C (World Wide Web Consortium) en de IETF (Internet Engineering Task Force).

---

## 1. Laag 5: Applicatie & Frontend (Visualisatie & GIS)
De bovenste laag is verantwoordelijk voor de interactie en de zware geospatiale rendering (zoals 3D-globes en kadastrale DXF-parsing). Omdat alles lokaal draait (poort 8000), mag de client geen externe API's nodig hebben om te functioneren.

*   **HTML5 & CSS3:** De basis van de Native Viewports. Volledig conform de W3C HTML5 Specification en W3C CSS Snapshots. Door standaard DOM-manipulatie te gebruiken in plaats van zware framework-abstracties, blijft de footprint minimaal.
*   **Native JavaScript (ES6+):** Geschreven in pure ECMAScript (formeel ECMA-262). Geen afhankelijkheid van externe cloud-compilers; de code draait direct in de lokale browser-engine.
*   **WebAssembly (WASM):** Cruciaal voor het GeoCentrum. Om de zware berekeningen uit C++ en Rust naar de browser te brengen zonder prestatieverlies, wordt de `vortex_wasm_bridge.js` gebruikt. Dit volgt strikt de W3C WebAssembly Core Specification.
*   **MapLibre GL JS:** Een open-source GIS-bibliotheek die wordt gebruikt voor de Mapglobe. Het verwerkt lokaal gehoste vectortegeIs op basis van open cartografische standaarden, zonder data naar externe servers te sturen.

## 2. Laag 4: Transport & P2P-Communicatie
Dit is de laag waar VORTEX OS zijn decentrale kracht toont. Communicatie verloopt via HTTP/REST voor lokale bevragingen, en via WebRTC voor peer-to-peer (P2P) verbindingen.

*   **Python 3.11+ REST API (Poort 8080 & 8081):** De `server_api.py` levert data aan de frontend via formele HTTP-protocollen. Dit is geïmplementeerd conform IETF RFC 9110 (HTTP Semantics) en RFC 9112 (HTTP/1.1). REST (Representational State Transfer) garandeert een stateless verbinding voor de rekenkernen en de Tijdscapsule API.
*   **WebRTC (Web Real-Time Communication):** Voor gecontroleerde datastromen tússen systemen, zonder tussenkomst van een cloud-server. VORTEX OS implementeert dit via twee kanten:
    *   De API-kant volgt de W3C WebRTC API standaard.
    *   De netwerkkant volgt de IETF RTCWEB standaarden, waaronder IETF RFC 8825 (WebRTC Overview) en RFC 8827 (WebRTC Security Architecture).
*   **DTLS (Datagram Transport Layer Security):** Al het WebRTC-verkeer wordt in-transit versleuteld. VORTEX hanteert hiervoor IETF RFC 9147 (DTLS 1.3) of diens voorganger RFC 6347 (DTLS 1.2). Dit garandeert end-to-end encryptie zonder certificaat-autoriteiten van buitenaf.

## 3. Laag 3: Netwerk & Routering (Lokale Isolatie)
Om écht soeverein te zijn, regelt het systeem zijn eigen domeinresolutie en decentrale berichtgeving.

*   **BIND9 (Lokale DNS):** Alle domeinresolutie (zoals het verwerken van `vortex.local`) gebeurt lokaal via BIND9. Dit is de de-facto referentie-implementatie van het DNS-systeem en volgt exact IETF RFC 1034 (DNS Concepts and Facilities) en RFC 1035 (DNS Implementation and Specification). Geen *leaks* naar Google DNS (8.8.8.8) of Cloudflare (1.1.1.1).
*   **Matrix / Conduit Server:** Voor communicatiesignaling gebruikt het systeem Matrix (via de lichtgewicht Conduit implementatie in Rust). Het Matrix-protocol is een open standaard voor decentrale communicatie en federatie. Hoewel het beheerd wordt door de Matrix.org Foundation, werkt de architectuur vergelijkbaar met IETF-standaarden voor SMTP (e-mail) via open en gedistribueerde *Directed Acyclic Graphs* (DAG).

## 4. Laag 2: Security, Encryptie & Datalink
De beveiligingslaag is meedogenloos ontworpen voor lokale data-integriteit.

*   **FinalCrypt (One-Time Pad - OTP):** Bestanden (at-rest) in VORTEX OS worden versleuteld met FinalCrypt. Dit algoritme is gebaseerd op het One-Time Pad principe. Volgens de informatietheorie van Claude Shannon is OTP het enige cryptografische systeem dat wiskundig bewezen onbreekbaar is, mits de sleutel (pad) even lang is als de data, willekeurig is en slechts één keer wordt gebruikt.
*   **DTLS & RBAC:** Zoals in Laag 4 genoemd, beveiligt DTLS de in-transit data. Toegangsbeheer (Role-Based Access Control) voorkomt dat ongeautoriseerde processen op Laag 2 en hoger data kunnen benaderen.

## 5. Laag 1 & Rekenkernen: Fysiek en Bare-Metal OS
De fysieke en rekenlaag draait op 'bare-metal', direct op de hardware.

*   **OS & Hardware:** Debian Bookworm (Linux) fungeert als het robuuste, open-source besturingssysteem voor x86_64 of ARM64 (Raspberry Pi, Tiny Server) platformen. Geen virtuele machines in een AWS of Azure cloud, maar fysieke controle.
*   **Geodetisch Rekencentrum (De Talen):** De rekenmodules (die Saemundsson-refractie, A. Ott planimetrie, Galois LFSR wiskunde, en Tzolk'in-simulaties uitvoeren) zijn geschreven in low-level en data-talen:
    *   **Rust:** Memory-safe, concurrency-gericht. Wordt gecompileerd naar binaire code of WebAssembly.
    *   **R & Scilab:** Gespecialiseerd in statistische berekeningen, matrix-algebra en kalendermodules.
    *   **C++:** Voor de legacy wiskundige rekenkernen, direct aangestuurd zonder middleware overhead.

---

### Conclusie: Waarom Open Standaarden Essentieel zijn voor Soevereiniteit
Door VORTEX OS en het GeoCentrum te bouwen op IETF en W3C standaarden — zoals WebRTC, BIND9 DNS en HTTP/REST — in combinatie met bare-metal berekeningen (Rust/C++) en lokaal archiefbeheer (Tijdscapsule snapshots), bereikt het systeem ware onafhankelijkheid.

Het voorkomt 'Vendor Lock-in' (je zit niet vast aan clouddiensten wiens protocollen plots wijzigen), waarborgt de privacy door de Zero-Cloud policy (de data verlaat nooit fysiek het pand, conform Art. 30 AVG), en creëert een technologische tijdscapsule die tientallen jaren onafhankelijk kan blijven functioneren, los van het moderne cloud-internet.

> **Opmerking betreffende publicatie:** Deze technische ontleding is ontdaan van operationele configuraties zoals specifieke endpoint-paden, serverlogs en netwerksleutels om de integriteit van het operationele GeoCentrum te waarborgen.
