library(tidyr)
library(dplyr)
library(DumelleEtAl2021CopepodSentinel) # version 0.0.0.9000

data("copepod") # read in data
copepod_complete <- copepod %>%
  complete(nesting(stations, year), taxa, species) # fill in zero counts at ONLY
# stations that were sampled (had at least one non-zero response for that station
# year combination) using NA


# overall
copepod_taxa <- copepod_complete %>%
  group_by(stations, year, taxa) %>% # group by station, year, taxa combination
  summarize(la = mean(log10(abundance), na.rm = TRUE)) %>% # take aveage of non-NA values
  replace_na(replace = list(la = -Inf)) # set averages of NaN (which means there were no responses)
# equal to -Inf (as log10(0) = -Inf but a raw mean without prior removeal would affect the
# previous summarize() statement)


# species
copepod_species <- copepod_complete %>%
  group_by(stations, year, species) %>%
  summarize(la = mean(log10(abundance), na.rm = TRUE)) %>%
  replace_na(replace = list(la = -Inf)) # same approach for each species

# filter to only contain warm taxa
taxa_warm <- copepod_taxa %>%
  filter(taxa == "warm")

# run sentinel()
sentinel_taxa_warm <- sentinel(s_id = c("A", "B", "C", "D"), a_id = c("A", "B", "C", "D"),
                               id = "stations", group = "year", value = "la", data = taxa_warm,
                               n_min = 0, type = "correlation", output = c("overall", "individual", "dataset"),
                               method = "spearman")
# view output
sentinel_taxa_warm

# filter to only contain Species1
species_S1 <- copepod_species %>%
  filter(species == "Species1")

# run sentinel()
sentinel_species_S1 <- sentinel(s_id = c("A", "B", "C", "D"), a_id = c("A", "B", "C", "D"),
                                id = "stations", group = "year", value = "la", data = species_S1,
                                n_min = 0, type = "correlation", output = c("overall", "individual", "dataset"),
                                method = "spearman")
# View output
sentinel_species_S1
