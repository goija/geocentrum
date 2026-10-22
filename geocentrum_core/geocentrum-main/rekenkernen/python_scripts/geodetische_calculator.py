#!/usr/bin/env python3
# =====================================================================
# VORTEX OS - Geodetische Rekenmodule (Core Engine)
# =====================================================================
import math

def saemundsson_refraction(altitude_deg):
    """
    Berekent atmosferische refractie volgens de Saemundsson-formule.
    """
    if altitude_deg < -2.0:
        return {"refraction_arcmin": 0.0, "apparent_altitude": altitude_deg}
    
    R = 1.02 / math.tan(math.radians(altitude_deg + 10.3 / (altitude_deg + 5.11)))
    apparent_alt = altitude_deg + (R / 60.0)
    return {
        "altitude_input_deg": altitude_deg,
        "refraction_arcmin": round(R, 4),
        "apparent_altitude_deg": round(apparent_alt, 4)
    }

def bereken_elevatie_correctie(schijnbare_elevatie, correctie):
    """
    Berekent de ware elevatie door de refractiecorrectie toe te passen.
    """
    ware_elevatie = schijnbare_elevatie - correctie
    return {
        "schijnbare_elevatie_deg": schijnbare_elevatie,
        "correctie_deg": correctie,
        "ware_elevatie_deg": round(ware_elevatie, 4)
    }

def ott_planimeter_area(start_reading, end_reading, scale_factor=10.0):
    """
    Berekent de oppervlakte op basis van de Ott Planimeter (Poolplanimeter Nr. 573).
    """
    diff = end_reading - start_reading
    area = diff * scale_factor
    return {
        "start": start_reading,
        "end": end_reading,
        "verschil": round(diff, 3),
        "oppervlakte_m2": round(area, 2)
    }

def haversine_distance(lat1, lon1, lat2, lon2):
    """
    Berekent de grootcirkelafstand tussen twee coördinaten.
    """
    R_earth = 6371000.0  # meters
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi = math.radians(lat2 - lat1)
    dlambda = math.radians(lon2 - lon1)

    a = math.sin(dphi / 2.0)**2 + math.cos(phi1) * math.cos(phi2) * math.sin(dlambda / 2.0)**2
    c = 2.0 * math.atan2(math.sqrt(a), math.sqrt(1.0 - a))

    distance = R_earth * c
    return {
        "lat1": lat1, "lon1": lon1,
        "lat2": lat2, "lon2": lon2,
        "afstand_meters": round(distance, 2)
    }

if __name__ == "__main__":
    print("Geodetische Rekenkern geladen.")
    print("Test correctie:", bereken_elevatie_correctie(10.0901, 0.0901))
