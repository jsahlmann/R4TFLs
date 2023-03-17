# Datenstrukturen

## Data Frames
Data Frames stellen eine bestimmte Form einer zweidimensionalen Datenstrukturen dar.

Sie ähneln am ehesten einem SAS Data Set.

Die Senkrechten sind die Variablen, die Waagerechten entsprechen den Beobachtungen.


Sie bestehen aus einer bis vielen Beobachtungen verschiedener Datentypen, die alle ins sich von der Struktur gleich sind.



### Erzeugung von Data Frames aus Vektoren


```R
# Data Frame aus drei Vektoren
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Id" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df
```


<table class="dataframe">
<caption>A data.frame: 4 × 3</caption>
<thead>
	<tr><th scope=col>Id</th><th scope=col>Farbe</th><th scope=col>Abgeschlossen</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>rot </td><td> TRUE</td></tr>
	<tr><td>2</td><td>gelb</td><td>FALSE</td></tr>
	<tr><td>3</td><td>rot </td><td>FALSE</td></tr>
	<tr><td>4</td><td>grün</td><td> TRUE</td></tr>
</tbody>
</table>




```R
# Data Frame aus vier Vektoren
# v0 wird 4x recycelt
v0 <- "ABC"
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Study" = v0, "PatId" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df
```


<table class="dataframe">
<caption>A data.frame: 4 × 4</caption>
<thead>
	<tr><th scope=col>Study</th><th scope=col>PatId</th><th scope=col>Farbe</th><th scope=col>Abgeschlossen</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>ABC</td><td>1</td><td>rot </td><td> TRUE</td></tr>
	<tr><td>ABC</td><td>2</td><td>gelb</td><td>FALSE</td></tr>
	<tr><td>ABC</td><td>3</td><td>rot </td><td>FALSE</td></tr>
	<tr><td>ABC</td><td>4</td><td>grün</td><td> TRUE</td></tr>
</tbody>
</table>




```R
# Data Frame aus vier Vektoren
# v0 wird 2x recycelt
v0 <- c("ABC", "BCD")
v1 <- c(1, 2, 3, 4)
v2 <- c("rot", "gelb", "rot", "grün")
v3 <- c(T, F, F, T)
df <- data.frame("Study" = v0, "PatId" = v1, "Farbe" = v2, "Abgeschlossen" = v3)
df
```


<table class="dataframe">
<caption>A data.frame: 4 × 4</caption>
<thead>
	<tr><th scope=col>Study</th><th scope=col>PatId</th><th scope=col>Farbe</th><th scope=col>Abgeschlossen</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>ABC</td><td>1</td><td>rot </td><td> TRUE</td></tr>
	<tr><td>BCD</td><td>2</td><td>gelb</td><td>FALSE</td></tr>
	<tr><td>ABC</td><td>3</td><td>rot </td><td>FALSE</td></tr>
	<tr><td>BCD</td><td>4</td><td>grün</td><td> TRUE</td></tr>
</tbody>
</table>




```R
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
```
Error in data.frame(Study = v0, PatId = v1, Farbe = v2, Abgeschlossen = v3): Argumente implizieren unterschiedliche Anzahl Zeilen: 3, 4
Traceback:

1. data.frame(Study = v0, PatId = v1, Farbe = v2, Abgeschlossen = v3)
2. stop(gettextf("arguments imply differing number of rows: %s", 
 .     paste(unique(nrows), collapse = ", ")), domain = NA)
### Erzeugung von Data Frames aus Rohdaten

Diese Möglichkeit entspricht in R am ehesten den Datalines für einfache Datensätze zur Demonstration.

Die Datenzeilen können aus einer CSV-Datei herauskopiert werden und in das R-Programm eingefügt werden.


```R
# Datenzeilen als CSV-String laden
CSV_text_string = "STUDYID, USUBJID, AGE, GENDER, RFICDTC
'XYZ', 'S001', 33, 'M', '2023-01-02'
'XYZ', 'S002', 43, 'F', '2023-01-03'
'XYZ', 'S003', 24, 'F', '2023-01-03'
'XYZ', 'S004', 19, 'M', '2023-01-04'
"

df = read.csv(text = CSV_text_string, header = TRUE, quote = "\"'")
df
```


<table class="dataframe">
<caption>A data.frame: 4 × 5</caption>
<thead>
	<tr><th scope=col>STUDYID</th><th scope=col>USUBJID</th><th scope=col>AGE</th><th scope=col>GENDER</th><th scope=col>RFICDTC</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>XYZ</td><td> S001</td><td>33</td><td> M</td><td> 2023-01-02</td></tr>
	<tr><td>XYZ</td><td> S002</td><td>43</td><td> F</td><td> 2023-01-03</td></tr>
	<tr><td>XYZ</td><td> S003</td><td>24</td><td> F</td><td> 2023-01-03</td></tr>
	<tr><td>XYZ</td><td> S004</td><td>19</td><td> M</td><td> 2023-01-04</td></tr>
