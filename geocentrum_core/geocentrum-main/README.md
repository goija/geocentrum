# GeoCentrum / VORTEX OS - Master Documentatie & Beheercentrum

## Overzicht
GeoCentrum / VORTEX OS is een soeverein, decentraal en lokaal gehost platform voor geospatiale analyse, cartografie en netwerkcommunicatie. Het systeem is ontworpen om volledig onafhankelijk van externe cloud-providers te draaien op bare-metal hardware, waarbij zware wiskundige modellen gecombineerd worden met veilige communicatieprotocollen.

---

## 1. Technische Specificaties (Tech Stack)
Het GeoCentrum is gebouwd zonder logge frameworks, met een focus op command-line efficiëntie, performance en lokale data-soevereiniteit.

### Hardware & Besturingssysteem
* **Target Hardware:** Raspberry Pi, Tiny Server, bare-metal x86_64/ARM64.
* **Besturingssysteem:** Debian Bookworm (12.x) of Buildroot voor embedded systemen.

### Back-end, Logica & Rekenkernen
* **Rust:** Voor veilige, snelle netwerktools (zoals lokale RSS/Podcast servers) - via `cargo`.
* **C++ & Go:** Voor snelle CLI-tools en directe hardware-aansturing.
* **Python (3.11+):** Scripting en GIS data-analyse (`geopandas`, `matplotlib`).
* **R:** Voor iteratieve matrix-berekeningen, modulo-rekenen en Tzolk'in simulaties.
* **Scilab:** Voor systeemtheoretische simulaties en chaos-attractoren.
* **OpenSCAD:** Voor 3D-cartografische projecties en mechanische modellen.

### Front-end, GIS & Dashboards
* **Core:** HTML5, CSS3, native JavaScript (ES6+). Geen Node.js vereist.
* **Mapping & Cartografie:** MapLibre GL JS, Leaflet.js, Mapbox.
* **Datastructuren:** GeoJSON voor vectordata, DXF voor CAD-export.

### Netwerk, Communicatie & Beveiliging
* **DNS & Routering:** BIND9 voor lokaal netwerkbeheer.
* **Communicatie:** Matrix Protocol (Conduit/Synapse), ActivityPub, WebRTC.
* **Encryptie:** One-Time Pad (OTP) algoritme (FinalCrypt) voor data-at-rest, DTLS in-transit.
* **Versiebeheer:** Lokale Forgejo instantie & Git.

---

## 2. Mappen- en Bestandenstructuur
De repository is strak ingedeeld om logica (JS), data (GeoJSON) en weergave (HTML) te scheiden:

```text
geocentrum-main/
├── assets/                  # Statische bestanden
│   ├── images/              # Afbeeldingen (.png, .jpg)
│   └── scripts/             # Manifest bestanden (assets_manifest.js)
├── beheercentrum/           # Automatische Git pre-commit logs
├── cockpittools/            # Dashboards en weergaves
│   ├── css/                 # Cascading Style Sheets (.css)
│   ├── data/                # Ruimtelijke en wiskundige data (.geojson, .dxf)
│   ├── js/                  # Kernlogica, rekenmodules en kaartlagen (.js)
│   ├── mapglobe.html        # Hoofdapplicatie (Globe weergave)
│   ├── rekenmachine.html    # Geodetische calculator
│   └── ...                  # Overige HTML weergaves
├── docs/
│   └── compliance/          # Juridisch register (JSON) en beleid
├── pdf/                     # Geëxporteerde rapportages en handleidingen
├── scripts/                 # Bash automatiseringsscripts (zoals start_vortex.sh)
└── systeemdiagnose/
    ├── logs/                # Audit trails en error logs
    └── update/              # Systeemupdate scripts en pagina's
```

---

## 3. Lokale Installatie (Bare-Metal)
Volg deze stappen om het platform vanaf nul op een Debian/Linux machine te installeren.

**1. Systeemvereisten installeren:**
```bash
sudo apt-get update
sudo apt-get install -y git curl python3 python3-pip r-base scilab openscad bind9
```

**2. Rust (Cargo) installeren:**
```bash
curl --proto '=https' --tlsv1.2 -sSf [https://sh.rustup.rs](https://sh.rustup.rs) | sh
```

**3. Repository klonen (indien nieuw systeem):**
```bash
git clone [https://github.com/JOUW_GEBRUIKERSNAAM/geocentrum-main.git](https://github.com/JOUW_GEBRUIKERSNAAM/geocentrum-main.git)
cd geocentrum-main
```

---

## 4. Lokaal Opstarten
Om de VORTEX OS dashboards correct te laten werken met ES6-modules en lokale GeoJSON-data, is een lokale webserver vereist (CORS-beveiliging blokkeert directe `file://` toegang).

### Optie A: Automatisch opstarten (Aanbevolen)
We hebben een start-script gegenereerd. Voer dit uit in de hoofdmap om de server te starten én direct je browser te openen:
```bash
./start_vortex.sh
```

### Optie B: Handmatig opstarten
1. Start een Python webserver in de hoofdmap:
```bash
python3 -m http.server 8000
```
2. Open je webbrowser en ga naar de gewenste module, bijvoorbeeld:
`http://localhost:8000/cockpittools/mapglobe.html`

---

## 5. Kernmodules & Wetenschappelijke Modellen
* **Cartografie & Geodesie:** Digitale kalibratie van de A. Ott planimeter (Nr. 573), sferische geometrie voor grote-cirkel paden, en Saemundsson atmosferische refractie-modellen.
* **Discrete Wiskunde:** Analyse van de Collatz-conjectuur ($3n+1$), Galois LFSR shift registers, en $B(2,6)$ de Bruijn grafen.
* **Hogere Dimensies:** $3\times3\times3$ magische kubussen, Rodrigues rotatiematrices en 6D hyperkubussen.
* **Synchronometrie:** Maya Tzolk'in kalender simulaties en modulo 13/20 radiale projecties (R-scripts).

---

## 6. Compliance & Beheer
* **AVG/GDPR:** Data Minimalisatie, lokaal gehost verwerkingsregister, volledige data-soevereiniteit.
* **ISO 27001:** RBAC-toegangscontrole, OTP encryptie, actieve audit-logging (`/systeemdiagnose/logs/`).
* **Governance:** Lifecycle beheer (DRAFT → IN_REVIEW → APPROVED → LIVE → DEPRECATED → ARCHIVED).

---

## 7. Centrale Interface (Web Dashboard)
Het GeoCentrum beschikt over een centraal, surrealistisch (Magritte-geïnspireerd) webportaal (`index.html`). Dit portaal fungeert als het visuele hoofdmenu en verbindt alle losse modules, viewports en rekenkernen via één overzichtelijke interface.

* **Starten van de interface:** Gebruik het commando `./scripts/start_vortex.sh`. Dit start de beveiligde lokale Python-server op de achtergrond en opent direct het portaal in je standaard browser.
* **Navigatie:** Vanuit het hoofdmenu (op `http://localhost:8000/`) heb je met één klik toegang tot de Cartografie (Mapglobe), het Geodetisch Rekencentrum, en de documentatie (Systeemdiagnose & Compliance).
