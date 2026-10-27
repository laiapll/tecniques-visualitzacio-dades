source("R/api_transparencia.R")

# Obtenir dades de la font
dades_elec <- llegir_dades_transparencia(
  resource_id = "ntc4-rnwr",
  where = "id_eleccio = 'A20241' AND id_nivell_territorial = 'PR'",
  format = "csv")

# Preparar dades pel gràfic
dades_sankey <- dades_elec %>%
  filter(escons > 0) %>%
  select(territori_nom, candidatura_sigles, candidatura_color, escons)

# Desar les dades
write_csv(dades_sankey, "data/dades_sankey.csv")
