# Tècniques de visualització de dades

PAC2 Visualització de Dades · Màster en Ciència de Dades · UOC · Curs 2026-27
Autoria: Laia Palomares Llevot

Aquesta pràctica té com objectiu provar diferents tècniques i eines de visualització. En aquest repositori es presenten tres visualitzacions interactives amb dades obertes de la Generalitat de Catalunya: un **diagrama de Sankey** i un **gràfic de rosa (rose chart)**, fets amb R i el paquet [`highcharter`](https://jkunst.com/highcharter/), i un **mapa de fluxos (flowmap)** fet amb [Flourish](https://flourish.studio/).

## Visualitzacions

| Gràfic | Eina | Descripció | Enllaç |
|---|---|----------|---|
| Sankey | R · highcharter | [Repartició d'escons electorals per circumscripció] | [Veure](https://laiapll.github.io/tecniques-visualitzacio-dades/sankey.html) |
| Rose chart | R · highcharter | [Defuncions per grup d'edat a Barcelona ciutat al 2025] | [Veure](https://laiapll.github.io/tecniques-visualitzacio-dades/rose.html) |
| Flowmap | Flourish | Desplaçaments entre el municipi de residència i el municipi d'estudi de l'alumnat d'ensenyaments no universitaris | [Veure]([https://public.flourish.studio/visualisation/30627653/]) |

Els gràfics són interactius: tooltips en passar el cursor i, al mapa, zoom i desplaçament.

## Dades

Totes les dades provenen del portal de dades obertes de la Generalitat de Catalunya ([analisi.transparenciacatalunya.cat](https://analisi.transparenciacatalunya.cat/)). S'han obtingut cridant directament l'**API del portal** amb una funció pròpia (`R/api.R`) i s'han **transformat segons les necessitats de cada gràfic** a `scripts/01_dades.R`. Només es conserven les dades ja transformades, a la carpeta `dades/`. [COMPLETA: breu descripció de les transformacions, p. ex. filtres, agregacions, unions de taules.]

**Data de descàrrega:** 27/10/2026. Les dades obertes s'actualitzen, així que tornar a executar la descàrrega més endavant pot donar resultats diferents. Les dades de `dades/` són les que s'han fet servir per als gràfics publicats.

| Gràfic | Conjunt de dades |
|---|---------------|
| Sankey | [Processos electorals - Vots](https://analisi.transparenciacatalunya.cat/Sector-P-blic/Processos-electorals-Vots/ntc4-rnwr) |
| Flowmap | [Mobilitat obligada municipal per raó d'estudis no universitaris](https://analisi.transparenciacatalunya.cat/Educaci-/Mobilitat-obligada-municipal-per-ra-d-estudis-no-u/8w7y-2bfp/about_data) |
| Flowmap (coordenades) | [Municipis Catalunya Geo](https://analisi.transparenciacatalunya.cat/Urbanisme-infraestructures/Municipis-Catalunya-Geo/9aju-tpwc/about_data) |
| Rose chart | [Defuncions a Catalunya](https://analisi.transparenciacatalunya.cat/Salut/Defuncions-a-Catalunya/3cre-fa8v/about_data) |

## Estructura del repositori

```
.
├── README.md
├── R/
│   └── api_transparencia.R      # funció que crida l'API del portal
├── scripts/
│   ├── 01_dades_sankey.R        # vots -> dades/sankey.csv
│   ├── 02_dades_rose.R          # defuncions -> dades/rose.csv
│   ├── 03_dades_flowmap.R       # mobilitat + coordenades -> dades/flowmap.csv
│   └── 04_grafics.R             # llegeix dades/ i genera els HTML a docs/
├── dades/                       # dades ja transformades per als gràfics
│   ├── sankey.csv
│   ├── rose.csv
│   ├── flowmap.csv
│   └── municipis.csv
└── docs/                        # HTML generats (es publiquen amb GitHub Pages)
    ├── sankey.html
    └── rose.html
```

## Com reproduir-ho

1. Instal·la R (≥ 4.1) i els paquets:

   ```r
   install.packages(c("highcharter", "dplyr", "htmlwidgets", "htmltools", "tibble"))
   ```

   [COMPLETA: afegeix els paquets que fa servir la funció de l'API, p. ex. `httr2` o `jsonlite`.]

   `htmlwidgets::saveWidget(selfcontained = TRUE)` també requereix [Pandoc](https://pandoc.org/) (ve inclòs amb RStudio).

2. **(Opcional) Tornar a descarregar les dades:** executa els scripts `01`, `02` i `03` de `scripts/`, en l'ordre que vulguis (són independents). Cada un crida l'API del portal, aplica les transformacions del seu gràfic i sobreescriu el seu fitxer de `dades/`. Cal connexió a internet, i el resultat pot diferir de les dades publicades si el portal s'ha actualitzat.
3. **Generar els gràfics:** executa `scripts/04_grafics.R`. Llegeix les dades de `dades/` i desa el Sankey i el rose chart a `docs/`.
4. El flowmap no es genera amb R: es fa a Flourish a partir de `dades/flowmap.csv`.

Si només vols reproduir els gràfics tal com estan publicats, no cal executar el pas 2: n'hi ha prou amb el pas 3.

## Llicències i atribució

- **Dades:** Generalitat de Catalunya, portal de dades obertes. Consulta la llicència de cada conjunt a la taula d'adalt.
- **Highcharts (Sankey i rose chart):** aquests dos gràfics usen la llibreria Highcharts, que és gratuïta per a ús educatiu i no comercial ([condicions](https://shop.highcharts.com/license-eula)). Aquest treball és de caràcter acadèmic i no comercial. Un ús comercial requeriria una llicència de Highcharts.
- **Flowmap (Flourish):** publicat a Flourish; les condicions d'ús depenen del pla del compte i es poden consultar a [flourish.studio](https://flourish.studio/).
