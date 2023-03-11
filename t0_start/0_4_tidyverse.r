library(tidyverse)

ae = read.csv(file = "data/ae.csv", sep = ",", header = TRUE, quote = "\"'")

head(ae)

summary(ae)

head(tibble::as_tibble(ae))

dplyr::glimpse(ae)

# select() wählt Variablen aus
# %>% wird als Piping-Operator bezeichnet, das Ergebnis links wird als Eingabe rechts an erster Stelle eingegeben.
# select() in dieser Form entspricht dem KEEP.
ae1 <- ae %>% select(DOMAIN, USUBJID, AEDECOD, AEBODSYS)
head(ae1)

# Die Domain soll ebenfalls entfernt werden. Mehrere Variablen werden als Vektor übergeben -c(DOMAIN, AEDECOD)
# select mit Minus-Zeichen entspricht dem DROP.
ae2 <- ae1 %>% select(-DOMAIN)
head(ae2)

ae %>% select(ends_with("DY")) %>% head()

ae %>% select(starts_with("AELLT")) %>% head()

ae %>% select(matches(".ST.")) %>% head()

ae1 %>% filter(AEDECOD == "ERYTHEMA") %>% head()

ae1 %>% filter(AEDECOD == "ERYTHEMA" & USUBJID == "01-701-1023") %>% head()

ae1 %>% filter(AEDECOD == "ERYTHEMA" | USUBJID == "01-701-1023") %>% head()

# Bestimmte Beobachtungen herausschneiden
head(ae1)
ae2 <- ae1 %>% slice(2:4)
ae2


