# =====================================================================
# VORTEX OS - Geodetisch Rekencentrum
# Module: Maya Tzolk'in 5-Fold Almanac (Synchronometrie)
# Doel: Modulo 13 & 20 berekeningen en radiale projecties voor 260-daagse cyclus
# =====================================================================

# Laad benodigde bibliotheken (installeer indien nodig)
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

# Genereer de 260 Kin (dagen) van de Tzolk'in
kin_dagen <- 1:260

# Modulo berekeningen
# Tonen (1-13)
galactische_tonen <- ((kin_dagen - 1) %% 13) + 1
# Zegels (1-20)
zonne_zegels <- ((kin_dagen - 1) %% 20) + 1

# Creëer de matrix
tzolkin_matrix <- data.frame(
  Kin = kin_dagen,
  Toon = galactische_tonen,
  Zegel = zonne_zegels
)

print("✅ Tzolk'in Matrix berekend (eerste 10 Kin):")
print(head(tzolkin_matrix, 10))

# Radiale projectie (5-fold basis, 260 / 5 = 52)
# We plotten de Kin posities op een polair coördinatenstelsel
tzolkin_matrix$Hoek <- (tzolkin_matrix$Kin %% 52) * (360 / 52)
tzolkin_matrix$Radius <- ceiling(tzolkin_matrix$Kin / 52)

radiale_plot <- ggplot(tzolkin_matrix, aes(x = Hoek, y = Radius, color = as.factor(Zegel))) +
  geom_point(size = 3, alpha = 0.7) +
  coord_polar(theta = "x") +
  theme_minimal() +
  labs(title = "Tzolk'in Radiale Projectie (5-Fold Almanac)",
       x = "Hoek (Modulo 52)",
       y = "Cyclus (1-5)") +
  theme(legend.position = "none")

# Sla de visualisatie op in de data map voor de cockpittools
ggsave("../cockpittools/data/tzolkin_radiaal.png", plot = radiale_plot, width = 8, height = 8)
print("✅ Radiale projectie opgeslagen als ../cockpittools/data/tzolkin_radiaal.png")
