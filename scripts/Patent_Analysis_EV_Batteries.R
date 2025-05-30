# Charger les packages nécessaires (à écrire dans le script)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(countrycode)
library(treemapify)
library(igraph)

brevets <- read_csv("lens-export.csv")
head(brevets)
colnames(brevets)

library(dplyr)

brevets %>%
  count(Jurisdiction, sort = TRUE)

brevets %>%
  count(`Publication Year`, sort = FALSE)

# "Annual Evolution of Patents"
library(ggplot2)
ggplot(brevets, aes(x = `Extended Family Size`)) +
  geom_histogram(binwidth = 1, fill = "purple", color = "white") +
  labs(title = "Distribution of Extended Family Size", x = "Family Size", y = "Frequency") +
  theme_minimal()



brevets %>%
  count(`Publication Year`) %>%
  ggplot(aes(x = `Publication Year`, y = n)) +
  geom_col(fill = "#0073C2FF") +
  labs(
    title = "Annual Evolution of Patents",
    x = "Year",
    y = "Number of patents"
  ) +
  theme_minimal()

# "Top 10 Filing Jurisdictions"

brevets %>%
  count(Jurisdiction, sort = TRUE) %>%
  top_n(10) %>%
  ggplot(aes(x = reorder(Jurisdiction, n), y = n)) +
  geom_col(fill = "#E69F00") +
  coord_flip() +
  labs(title = "Top 10 Filing Jurisdictions", x = "Jurisdiction", y = "Number of Patents")


# "Distribution of Extended Family Size"
ggplot(brevets, aes(x = `Extended Family Size`)) +
  geom_histogram(binwidth = 1, fill = "purple", color = "white") +
  labs(title = "Distribution of Extended Family Size", x = "Family Size", y = "Frequency") +
  theme_minimal()


# "Top 10 Applicants"
# Charger les bibliothèques nécessaires
library(tidyverse)
library(readr)

# Charger les données
brevets <- read_csv("lens-export.csv")

# Nettoyer et préparer les données des demandeurs
top_applicants <- brevets %>%
  filter(!is.na(Applicants)) %>%                # Retirer les lignes vides
  count(Applicants, sort = TRUE) %>%            # Compter les occurrences
  slice_max(n, n = 10)                          # Garder les 10 plus fréquents

# Créer le graphique
ggplot(top_applicants, aes(x = reorder(Applicants, n), y = n)) +
  geom_col(fill = "#1f77b4") +
  coord_flip() +
  labs(title = "Top 10 Applicants", x = "Applicant", y = "Number of Patents") +
  theme_minimal()

brevets %>% 
  count(Jurisdiction, sort = TRUE)

# "Top 10 Most Cited Patents"
brevets %>%
  arrange(desc(`Cited by Patent Count`)) %>%
  select(Title, `Cited by Patent Count`) %>%
  head(10) %>%
  ggplot(aes(x = reorder(Title, `Cited by Patent Count`), y = `Cited by Patent Count`)) +
  geom_col(fill = "#56B4E9") +
  coord_flip() +
  labs(title = "Top 10 Most Cited Patents",
       x = "Patent Title",
       y = "Number of Citations") +
  theme_minimal()

library(readr)
library(dplyr)
library(stringr)

# Charger les données Lens
brevets <- read_csv("lens-export.csv")

# Créer une colonne "texte" combinant titre + résumé
brevets <- brevets %>%
  mutate(texte = paste(Title, Abstract, sep = ". ")) %>%
  select(texte)

# Nettoyer le texte (enlever les sauts de ligne)
brevets$texte <- str_replace_all(brevets$texte, "[\r\n]", " ")

# Sauvegarder dans un fichier texte
write_lines(brevets$texte, "vosviewer_keywords.txt")
