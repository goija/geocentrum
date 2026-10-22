# Architectuurkaart — Beheercentrum & dossierstructuur

Conceptuele kaart van de dossierdomeinen, operationele beheerlaag en technische informatiestroom van VORTEX OS / GeoCentrum. De netwerkstroken volgen het aangeleverde vijflaagse model; componentnamen zijn afgestemd op de bestaande architectuurnotitie.

![geo_arch_diagram.png](Architectuurkaart%20%E2%80%94%20Beheercentrum%20&%20dossierstructu/geo_arch_diagram.png)

Architectuurkaart — Beheercentrum en dossierstructuur

## Dossierstructuur

1. **Project & organisatie** — Projectcharter; team, rollen & communicatie; RACI-matrix.
2. **Planning & voortgang** — Kalender & historielog; workload dossier; capaciteit en mijlpalen.
3. **Techniek & versies** — Git-status; actuele structuur; changelog/releases.
4. **Kwaliteit & compliance** — Risicoregister; AVG-verwerkingsregister; juridisch register.
5. **Systeem & beheer** — Operationeel procesdossier; Notion Beheercentrum en rapportage; Update Manager; Rekencentrum (geodetische rekenkern en Matrix Simulator).

## Technische informatiestroom

- **Applicatie:** dashboards, gebruikersdata en opdrachten.
- **Transport:** HTTP/REST en WebRTC; DTLS voor WebRTC-verkeer.
- **Netwerk:** routering en lokale DNS (BIND9).
- **Datalink:** frames en foutdetectie (header/trailer; conceptueel uit het aangeleverde model).
- **Fysiek:** bits via elektrische of draadloze transmissie op lokale hardware.

De dossierdomeinen zijn beheers- en bewijsdomeinen die de technische lagen doorsnijden; ze zijn niet één-op-één aan een netwerklaag gekoppeld. De actuele runtime-configuratie is niet vanuit Notion vastgesteld.

## Bronnen en projectlocatie

- [TECHNISCHE ARCHITECTUUR: VORTEX OS / GeoCentrum](https://app.notion.com/p/TECHNISCHE-ARCHITECTUUR-VORTEX-OS-GeoCentrum-3fd93a838a1980a3978fc1c01936aaa2?pvs=21)
- [**Actuele Datastructuur GeoCentrum**](https://app.notion.com/p/Actuele-Datastructuur-GeoCentrum-3fd93a838a19804d9193c9d507ca0190?pvs=21)
- Lokale projectmap volgens de aangeleverde context: `~/Bureaublad/geocentrum-main/geocentrum-main` (niet lokaal gecontroleerd).