</tbody>
</table>



Zwischenbemerkung:

Es gibt auch Datumswerte. Diese kann man aus Strings erzeugen und in Variablen abspeichern.

Wenn man einfacher mit Datumswerten arbeiten will, sollte man sich das Paket **lubridate** anschauen. Das erleichtert vieles im Zusammenhang mit der Verarbeitung von Datumswerten.


```R
# Datumsvariable generieren
# R: Referenzdatum 01-Jan-1970
# SAS: Referenzdatum 01-Jan-1960
d <- as.Date('2023-01-02')
d
```


<time datetime="2023-01-02">2023-01-02</time>



```R
typeof(d)
```


'double'



```R
str(d)
```

     Date[1:1], format: "2023-01-02"
    


```R
as.integer(d)
```


19359



```R
# Datumsdifferenzen ermitteln, das Ergebnis ist ein Objekt Datumsdifferenz.
d1 <- as.Date('2023-01-02')
d2 <- as.Date('28-02-2023', format = "%d-%m-%Y")
dd <- d2 - d1
dd
```


    Time difference of 57 days



```R
# Dieses Objekt wird vor der Weiterverarbeitung in einen Integerwert für Datumsdifferenzen umgewandelt.
as.integer(dd)
```


57


### Erzeugung von Data Frames aus CSV-Dateien

Die Syntax des Befehls entspricht derjenigen, die bereits oben benutzt worden ist.

Der Parameter **text** wird durch den Parameter **file** ersetzt.

Weitere Informationen zu den Parametern findet man in der Hilfe.

Dazu gibt man auf der Kommandozeile *?read.csv()* ein.

