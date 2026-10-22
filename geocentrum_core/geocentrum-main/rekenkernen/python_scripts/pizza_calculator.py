#!/usr/bin/env python3
# =====================================================================
# VORTEX OS - Pizza Disk Geometrie & Planimeter Rekenomgeving
# =====================================================================
import math

def bereken_pizza_geometrie(diameter_cm):
    R = diameter_cm / 2.0
    zijde = R
    apothema = (math.sqrt(3) / 2.0) * R
    vlakken = math.sqrt(3) * R
    oppervlakte = math.pi * (R ** 2)
    nonius_ Ott = oppervlakte * 10.0  # bij schaalfactor f = 0.11
    
    return {
        "diameter_cm": diameter_cm,
        "straal_cm": round(R, 2),
        "zijde_mm": round(zijde * 10, 2),
        "apothema_mm": round(apothema * 10, 2),
        "vlakken_mm": round(vlakken * 10, 2),
        "oppervlakte_cm2": round(oppervlakte, 2),
        "ott_nonius": round(oppervlakte * 10.0, 2)
    }

if __name__ == "__main__":
    print(bereken_pizza_geometrie(29.0))
