library(highcharter)
library(dplyr)
library(htmlwidgets)
library(htmltools)

# -------------------------------------------------------------
# 1) SANKEY
# -------------------------------------------------------------

dades_sankey <- read_csv("data/dades_sankey.csv")

colors_dest <- dades_sankey |>
  distinct(id = candidatura_sigles, color = candidatura_color)

hc_sankey <- hchart(dades_sankey, "sankey",
                    hcaes(
                      from = territori_nom,
                      to = candidatura_sigles,
                      weight = escons,
                      color = candidatura_color
                    )) |>
  hc_plotOptions(sankey = list(nodes = list_parse(colors_dest))) |>
  hc_title(text = "Parlament de Catalunya. Electes per circumscripció") |>
  hc_subtitle(text = "Eleccions al Parlament de Catalunya 2024") |>
  hc_tooltip(pointFormat = "{point.from} → {point.to}: <b>{point.weight}</b>") |>
  hc_credits(enabled = FALSE)

hc_sankey
saveWidget(hc_sankey, "docs/sankey.html", selfcontained = TRUE)


# -------------------------------------------------------------
# 2) ROSE CHART
# -------------------------------------------------------------

dades_rose <- read_csv("data/dades_rose.csv")

mesos <- c("Gener", "Febrer", "Març", "Abril", "Maig", "Juny",
           "Juliol", "Agost", "Setembre", "Octubre", "Novembre", "Desembre")

hc_rose <- hchart(dades_rose, "column", 
                  hcaes(
                    x = mes - 1,
                    y = n,
                    group = grup
                  )) |>
  hc_chart(polar = TRUE) |>
  hc_xAxis(categories = mesos, tickmarkPlacement = "on") %>%
  hc_yAxis(min = 0, title = list(text = NULL),
           labels = list(enabled = FALSE)) |>
  hc_plotOptions(column = list(stacking = "normal",
                               pointPadding = 0,
                               groupPadding = 0,
                               borderWidth = 0)) |>
  hc_title(text = "Defuncions mensuals per grup d'edat") |>
  hc_subtitle(text = "Barcelona, 2025") |>
  hc_tooltip(shared = TRUE) |>
  hc_credits(enabled = FALSE)

hc_rose
saveWidget(hc_rose, "docs/rose.html", selfcontained = TRUE)