Die hier benutzte Datei kann unter __[Safety Data](https://github.com/SafetyGraphics/safetyData)__ <https://github.com/SafetyGraphics/safetyData> (Letzter Zugriff 10.03.2023) heruntergeladen werden. Sie ist in den Kursunterlagen auf GitHub bereitgestellt.

Sie ist ebenfalls Teil des R-Pakets **safetyData**.


```R
# CSV-Datei einlesen.
df = read.csv(file = "data/ae.csv", sep = ",", header = TRUE, quote = "\"'")
```


```R
# Einfache Zusammenfassung ausgeben.
summary(df)
```


       STUDYID             DOMAIN            USUBJID              AESEQ      
     Length:1191        Length:1191        Length:1191        Min.   : 1.00  
     Class :character   Class :character   Class :character   1st Qu.: 2.00  
     Mode  :character   Mode  :character   Mode  :character   Median : 4.00  
                                                              Mean   : 4.53  
                                                              3rd Qu.: 6.00  
                                                              Max.   :23.00  
                                                                             
        AESPID             AETERM             AELLT           AELLTCD       
     Length:1191        Length:1191        Length:1191        Mode:logical  
     Class :character   Class :character   Class :character   NA's:1191     
     Mode  :character   Mode  :character   Mode  :character                 
                                                                            
                                                                            
                                                                            
                                                                            
       AEDECOD           AEPTCD           AEHLT           AEHLTCD       
     Length:1191        Mode:logical   Length:1191        Mode:logical  
     Class :character   NA's:1191      Class :character   NA's:1191     
     Mode  :character                  Mode  :character                 
                                                                        
                                                                        
                                                                        
                                                                        
        AEHLGT          AEHLGTCD         AEBODSYS         AEBDSYCD      
     Length:1191        Mode:logical   Length:1191        Mode:logical  
     Class :character   NA's:1191      Class :character   NA's:1191     
     Mode  :character                  Mode  :character                 
                                                                        
                                                                        
                                                                        
                                                                        
        AESOC           AESOCCD           AESEV              AESER          
     Length:1191        Mode:logical   Length:1191        Length:1191       
     Class :character   NA's:1191      Class :character   Class :character  
     Mode  :character                  Mode  :character   Mode  :character  
                                                                            
                                                                            
                                                                            
                                                                            
      AEACN            AEREL              AEOUT              AESCAN         
     Mode:logical   Length:1191        Length:1191        Length:1191       
     NA's:1191      Class :character   Class :character   Class :character  
                    Mode  :character   Mode  :character   Mode  :character  
                                                                            
                                                                            
                                                                            
                                                                            
       AESCONG            AESDISAB            AESDTH            AESHOSP         
     Length:1191        Length:1191        Length:1191        Length:1191       
     Class :character   Class :character   Class :character   Class :character  
     Mode  :character   Mode  :character   Mode  :character   Mode  :character  
                                                                                
                                                                                
                                                                                
                                                                                
       AESLIFE             AESOD              AEDTC             AESTDTC         
     Length:1191        Length:1191        Length:1191        Length:1191       
     Class :character   Class :character   Class :character   Class :character  
     Mode  :character   Mode  :character   Mode  :character   Mode  :character  
                                                                                
                                                                                
                                                                                
                                                                                
       AEENDTC              AESTDY            AEENDY      
     Length:1191        Min.   :-277.00   Min.   : -2.00  
     Class :character   1st Qu.:  15.00   1st Qu.: 27.00  
     Mode  :character   Median :  32.00   Median : 53.00  
                        Mean   :  45.83   Mean   : 67.14  
                        3rd Qu.:  63.00   3rd Qu.:101.25  
                        Max.   : 366.00   Max.   :211.00  
                        NA's   :26        NA's   :473     



```R
# Die ersten sechs Zeilen darstellen.
head(df)
```


<table class="dataframe">
<caption>A data.frame: 6 × 35</caption>
<thead>
	<tr><th></th><th scope=col>STUDYID</th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AESEQ</th><th scope=col>AESPID</th><th scope=col>AETERM</th><th scope=col>AELLT</th><th scope=col>AELLTCD</th><th scope=col>AEDECOD</th><th scope=col>AEPTCD</th><th scope=col>...</th><th scope=col>AESDISAB</th><th scope=col>AESDTH</th><th scope=col>AESHOSP</th><th scope=col>AESLIFE</th><th scope=col>AESOD</th><th scope=col>AEDTC</th><th scope=col>AESTDTC</th><th scope=col>AEENDTC</th><th scope=col>AESTDY</th><th scope=col>AEENDY</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>...</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>1</td><td>E07</td><td>APPLICATION SITE ERYTHEMA           </td><td>APPLICATION SITE REDNESS</td><td>NA</td><td>APPLICATION SITE ERYTHEMA           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-03</td><td>NA        </td><td> 2</td><td>NA</td></tr>
	<tr><th scope=row>2</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>2</td><td>E08</td><td>APPLICATION SITE PRURITUS           </td><td>APPLICATION SITE ITCHING</td><td>NA</td><td>APPLICATION SITE PRURITUS           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-03</td><td>NA        </td><td> 2</td><td>NA</td></tr>
	<tr><th scope=row>3</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>3</td><td>E06</td><td>DIARRHOEA                           </td><td>DIARRHEA                </td><td>NA</td><td>DIARRHOEA                           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-09</td><td>2014-01-11</td><td> 8</td><td>10</td></tr>
	<tr><th scope=row>4</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>3</td><td>E10</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>AV BLOCK SECOND DEGREE  </td><td>NA</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-26</td><td>NA        </td><td>22</td><td>NA</td></tr>
	<tr><th scope=row>5</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>1</td><td>E08</td><td>ERYTHEMA                            </td><td>ERYTHEMA                </td><td>NA</td><td>ERYTHEMA                            </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-07</td><td>2012-08-30</td><td> 3</td><td>26</td></tr>
	<tr><th scope=row>6</th><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>2</td><td>E09</td><td>ERYTHEMA                            </td><td>LOCALIZED ERYTHEMA      </td><td>NA</td><td>ERYTHEMA                            </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-07</td><td>NA        </td><td> 3</td><td>NA</td></tr>
</tbody>
</table>




```R
# Die ersten 6 Zeilen der Häufigkeitstabelle darstellen.
head(table(df$AEBODSYS))
```


    
                                       CARDIAC DISORDERS 
                                                      91 
              CONGENITAL, FAMILIAL AND GENETIC DISORDERS 
                                                       3 
                             EAR AND LABYRINTH DISORDERS 
                                                       6 
                                           EYE DISORDERS 
                                                      12 
                              GASTROINTESTINAL DISORDERS 
                                                      87 
    GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS 
                                                     292 



```R
# Zeige die ersten 10 Einträge
head(table(df$AEDECOD), 10)
```


    
               ABDOMINAL DISCOMFORT                  ABDOMINAL PAIN 
                                  1                               6 
               ACROCHORDON EXCISION               ACTINIC KERATOSIS 
                                  1                               1 
                          AGITATION                     ALCOHOL USE 
                                  5                               1 
    ALLERGIC GRANULOMATOUS ANGIITIS                        ALOPECIA 
                                  1                               1 
                            AMNESIA                         ANXIETY 
                                  2                               6 



```R
# Zeige die letzten 10 Einträge
tail(table(df$AEDECOD), 10)
```


    
           VENTRICULAR SEPTAL DEFECT                          VERTIGO 
                                   3                                2 
                     VIRAL INFECTION                   VISION BLURRED 
                                   1                                3 
                            VOMITING                 WEIGHT DECREASED 
                                  16                                2 
    WHITE BLOOD CELL COUNT INCREASED   WOLFF-PARKINSON-WHITE SYNDROME 
                                   2                                2 
                               WOUND                WOUND HAEMORRHAGE 
                                   2                                1 


Mit diesem Datensatz werden wir jetzt weiterarbeiten und uns die Möglichkeiten von **tidyverse** anschauen.


```R

```
