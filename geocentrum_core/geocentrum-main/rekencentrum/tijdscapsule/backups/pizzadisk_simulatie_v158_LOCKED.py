# =====================================================================
# VORTEX OS - Geavanceerde Pizza Simulatie & Rekencentrum Matrix
# Gebaseerd op Snapshot 8 & Viewport Engine v158.8
# =====================================================================
import math

def run_pizza_simulatie():
    # Instrumentale constanten A. Ott Nr. 573
    poolarm_R = 15.00  # cm
    rijarm_L = 16.67   # cm
    fraunhofer_d = 16.675 # cm (589 nm)
    
    # Schijf parameters (Pizzadoos / Kaartcirkel)
    diameter_cm = 29.0
    straal = diameter_cm / 2.0
    oppervlakte_netto = math.pi * (straal ** 2)
    
    # Tzolk'in Geodetische Vectoren
    vectoren = [22.0, 29.0, 91.0, 97.0, 122.0, 331.0]
    
    print("==================================================")
    print(" VORTEX OS - PIZZA SIMULATIE REKENCENTRUM v158.8")
    print("==================================================")
    print(f"Basis Diameter      : {diameter_cm} cm")
    print(f"Netto Straal (R)    : {straal} cm")
    print(f"Netto Oppervlakte   : {oppervlakte_netto:.2f} cm²")
    print(f"Ott Nonius Schaal   : {oppervlakte_netto * 10.0:.1f} eenheden")
    print("-" * 50)
    print("Geëvalueerde Tzolk'in Vectoren:")
    for v in vectoren:
        rad = math.radians(v)
        x = math.cos(rad) * straal
        y = math.sin(rad) * straal
        print(f" - Hoek {v:>5.1f}° -> X: {x:>6.2f} cm | Y: {y:>6.2f} cm")
    print("==================================================")

if __name__ == "__main__":
    run_pizza_simulatie()
