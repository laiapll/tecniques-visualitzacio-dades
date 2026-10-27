source("R/api_transparencia.R")

# Obtenir dades de la font
defuncions <- llegir_dades_transparencia(
  resource_id = "3cre-fa8v",
  where = "nom_regio = 'Barcelona Ciutat'",
  format = "csv",
  limit = 1000000)

# Preparar dades pel gràfic
dades_rose <- defuncions %>%
  filter(year(data) == 2025) %>%
  mutate(
    mes = month(data),
    # sexe, index_socioeconomic, grup_edat,
    grup = ifelse(grup_edat == "80 o més", "80 o més", "Menys de 80")
  ) %>%
  count(mes, grup, wt = casos)

# Desar les dades
write_csv(dades_rose, "data/dades_rose.csv")
