# Data Frame aus drei Vektoren
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Id" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df

# Data Frame aus vier Vektoren
# v0 wird 4x recycelt
v0 <- "ABC"
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Study" = v0, "PatId" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df

# Data Frame aus vier Vektoren
# v0 wird 2x recycelt
v0 <- c("ABC", "BCD")
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Study" = v0, "PatId" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df

# Data Frame aus vier Vektoren
# v0 ist von der Länge kein Vielfaches der anderen Vektoren, daher gibt es eine Fehlermeldung beim Zusammenführen.
v0 <- c("ABC", "BCD", "CDE")
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
#df <- data.frame("Study" = v0, "PatId" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
#df
# Die vorigen beiden Zeilen sind nicht ausgeführt worden.
# Die Fehlermeldung in der nächsten Zelle wurde händisch kopiert.
Error in data.frame(Study = v0, PatId = v1, Farbe = v2, Abgeschlossen = v3): Argumente implizieren unterschiedliche Anzahl Zeilen: 3, 4
Traceback:

1. data.frame(Study = v0, PatId = v1, Farbe = v2, Abgeschlossen = v3)
2. stop(gettextf("arguments imply differing number of rows: %s", 
 .     paste(unique(nrows), collapse = ", ")), domain = NA)
# Datenzeilen als CSV-String laden
CSV_text_string = "STUDYID, USUBJID, AGE, GENDER, RFICDTC
'XYZ', 'S001', 33, 'M', '2023-01-02'
'XYZ', 'S002', 43, 'F', '2023-01-03'
'XYZ', 'S003', 24, 'F', '2023-01-03'
'XYZ', 'S004', 19, 'M', '2023-01-04'
"

df = read.csv(text = CSV_text_string, header = TRUE, quote = "\"'")
df

# Datumsvariable generieren
# R: Referenzdatum 01-Jan-1970
# SAS: Referenzdatum 01-Jan-1960
d <- as.Date('2023-01-02')
d

typeof(d)

str(d)

as.integer(d)

# Datumsdifferenzen ermitteln, das Ergebnis ist ein Objekt Datumsdifferenz.
d1 <- as.Date('2023-01-02')
d2 <- as.Date('28-02-2023', format = "%d-%m-%Y")
dd <- d2 - d1
dd

# Dieses Objekt wird vor der Weiterverarbeitung in einen Integerwert für Datumsdifferenzen umgewandelt.
as.integer(dd)

# CSV-Datei einlesen.
df = read.csv(file = "data/ae.csv", sep = ",", header = TRUE, quote = "\"'")

# Einfache Zusammenfassung ausgeben.
summary(df)

# Die ersten sechs Zeilen darstellen.
head(df)

# Die ersten 6 Zeilen der Häufigkeitstabelle darstellen.
head(table(df$AEBODSYS))

# Zeige die ersten 10 Einträge
head(table(df$AEDECOD), 10)

# Zeige die letzten 10 Einträge
tail(table(df$AEDECOD), 10)


