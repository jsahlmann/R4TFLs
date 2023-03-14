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

# Die erste 4 Studienteilnehmer im Datensatz suchen
head(unique(ae$USUBJID), 4)

# Diesen willkürlich zu Demo-Zwecken eine Therapie zuweisen und einen weiteren Patienten ergänzen, der im Datensatz 
# ae nicht vorkommt.
# rep() ist eine Funktion zur Wiederholung eines Vektors.
# seq() gehört zu dieser Funktion dazu.
USUBJID = c('01-701-1015', '01-701-1023', '01-701-1028', '01-701-1034', '01-702-1001')
TRTP = c(rep(c("TRT_A", "TRT_B"), 2), "TRT_C")

Applied_TRT <- data.frame(USUBJID, TRTP)
Applied_TRT


# Alle Patienten, die ein Treatment haben.
inner_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) # %>% select(USUBJID) %>% unique() %>% count()

# Alle Patienten, die kein Treatment haben.
# Strings haben einen NA Wert.
left_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) %>% filter(is.na(TRTP)) %>% select(USUBJID) %>% unique() %>% count()

# Patienten mit Treatment und ohne AE.
right_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) %>% filter(is.na(AETERM))


