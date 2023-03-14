library(tidyverse)

ae = read.csv(file = "data/ae.csv", sep = ",", header = TRUE, quote = "\"'")

# Wir wollen sehen, wie viele unterschiedliche Patienten AEs hatten
ae %>% group_by(USUBJID) %>% count() %>% ungroup()
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% nrow()
ae %>% nrow()

# Aufsteigend nach Zahl der AEs sortieren
# Sortieren nach mehreren Variablen, im Befehl **arrange()** in gewünschter Reihenfolge auflisten.
ae %>% arrange(AESTDY) %>% head() %>% select(USUBJID, AETERM, AESTDY)
#ae %>% filter(USUBJID == "01-705-1393")

# Gruppieren und sortieren
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% arrange(n)

# Absteigend nach Zahl der AEs sortieren
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% arrange(desc(n)) %>% head(10)

# Neuen Datensatz SDTM DM laden
dm = read.csv(file = "data/dm.csv", sep = ",", header = TRUE, quote = "\"'")
head(dm)
glimpse(dm)

# Nacharbeiten des Import
dm = read_csv(file = "data/dm.csv")


head(dm)

table(dm$RFICDTC)

dm = read_csv(file = "data/dm.csv", 
              col_types = list(
              RFICDTC = col_date(format = "")
              ))
head(dm)
table(dm$RFICDTC)

# Summary-Funktionen
# Mögliche "Fehlfunktionen" bei fehlenden Werten
dm %>% summarise(AGE_mean = mean(AGE))
dm %>% filter(is.na(AGE)) %>% count()
dm %>% summarise(AGE_mean = mean(AGE, na.rm = TRUE))

# Mehrere Summary-Funktionen möglich
ae %>% summarise(AESTDY_n = n(),
                 AESTDY_mean = mean(AESTDY),
                 AESTDY_sd = sd(AESTDY))

ae %>% summarise(AESTDY_n = n(),
                 AESTDY_mean = mean(AESTDY, na.rm = TRUE),
                 AESTDY_sd = sd(AESTDY, na.rm = TRUE))

# Mehrere Summary-Funktionen möglich
# Zusätzliches Gruppieren nach Treatment
dm %>% group_by(ACTARM) %>%
  summarise(AGE_n = n(),
            AGE_mean = mean(AGE, na.rm = TRUE),
            AGE_sd = sd(AGE, na.rm = TRUE))

# Welcher Patient hat als erstes welche Therapie bekommen?
dm1 <- dm %>% select(USUBJID, ACTARM, RFXSTDTC)
head(dm1)

# Sortieren nach ACTARM und RFXSTDTC
dm1 %>% arrange(ACTARM, RFXSTDTC) %>% head()

# Nutzen der first()- und last()-Funktionen
dm1 %>% arrange(ACTARM, RFXSTDTC) %>% group_by(ACTARM) %>% 
  summarise(trt_first = first(USUBJID),
            trt_last = last(USUBJID)) %>% 
  ungroup()

head(dm1)

# Alternativer Ansatz unter Beibehaltung aller Daten und 
# anschließendem Filtern
dm2 <- dm1 %>% arrange(ACTARM, RFXSTDTC) %>% 
         group_by(ACTARM) %>% 
         mutate(id = row_number()) %>%
         mutate(id_min = min(id)) %>%
         mutate(id_max = max(id)) %>%
         ungroup()
head(dm2)

# Filtern kann auch nur für eine Bedingung erfolgen, um first und last getrennt zu erhalten.
dm2 %>% filter(id == id_min | id == id_max)

dm3 <- dm %>% select(USUBJID, ACTARM, RFXSTDTC, RFXENDTC)
head(dm3)

# Wir erhalten ein Datendifferenz-Objekt.
dm3 %>% mutate(dd = RFXENDTC - RFXSTDTC) %>% head()

# Jetzt gibt es einen Integerwert.
dm3 %>% mutate(dd = as.integer(RFXENDTC - RFXSTDTC)) %>% head()

# Alternative Zuweisung über $ möglich
# Geschmackssache ...
dm3$dd <- as.integer(dm3$RFXENDTC - dm3$RFXSTDTC)
head(dm3)


