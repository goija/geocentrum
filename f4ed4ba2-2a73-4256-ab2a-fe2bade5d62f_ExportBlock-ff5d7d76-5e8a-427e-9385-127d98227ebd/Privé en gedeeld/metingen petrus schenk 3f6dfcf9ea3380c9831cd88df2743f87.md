# metingen petrus schenk

|  |  |
| --- | --- |
| timestamp | "2026-10-11T14:23:07.819Z" |
| adres | "LIEVE VROUWEKERKHOF" amersfoort |
| latitude | "52.155174" |
| longitude | "5.387206" |
| rdCoordinaten | "X = 155000.0 m, Y = 463000.0 m" |
| utmCoordinaten | "E = 663304.1 m, N = 5780984.5 m" |
| datum | "2026-10-11" |
| objectHoogte | "98.3" |
| tijd | "16:23" |
| theorSchaduwLengteM | "274.9" |
| zonAzimutGronden | "227.5" |
| zonElevatieGronden | "19.68" |

[https://mathgeo-seven.vercel.app/schaduwwaaier.html](https://mathgeo-seven.vercel.app/schaduwwaaier.html)

### Analyse van de Nieuwe Coördinaat (RD: 136853.59, 455879.01)

"""
GeoHack & RD-Co$rdinaten Generator (Tafelberg Blaricum & Generiek)
Converteert WGS84 (Lat/Lon) naar DMS, UTM Zone 31U, en Rijksdriehoeksstelsel (RD New - EPSG:28992).
"""

import math
import pyproj

def latlon_to_dms(lat, lon):
def dec_to_dms(deg, is_lat):
direction = ('N' if deg >= 0 else 'S') if is_lat else ('E' if deg >= 0 else 'W')
deg_abs = abs(deg)
d = int(deg_abs)
m_float = (deg_abs - d) * 60
m = int(m_float)
s = (m_float - m) * 60
return d, m, s, direction

```
lat_d, lat_m, lat_s, lat_dir = dec_to_dms(lat, True)
lon_d, lon_m, lon_s, lon_dir = dec_to_dms(lon, False)
return {
    'latdegabs': lat_d, 'latminint': lat_m, 'latsecdec': round(lat_s, 2), 'latNS': lat_dir,
    'londegabs': lon_d, 'lonminint': lon_m, 'lonsecdec': round(lon_s, 2), 'lonEW': lon_dir
}
```

def convert_coordinates(lat, lon, title="Tafelberg (Blaricum)", scale=10000, region="NL-NH", obj_type="landmark"):
# WGS84 -> UTM 31N (EPSG:32631)
tf_utm = pyproj.Transformer.from_crs("EPSG:4326", "EPSG:32631", always_xy=True)
utm_e, utm_n = tf_utm.transform(lon, lat)

```
# WGS84 -> RD New (EPSG:28992)
tf_rd = pyproj.Transformer.from_crs("EPSG:4326", "EPSG:28992", always_xy=True)
rd_x, rd_y = tf_rd.transform(lon, lat)

dms = latlon_to_dms(lat, lon)

# MediaWiki {{Coord}} template string
# Door de dubbele accolades in variabelen op te slaan, voorkomen we f-string syntax-fouten.
op = "{{"
cl = "}}"
coord_template = f"{op}Coord|{dms['latdegabs']}|{dms['latminint']}|{dms['latsecdec']:.2f}|{dms['latNS']}|{dms['londegabs']}|{dms['lonminint']}|{dms['lonsecdec']:.2f}|{dms['lonEW']}|type:{obj_type}_region:{region}_scale:{scale}|name={title}{cl}"

# GeoHack URL
params = f"{dms['latdegabs']}_{dms['latminint']}_{dms['latsecdec']:.2f}_{dms['latNS']}_{dms['londegabs']}_{dms['lonminint']}_{dms['lonsecdec']:.2f}_{dms['lonEW']}_type:{obj_type}_region:{region}_scale:{scale}"
geohack_url = f"<https://geohack.toolforge.org/geohack.php?pagename=>{title.replace(' ', '_')}&params={params}"

# PDOK Kaart URL (Kadaster RD Viewer)
pdok_url = f"<https://kaarten.pdok.nl/viewer/#x={rd_x:.1f}&y={rd_y:.1f}&z=12>"

return {
    'latdegdec': lat,
    'londegdec': lon,
    'dms': dms,
    'utm': {'zone': '31U', 'easting': round(utm_e, 2), 'northing': round(utm_n, 2)},
    'rd': {'x': round(rd_x, 2), 'y': round(rd_y, 2)},
    'coord_template': coord_template,
    'geohack_url': geohack_url,
    'pdok_url': pdok_url
}
```

if **name** == "**main**":
lat, lon = 52.29662, 5.16443
res = convert_coordinates(lat, lon)
print("=== TAFELBERG BLARICUM CO$RDINATEN CONVERSIE ===")
print(f"Decimaal WGS84 : {res['latdegdec']}$N, {res['londegdec']}$ E")
print(f"DMS             : {res['dms']['latdegabs']}${res['dms']['latminint']}' {res['dms']['latsecdec']}\" {res['dms']['latNS']}, {res['dms']['londegabs']}$ {res['dms']['lonminint']}' {res['dms']['lonsecdec']}\" {res['dms']['lonEW']}")
print(f"UTM Zone 31U    : Easting {res['utm']['easting']} m, Northing {res['utm']['northing']} m")
print(f"RD New (EPSG:28992): X = {res['rd']['x']} m, Y = {res['rd']['y']} m")
print(f"PDOK Kadaster   : {res['pdok_url']}")
print(f"GeoHack URL     : {res['geohack_url']}")

De opgegeven Rijksdriehoekscoördinaat `X: 136853.59, Y: 455879.01` ligt uiterst dicht bij **Punt 2** uit het actieve telemetrielogboek (`X: 136852.86, Y: 455879.86`). Het betreft hier een sub-meter verfijning of een direct opgemeten controlepunt in de onmiddellijke nabijheid van dat eerdere meetpunt in Utrecht (omgeving GPS `52.09088, Lng 5.12241`).

### Vergelijking met Punt 2

- **Verschil in X (Oost):** Slechts $+0.73$ meter ten opzichte van Punt 2.
- **Verschil in Y (Noord):** Slechts $-0.85$ meter ten opzichte van Punt 2.
- **Verwachte Parameters:** Gezien de minimale afwijking sluiten de bijbehorende omgevingsparameters nagenoeg identiek aan bij Punt 2:
- **Hoogte:** $\approx 12.0$ meter
- **Zon & Maan:** Zon op/onder: `07:57 / 18:56` | Maan op/onder: `09:08 / 18:47`
- **LST (Local Sidereal Time):** `12h 23m`

Dient deze nauwkeurige afwijking als een controlemeting voor de kalibratie van de overlay binnen MapLibre, of betreft dit een correctie op basis van de ingevoerde wieltje-klik?

Hier is een samenvatting van de geselecteerde tekst over de hemelkaart van Andreas Cellarius:

# Overzicht van de Hemelkaart

- **Titel en Editie:** *Situs Terrae Circulis Coelestibus Circundatae*, in de editie uit 1708 uitgegeven door Gerard Valk en Pieter Schenk.
- **Oorsprong:** Oorspronkelijk onderdeel van de *Harmonia Macrocosmica*, een beroemde hemelatlas van Andreas Cellarius, voor het eerst gepubliceerd in 1660 door Jan Jansson en gegraveerd door Johannes van Loon.
- **Visuele Stijl:** Een weelderige, barokke presentatie vol wolken, putti (engelachtige figuren) en muses (Geometria en Urania), aangevuld met astronomische instrumenten zoals astrolabia en gradenboogjes.

# Inhoud en Doel van de Kaart

- **Doel:** Illustreert het concept van de hemelbol en de primaire cirkels/coördinaten, nuttig voor zowel astronomen als geografen, tijdmeting en navigatie.
- **Geen Ptolemeïsch model:** Het is geen weergave van een specifiek zonnestelselmodel, maar een instrument voor sferische/positionele astronomie dat toepasbaar was op zowel antieke (Ptolemaeus) als moderne systemen (Tycho Brahe, Copernicus).
- **De Hemelbol en Weergave:** De aarde staat centraal, omringd door een gestileerde armillairsfeer met zeven sterrenbeelden van de Dierenriem (Kreeft, Leeuw, Maagd, Weegschaal, Schorpioen, Boogschutter en Steenbok) en cirkels zoals de evenaar, de keerkringen en de poolcirkels.
- **Geografische Weergave op de Globe:** De getoonde wereldkaart weerspiegelt de toenmalige kennis en focust op Australië, Zuidoost-Azië, de Stille Oceaan, de Indische Oceaan en de speculatieve *Terra Australis Incognita* en het eiland Californië.

# Belangrijkste Cartografen en Uitgevers

- **Andreas Cellarius (1596–1665):** Nederlands-Duitse cartograaf en rector van de Latijnse School in Hoorn, wereldberoemd om zijn hemelatlas *Harmonia Macrocosmica*.
- **Gerard Valk (1652–1726) & Petrus Schenk (1660–1711):** Amsterdamse graveurs en uitgevers die in 1694 de koperplaten overnamen en in 1708 een nieuwe editie publiceerden; tevens berucht om hun kwalitatieve globes.
- **Johannes van Loon (c. 1611–1686):** Nederlandse kaartenmaker en graveur die de platen voor Cellarius' atlas vervaardigde.

Enkele opmerkingen over deze beschrijving:

**Historische Context**

- Gerard Valk en Petrus Schenk waren inderdaad vooraanstaande kartografen in Amsterdam aan het begin van de 18e eeuw
- Hun samenwerking was niet ongebruikelijk voor die tijd; uitgevers werkten vaak samen om complete atlassen te produceren
- De omvang van 507 kaarten is indrukwekkend voor die periode

**Interessante Details**

- De indeling van de 6 delen volgt de gebruikelijke regionale classificatie van de 17e-eeuwse cartografie
- De allegorische titelpagina in gravure was typisch voor luxueuze atlassen uit deze periode
- Het formaat (636 x 368 mm) duidt op een folio-editie, wat het meest prestigieuze formaat was

**Verifieerbare Aspecten**
Hoewel mijn kennis hierover beperkt is tot voor april 2024, zou web-search nuttig kunnen zijn voor:

- Verificatie van specifieke exemplaren in musea of bibliotheken
- Huidige marktwaarde voor dergelijke zeldzame items
- Bewaarde exemplaren in collecties zoals de Koninklijke Bibliotheek of bibliotheekcollecties elders

Kan ik je helpen met:

- **Zoeken naar vergelijkbare werken** in openbare collecties?
- **Contacteren van gespecialiseerde databanken** over historische kartografie?
- **Uitwerken van een beschrijving** voor catalogisering?
- **Verwantschap analyseren** met andere atlassen uit deze periode (zoals Blaeu of Homann)?