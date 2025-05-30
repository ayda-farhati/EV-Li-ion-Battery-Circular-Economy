library(bibliometrix)

# 1. Charger les fichiers

scopus <- convert2df(file = "scopus.bib", dbsource = "scopus", format = "bibtex")
scopus1 <- convert2df(file = "scopus1.bib", dbsource = "scopus", format = "bibtex")
scopus2 <- convert2df(file = "scopus2.bib", dbsource = "scopus", format = "bibtex")
scopus3 <- convert2df(file = "scopus3.bib", dbsource = "scopus", format = "bibtex")

science_direct1 <- convert2df(file = "sciencedirect1.bib", dbsource = "scopus", format = "bibtex")
science_direct2 <- convert2df(file = "sciencedirect2.bib", dbsource = "scopus", format = "bibtex")
science_direct3 <- convert2df(file = "sciencedirect3.bib", dbsource = "scopus", format = "bibtex")
science_direct4 <- convert2df(file = "sciencedirect4.bib", dbsource = "scopus", format = "bibtex")
science_direct5 <- convert2df(file = "sciencedirect5.bib", dbsource = "scopus", format = "bibtex")
science_direct6 <- convert2df(file = "sciencedirect6.bib", dbsource = "scopus", format = "bibtex")
science_direct7 <- convert2df(file = "sciencedirect7.bib", dbsource = "scopus", format = "bibtex")
science_direct8 <- convert2df(file = "sciencedirect8.bib", dbsource = "scopus", format = "bibtex")
science_direct9 <- convert2df(file = "sciencedirect9.bib", dbsource = "scopus", format = "bibtex")


wos <- convert2df(file = "wos.bib", dbsource = "wos", format = "bibtex")
wos1 <- convert2df(file = "wos1.bib", dbsource = "wos", format = "bibtex")
wos2 <- convert2df(file = "wos2.bib", dbsource = "wos", format = "bibtex")

# 2. Fusionner les trois bases
all_data <- mergeDbSources(list(scopus, scopus1, scopus2, scopus3, science_direct1, science_direct2, science_direct3, science_direct4, science_direct5, science_direct6, science_direct7, science_direct8, science_direct9, wos, wos1, wos2), remove.duplicated = FALSE)

# 3. Supprimer les doublons basés sur le titre
clean_data <- all_data[!duplicated(all_data[, c("TI", "DI")]), ]

# 4. Extraire la base sans doublons
data_nodup <- clean_data


# 5. Supprimer les documents publiés avant 2015
data_filtered <- subset(data_nodup, as.numeric(PY) >= 2015 & as.numeric(PY) <= 2024)

# 6. (Optionnel) Exporter la nouvelle base filtrée
write.csv(data_filtered, "base_filtrée_2015_2024.csv", row.names = FALSE)

biblioshiny()




