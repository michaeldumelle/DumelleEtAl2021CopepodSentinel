[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[![minimal R version](https://img.shields.io/badge/R%3E%3D-2.1.0-6666ff.svg)](https://cran.r-project.org/) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/kotzeb0912)](https://cran.r-project.org/) [![packageversion](https://img.shields.io/badge/Package%20version-0.0.0.9000-orange.svg?style=flat-square)](https://github.com/michaeldumelle/DumelleEtAl2021STLMM)
[![Last-changedate](https://img.shields.io/badge/last%20change-2021--01--27-blue.svg)](https://github.com/michaeldumelle/DumelleEtAl2021STLMM)


## DumelleEtAl2021CopepodSentinel

### A Supplementary R Package to "Capturing Copepod Dynamics in the Northern California Current Using Sentinel Stations".

##### Michael Dumelle<sup>1</sup>, Jesse F. Lamb<sup>2</sup>, Kym C. Jacobson<sup>3</sup>, Mary Hunsicker<sup>3</sup>, Cheryl A. Morgan<sup>4</sup>, Brian J. Burke<sup>5</sup>, William T. Peterson<sup>3</sup>

##### <sup>1</sup>Department of Statistics, Oregon State University, Corvallis, OR 97331
##### <sup>2</sup>Fisheries-Oceanography Coordinated Investigations, National Marine Fisheries Service, Alaska Fisheries Science Center, Seattle, WA 98115, USA
##### <sup>3</sup>Fish Ecology Division, National Marine Fisheries Service, Northwest Fisheries Science Center, Newport, OR 97365, USA
##### <sup>4</sup>Cooperative Institute for Marine Resources Studies, Hatfield Marine Science Center, Oregon State University, Newport, OR 97365, USA
##### <sup>5</sup>Fish Ecology Division, National Marine Fisheries Service, Northwest Fisheries Science Center, Seattle, WA 98112, USA

### Abstract 
Ecosystem indicators track information about states and trends in ocean systems and are a valuable tool for ecosystem assessment and management.  To ensure that indicators are used appropriately in both science and management contexts, it is important to understand the extent to which they represent broader spatial patterns.  In the Northern California Current (NCC) off the Oregon and Washington state coasts in the USA, copepod metrics derived from data collected at a well-sampled station on the Newport Hydrographic (NH) Line (‘NH05’, five nmi offshore from Newport, OR, USA) are commonly used as indicators of the region’s general ocean conditions.  Using correlation analyses, we examined the utility of NH05 as a sentinel station (i.e. representative of a broader region) with respect to the abundance and biomass of warm-water and cold-water copepods in the NCC.  Copepod correlations between NH05 and other locations in the NCC were higher for the warm-water copepods than the cold-water group, with correlations being slightly higher for abundance than biomass. *Paracalanus parvus* had the highest NH05 correlations among the warm-water copepod species, and *Acartia longiremis* had the highest NH05 correlations among the cold-water copepod species. We also broadened our analysis and evaluated other sampling sites as sentinel stations and discuss implications.  This analysis emphasized that the warm-water copepods tend to be more similarly distributed in the NCC than the cold-water copepods, and thus their changes through time are better captured by most stations.  In contrast, correlations among the cold-water copepods in the NCC vary by location and appear to be strongly related to depth, with the highest correlations at mid-shelf stations.

### Installation

The easiest way to install this R package is to run
```
install.packages("devtools")
library(devtools)
install_github("michaeldumelle/DumelleEtAl2021CopepodSentinel")
```

The functions in this package eventually led to the creation of the *pairstats* package. Because *pairstats* was in beta at the time the paper was published, the functions used to analyze these data are included here.

### Data

Example data can be loaded by running
```
data(copepod)
```

### R Scripts

An example R script used for the analysis can be found by running
```
system.file("scripts/analysis.R", package = "DumelleEtAl2021CopepodSentinel")
```

### Vignette

A vignette providing additional examples of using the package's functions can be found by running (may need to edit first lines to install vignette)

### Source Document

Will copy from Overleaf when done but before resubmitting
