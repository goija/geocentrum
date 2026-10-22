// =====================================================================
// VORTEX OS - Geodetisch Rekencentrum
// Module: Chaos Attractoren en Systeemtheorie
// Doel: Numerieke integratie en 3D projectie van niet-lineaire systemen
// =====================================================================

clear; clc;

// Definieer het Lorenz-systeem
function dx = lorenz_attractor(t, x)
    sigma = 10.0;
    rho = 28.0;
    beta = 8.0 / 3.0;
    
    dx(1) = sigma * (x(2) - x(1));
    dx(2) = x(1) * (rho - x(3)) - x(2);
    dx(3) = x(1) * x(2) - beta * x(3);
endfunction

// Tijdspanne en beginvoorwaarden
t = 0:0.005:50;
x0 = [1.0; 1.0; 1.0];

// Numerieke oplossing (ODE)
disp("Simulatie starten: Numerieke integratie van Lorenz Attractor...");
sol = ode(x0, 0, t, lorenz_attractor);

// 3D Visualisatie
f = gcf();
f.color_map = jetcolormap(64);
param3d(sol(1,:), sol(2,:), sol(3,:));

// Opmaak van de plot
e = gce();
e.foreground = color('blue');
e.thickness = 1;
title("VORTEX OS: 3D Chaos Attractor Projectie", "fontsize", 4);
gca().grid = [1, 1, 1];

disp("✅ Simulatie voltooid en 3D projectie geladen.");
