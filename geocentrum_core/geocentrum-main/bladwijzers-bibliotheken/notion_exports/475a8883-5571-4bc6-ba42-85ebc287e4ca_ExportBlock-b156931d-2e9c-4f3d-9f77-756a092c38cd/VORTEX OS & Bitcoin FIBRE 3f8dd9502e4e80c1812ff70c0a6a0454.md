# VORTEX OS & Bitcoin FIBRE

[https://penrose-ten.vercel.app/links.html](https://penrose-ten.vercel.app/links.html)

[VORTEX OS: Link Dashboard](https://penrose-ten.vercel.app/links.html)

<aside>
🧭

Deze pagina bundelt twee onderdelen uit de bestaande notities: de werking en propagatie van Bitcoin FIBRE, en het ontwerp van het VORTEX OS-linkdashboard.

- **Deel A:** TCP tegenover FIBRE (UDP/FEC)
- **Deel B:** dashboarddoel, interface- en kleurensysteem, en bestaande projectlinks
</aside>

[Grok](https://grok.com/c/1dec985a-afa2-47f0-9a16-02563b0da4b2?rid=dd4872f8-1de6-41c0-b697-83f322018cec)

## A. Bitcoin-blokpropagatie: TCP en FIBRE

### Kernidee

De oorspronkelijke notitie vergelijkt de reguliere Bitcoin-peerverbindingen via TCP met FIBRE, een overlay die UDP en Forward Error Correction (FEC) gebruikt. Het beoogde voordeel van FIBRE is dat verloren datapakketten in geschikte omstandigheden kunnen worden hersteld uit redundante FEC-data, zonder eerst op een TCP-hertransmissie te wachten.

> De latencycijfers hieronder zijn overgenomen uit de oorspronkelijke notitie en niet onafhankelijk geverifieerd. Werkelijke propagatietijd hangt onder meer af van netwerkroute, afstand, pakketverlies, nodeconfiguratie en beschikbare transactiedata.
> 

### Vergelijking

| Kenmerk | Regulier Bitcoin-peer-netwerk | FIBRE-overlay |
| --- | --- | --- |
| Transport | TCP; de oorspronkelijke notitie noemt poort 8333 | UDP via gespecialiseerde poorten |
| Effect van pakketverlies | TCP levert een geordende stroom; verlies kan de aflevering van latere data ophouden totdat ontbrekende data is hersteld (head-of-line blocking) | FEC-data kan ontbrekende gegevens herstellen zodra genoeg redundante data beschikbaar is |
| Blokoverdracht | Peercommunicatie en herstel van ontbrekende data kunnen extra rondreizen vragen | Gericht op snelle, grotendeels eenrichtingsgerichte verspreiding van blokdata |
| Compacte blokken | BIP 152; in de oorspronkelijke vergelijking de low-bandwidth-modus | BIP 152; in de oorspronkelijke vergelijking de high-bandwidth-modus |
| Latency-indicatie uit de notitie | Vaak meerdere seconden | 100–300 ms wereldwijd |
| Beoogd doel | Betrouwbare, brede peer-to-peer-connectiviteit | Blokken sneller verspreiden en het risico op stale blocks beperken |

### Hoe pakketverlies wordt opgevangen

**Reguliere TCP-route**

1. De verzender stuurt blokdata.
2. Als data onderweg ontbreekt, kan de geordende TCP-stroom wachten op herstel van dat ontbrekende deel.
3. De ontvanger kan de data pas volledig verwerken wanneer de ontbrekende bytes zijn aangekomen.
4. De extra vertraging varieert met de route, round-trip time en het pakketverlies.

**FIBRE-route met UDP en Wirehair FEC**

1. De verzender verspreidt compacte blokdata samen met redundante FEC-data.
2. Sommige UDP-pakketten kunnen verloren gaan.
3. De ontvanger gebruikt de beschikbare redundantie om ontbrekende data te reconstrueren, als voldoende FEC-data is aangekomen.
4. Daardoor kan herstel vaak plaatsvinden zonder eerst een aanvraag en hertransmissie af te wachten.

### Waarom BIP 152 high-bandwidth relevant is

In de beschreven low-bandwidth-modus kondigt een node een blok eerst aan; peers kunnen daarna aangeven welke transacties zij nog nodig hebben. De high-bandwidth-modus verspreidt compacte blokken directer, zonder op diezelfde aanvraagronde te wachten.

De oorspronkelijke notitie beschrijft FIBRE als een combinatie van high-bandwidth compact blocks en Wirehair FEC. Compacte transactie-identificaties kunnen voldoende zijn wanneer peers de transacties al in hun mempool hebben. FEC helpt daarnaast om ontbrekende overdrachtsdata op te vangen. De precieze reconstructie hangt af van de data die de ontvangende node al heeft en de redundantie die is meegestuurd.

### Doel en aandachtspunten

- **Beoogd voordeel:** blokken sneller bij aangesloten nodes krijgen.
- **Netwerkeffect:** mogelijk minder stale blocks door propagatievertraging.
- **Aandachtspunt:** de genoemde 100–300 ms is geen gegarandeerde latency voor iedere node of verbinding.
- **Context:** FIBRE is een overlay; het vervangt niet het bredere Bitcoin-peer-netwerk.

### Onderwerpen voor verdere uitwerking

- De wiskundige werking en herstelgrenzen van Wirehair FEC.
- De geografische spreiding en netwerkverbindingen van FIBRE-nodes.

## B. VORTEX OS-linkdashboard

### Doel en inhoud

Het zichtbare fragment noemt **“VORTEX OS: Link Dashboard”** en beschrijft het als een geïntegreerd systeem voor OSINT, geodesie en een historisch archief. De oorspronkelijke HTML breekt af tijdens de dashboardheader; de ontbrekende kaartinhoud en onderliggende categorielinks zijn daarom niet uit het fragment af te leiden.

### Interface-opbouw

- **Pagina:** gecentreerd dashboard met een maximale breedte van ongeveer 1.000 px.
- **Indeling:** responsief kaartrooster; de CSS-fragmenten noemen een minimale kaartbreedte van 400 px.
- **Header:** dashboardnaam, korte toelichting en een scheidingslijn.
- **Kaarten:** afgeronde donkere panelen met een gekleurde bovenrand.
- **Kaartinhoud:** badge, titel en lijst met links.
- **Linkrijen:** pictogram plus tekst, met een accentkleurige hoverstijl.
- **Statische waarden:** aparte gestippelde rij met label en waarde.

### Visueel systeem

| Onderdeel | Waarde |
| --- | --- |
| Achtergrond | `#0f172a` |
| Kaartachtergrond | `#1e293b` |
| Primaire tekst | `#f8fafc` |
| Gedempte tekst | `#94a3b8` |
| Lettertype | Courier New / monospace |

| Accent | Kleurcode |
| --- | --- |
| Paars | `#8b5cf6` |
| Roze | `#ec4899` |
| Groen | `#10b981` |
| Cyaan | `#06b6d4` |
| Rood | `#ef4444` |
| Blauw | `#3b82f6` |

De accentkleuren komen in het fragment terug op kaartborders, badges, glows en hoverstijlen. Er is geen betrouwbare koppeling tussen een specifieke kleur en een inhoudscategorie zichtbaar; die indeling is dus nog open.

### Bestaande project- en prototypeverwijzingen

- [CryptPad-prototype](https://mathgeo-seven.vercel.app/cryptpad.html)
- [CodePen-editor/prototype](https://codepen.io/editor/rhianna/pen/01a13599-3e65-7dbc-907f-0231961f8ded)
- [Vercel-project — hoofdbestemming](https://penrose-ten.vercel.app/)

**Linkcontrole:** de oorspronkelijke notitie toonde ook de tekst `https://penrose-ten.vercel.app/links.html`, maar die link wees feitelijk naar de hoofdbestemming hierboven. De specifieke `/links.html`-bestemming is daarom niet als werkende link aangenomen. Dubbele vermeldingen van dezelfde CryptPad- en CodePen-URL zijn samengevoegd.

### Nog aan te vullen voor het dashboard

- De volledige, werkende HTML/CSS-bron terugvinden of opnieuw opbouwen.
- De definitieve dashboardcategorieën vastleggen.
- De bijbehorende OSINT-, geodesie- en archieflinks per kaart toevoegen.
- Bepalen of de Vercel-pagina een aparte `/links.html`-route heeft.

## C. Digitale OSINT & geodetische telemetrie

### Managementsamenvatting

Dit onderdeel brengt twee analytische kaders samen:

- **OSINT Framework:** het verifiëren en in kaart brengen van online pseudoniemen, aliassen en mogelijk hergebruik van accounts.
- **Geodetische en netwerktelemetrie:** de analyse van het VORTEX Omni-Bridge-netwerk, gecentreerd rond het Laren Global Anchor (52,257° N, 5,225° E).

Het rapport beschrijft een OSINT-onderzoeksprotocol en rapporteert berekeningen over atmosferische refractie, zichtlijnen en netwerkfideliteit. De cijfers en conclusies hieronder zijn overgenomen uit de brontekst en niet onafhankelijk gevalideerd.

### C1. OSINT-framework voor gebruikersnamen

Onderzoek naar pseudoniemen en aliassen is een gestructureerde praktijk binnen cybersecurity en inlichtingenonderzoek. Het doel is vast te stellen of dezelfde alias actief is op meerdere platforms, fora of openbare registers.

#### Identificatiebronnen en technieken

- **Geautomatiseerde scanners:** opensource-tools die een alias op veel platforms controleren, onder meer aan de hand van HTTP-statuscodes.
- **Zoekplatforms:** webgebaseerde aggregators voor het doorzoeken van profielen en domeinregistraties.
- **Register-indexering:** gespecialiseerde databases voor het vinden van koppelingen tussen aliassen en openbare entiteiten.
- **Zoekoperatoren:** gerichte zoekopdrachten, zoals exacte woordgroepen tussen aanhalingstekens, domeinspecifieke zoekopdrachten en filters op bestandsformaat.
- **Historische archieven:** onder meer het Internet Archive om eerdere versies van webpagina’s en fora te bekijken waar aliassen mogelijk nog voorkwamen.

#### Onderzoeksprotocol

| Fase | Methodiek / tooling | Doel | Verwachte output |
| --- | --- | --- | --- |
| 1. Discovery | Geautomatiseerde scanners | Actieve profielen identificeren | Lijst met geverifieerde URL’s |
| 2. Contextualisatie | Geavanceerde zoekoperatoren | Openbare uitspraken en activiteit vinden | Inhoudelijke sporen en tijdlijn |
| 3. Corroboratie | Domein- en registeranalyse | Identiteitskoppelingen verifiëren | Kruisverbanden en patronen |
| 4. Archivering | Wayback Machine en hash-logging | Bewijsmateriaal en status vastleggen | Gevalideerd dossier/rapport |

### C2. Geodetische telemetrie en atmosferische refractie

Het VORTEX Omni-Bridge-netwerk gebruikt het Laren Global Anchor (52,257° N, 5,225° E) als primair geodetisch ijkpunt.

#### Refractie en schaduwberekeningen

Volgens de brontekst veroorzaakt atmosferische refractie bij lage zonnestanden (onder 10°) een optische opbuiging. Bij een zonnestand van 1,00° wordt een refractie van 21,74 boogminuten genoemd. Op een noordelijke helling van 3° zou de berekende schaduw van de Tafelberg (25 m hoog) daardoor verkorten van 357,5 m naar 327,7 m: een verschil van 29,8 m. Over een rastervector van 24 km rapporteert de tekst een zijdelingse grid-dislocatie van 151,8 m.

| Zonnestand | Refractie | Geometrische schatting | Optische schatting | Schaduwdelta | Macro-dislocatie (24 km) |
| --- | --- | --- | --- | --- | --- |
| 0,10° (horizon) | 33,72′ | 461,8 m | 401,4 m | 60,4 m | 235,4 m |
| 0,50° (rand) | 25,00′ | 408,8 m | 365,1 m | 43,6 m | 174,5 m |
| 1,00° (zonsondergang) | 21,74′ | 357,5 m | 327,7 m | 29,8 m | 151,8 m |
| 2,00° | 16,93′ | 285,8 m | 270,4 m | 15,3 m | 118,2 m |
| 5,00° | 9,67′ | 177,9 m | 174,3 m | 3,6 m | 67,5 m |
| 10,00° (drempel) | 5,41′ | 108,3 m | 107,5 m | 0,8 m | 37,8 m |

#### Trans-Atlantische zichtlijn

De brontekst beschrijft een grootcirkelvector tussen Laren en het WTC in New York van 5.877 km, met een initiële vertrekazimut van 287,5°. Een atmosferische refractiefactor van (k = 0,14) zou de optische lichtstraal op het diepste punt van de oceaan 378 km boven de aardkromming tillen.

### C3. Phase-Shift 002: netwerktransitie en netwerkfideliteit

De tekst beschrijft een transitie van Hexagram 63 (101010) naar Hexagram 64 (010101) via een binaire NOT-inversie over een metronoom van 103 stappen. Tijdens die overgang zouden de volgende waarden zijn gemeten:

- **Minimale netwerkfideliteit:** 98,6%, boven de genoemde veiligheidsdrempel van 98,5%.
- **UDP-pacing:** 25,0 ± 1,2 ms.

De bron concludeert dat zowel het OSINT Username Intelligence-protocol als de VORTEX-geodetische parameters in gecontroleerde operationele staat verkeren. Als vervolgstappen noemt de bron het integreren van zoekmachinetechnieken in geautomatiseerde monitoring en het periodiek herkalibreren van KML-vectoren aan de hand van de meest recente satelliet-efemeriden.

[Digitale OSINT & Geodetische Telemetrie](https://app.notion.com/p/Digitale-OSINT-Geodetische-Telemetrie-741dd9502e4e8304b72681f0aa86a036?pvs=21)