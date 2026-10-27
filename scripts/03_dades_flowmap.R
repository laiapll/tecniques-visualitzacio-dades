source("R/api_transparencia.R")

# Obtenir dades de la font
dades_mob <- llegir_dades_transparencia(
  resource_id = "8w7y-2bfp",
  where = "Curs = '2025/2026' AND Estudis IN ('EDUCACIÓ PRIMÀRIA')",
  format = "csv",
  limit = 10^5)

municipis <- llegir_dades_transparencia(resource_id = "9aju-tpwc")
municipis$codi <- substr(municipis$codi, 1, 5)

# Preparar dades pel gràfic
municipis_csv <- municipis %>% 
  filter(substr(codi, 1, 2) == "08") %>% # Prov Barcelona
  filter(codi != "99999") %>%
  select(codi, latitud, longitud, nom, nom_comarca)

dades_flowmap <- dades_mob %>%
  count(
    Procedencia = codi_resid_ncia_municipi, 
    Desti = codi_municipi_centre,
    Municipi_Desti = municipi_centre,
    wt = n_mero_matr_cules_estad_stica,
    name = "Total"
  ) %>%
  filter(
    Procedencia %in% municipis_csv$codi,
    Desti %in% municipis_csv$codi,
    Procedencia != Desti
  ) %>%
  mutate(
    Prop = round(Total/sum(Total)*100, 2),
    .by = "Municipi_Desti"
  )

# Desar les dades
write_csv(dades_flowmap, "data/dades_flowmap.csv")
write_csv(municipis_csv, "data/municipis.csv")