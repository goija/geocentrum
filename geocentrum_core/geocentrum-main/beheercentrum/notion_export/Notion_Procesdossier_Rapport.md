# 📊 VORTEX OS - Integraal Procesdossier Rapport

> **Datum:** 18 oktober 2026
> **Beheerder:** M.J.M.M. Goijarts-Bout
> **Domein:** Soevereine netwerkarchitectuur, GIS & Geodesie
> **Status:** 🟢 Operationeel & Stabiel

---

## 1. 🚀 Executive Summary
Het VORTEX OS (GeoCentrum) is momenteel volledig lokaal en soeverein operationeel op bare-metal hardware. De architectuur is met succes gescheiden van afhankelijkheden van externe cloud-providers (zoals Vercel), waarbij de focus ligt op lokale executie, cryptografische veiligheid (OTP / DTLS) en robuuste achtergronddiensten via `systemd`.

---

## 2. 👥 Rollen, Governance & Architectuur
Binnen het VORTEX OS / GeoCentrum project zijn de verantwoordelijkheden en rollen strak gedefinieerd volgens het RACI-principe, met een sterke nadruk op data-soevereiniteit en eigen beheer:

* **Projectmanager & Lead Architect (M.J.M.M. Goijarts-Bout):** Eindverantwoordelijk voor de strategische visie, de geodetische en mathematische rekenkernen (Rust, R, Scilab), de systeeminrichting van de Tiny Server, en de integratie van de cartografische viewports (MapLibre / Laren Global Anchor).
* **Core Developer & DevOps:** Verantwoordelijk voor de bare-metal orchestratie, systemd achtergronddiensten (zoals de Rust Axum podcast-server op poort 8081), de Python REST-API op poort 8080, en de geautomatiseerde Git-synchronisatiehooks.
* **Compliance & Kwaliteitsbeheer:** Bewaking van het AVG-verwerkingsregister, ISO 27001-beveiligingsmaatregelen (FinalCrypt OTP encryptie) en WCAG 2.2 toegankelijkheid.

---

## 3. 🖥️ Huidige Systeemstatus & Modules

| Module / Component | Technologie | Lokale Poort | Status |
| :--- | :--- | :--- | :--- |
| **Systeem Index Dashboard** | HTML/JS/CSS | `8000` | ✅ Actief (Python HTTP) |
| **Geodetische API Backend** | Python 3.11 | `8080` | ✅ Actief (ReusableTCPServer) |
| **Podcast RSS Server** | Rust (Axum) | `8081` | ✅ Actief (Systemd Service) |
| **GIS / Mapglobe** | MapLibre GL JS | `8000` | ✅ Actief (Laren Anchor) |
| **Wekan (Kanban)** | Node.js / Meteor | `8080` | ⚠️ Gestopt / Conflicteert niet meer |

---

## 4. ⏱️ Recente Workload & Ontwikkelingen (Sessie 18 Okt)
1. **API Stabilisatie:** De `Address already in use` (Errno 98) conflicten op poort 8080 zijn opgelost door het beëindigen van het Node.js proces en het implementeren van `allow_reuse_address = True`.
2. **Podcast RSS Server:** 
   - Volledig losgekoppeld van Vercel.
   - Herschreven met robuuste bestandsnaam-naar-titel parsing (voorkomt id3 compileerfouten).
   - Succesvol gemigreerd naar poort **8081**.
   - Draait nu als stabiele achtergronddienst via `/etc/systemd/system/podcast-rss.service`.
3. **Dashboard Integratie:** Archieven, PDF-handleidingen en de live RSS-feed zijn geïndexeerd in de navigatie van de hoofd-cockpit.

---

## 5. 🛡️ Compliance Check
- [x] **AVG / GDPR:** Lokaal verwerkingsregister actief. Dataminimalisatie toegepast (geen cloud-sync).
- [x] **ISO 27001:** Audit-logging aan, bare-metal P2P netwerk via Matrix/Conduit.
- [x] **Toegankelijkheid (WCAG 2.2):** Dashboards bedienbaar en voorzien van hoog-contrast UI.

---
*Dit rapport is automatisch gegenereerd vanuit het VORTEX Beheercentrum.*
