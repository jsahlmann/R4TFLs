# Einführung in tidyverse - Teil 1

tidyverse ist eine Sammlung von Paketen, die die Datenmanipulation standardisieren und erleichtern.

Wir arbeiten mit dem Datensatz ae weiter, den wir schon kennen.

Wir decken in dieser Datei die SAS-Konzepte 

* DROP / KEEP
* WHERE
* MERGE

ab.

## Daten laden


```R
library(tidyverse)
```

    ── [1mAttaching packages[22m ─────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.2 ──
    [32m✔[39m [34mggplot2[39m 3.4.0      [32m✔[39m [34mpurrr  [39m 0.3.5 
    [32m✔[39m [34mtibble [39m 3.1.8      [32m✔[39m [34mdplyr  [39m 1.0.10
    [32m✔[39m [34mtidyr  [39m 1.2.1      [32m✔[39m [34mstringr[39m 1.4.1 
    [32m✔[39m [34mreadr  [39m 2.1.3      [32m✔[39m [34mforcats[39m 0.5.2 
    ── [1mConflicts[22m ────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
    [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()
    


```R
ae = read.csv(file = "data/ae.csv", sep = ",", header = TRUE, quote = "\"'")
```


```R
head(ae)
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
summary(ae)
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
head(tibble::as_tibble(ae))
```


<table class="dataframe">
<caption>A tibble: 6 × 35</caption>
<thead>
	<tr><th scope=col>STUDYID</th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AESEQ</th><th scope=col>AESPID</th><th scope=col>AETERM</th><th scope=col>AELLT</th><th scope=col>AELLTCD</th><th scope=col>AEDECOD</th><th scope=col>AEPTCD</th><th scope=col>...</th><th scope=col>AESDISAB</th><th scope=col>AESDTH</th><th scope=col>AESHOSP</th><th scope=col>AESLIFE</th><th scope=col>AESOD</th><th scope=col>AEDTC</th><th scope=col>AESTDTC</th><th scope=col>AEENDTC</th><th scope=col>AESTDY</th><th scope=col>AEENDY</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>...</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>1</td><td>E07</td><td>APPLICATION SITE ERYTHEMA           </td><td>APPLICATION SITE REDNESS</td><td>NA</td><td>APPLICATION SITE ERYTHEMA           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-03</td><td>NA        </td><td> 2</td><td>NA</td></tr>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>2</td><td>E08</td><td>APPLICATION SITE PRURITUS           </td><td>APPLICATION SITE ITCHING</td><td>NA</td><td>APPLICATION SITE PRURITUS           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-03</td><td>NA        </td><td> 2</td><td>NA</td></tr>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1015</td><td>3</td><td>E06</td><td>DIARRHOEA                           </td><td>DIARRHEA                </td><td>NA</td><td>DIARRHOEA                           </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2014-01-16</td><td>2014-01-09</td><td>2014-01-11</td><td> 8</td><td>10</td></tr>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>3</td><td>E10</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>AV BLOCK SECOND DEGREE  </td><td>NA</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-26</td><td>NA        </td><td>22</td><td>NA</td></tr>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>1</td><td>E08</td><td>ERYTHEMA                            </td><td>ERYTHEMA                </td><td>NA</td><td>ERYTHEMA                            </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-07</td><td>2012-08-30</td><td> 3</td><td>26</td></tr>
	<tr><td>CDISCPILOT01</td><td>AE</td><td>01-701-1023</td><td>2</td><td>E09</td><td>ERYTHEMA                            </td><td>LOCALIZED ERYTHEMA      </td><td>NA</td><td>ERYTHEMA                            </td><td>NA</td><td>...</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>2012-08-27</td><td>2012-08-07</td><td>NA        </td><td> 3</td><td>NA</td></tr>
</tbody>
</table>




```R
dplyr::glimpse(ae)
```

    Rows: 1,191
    Columns: 35
    $ STUDYID  [3m[90m<chr>[39m[23m "CDISCPILOT01", "CDISCPILOT01", "CDISCPILOT01", "CDISCPILOT01…
    $ DOMAIN   [3m[90m<chr>[39m[23m "AE", "AE", "AE", "AE", "AE", "AE", "AE", "AE", "AE", "AE", "…
    $ USUBJID  [3m[90m<chr>[39m[23m "01-701-1015", "01-701-1015", "01-701-1015", "01-701-1023", "…
    $ AESEQ    [3m[90m<int>[39m[23m 1, 2, 3, 3, 1, 2, 4, 1, 2, 1, 2, 4, 1, 2, 3, 4, 10, 3, 1, 9, …
    $ AESPID   [3m[90m<chr>[39m[23m "E07", "E08", "E06", "E10", "E08", "E09", "E08", "E04", "E05"…
    $ AETERM   [3m[90m<chr>[39m[23m "APPLICATION SITE ERYTHEMA", "APPLICATION SITE PRURITUS", "DI…
    $ AELLT    [3m[90m<chr>[39m[23m "APPLICATION SITE REDNESS", "APPLICATION SITE ITCHING", "DIAR…
    $ AELLTCD  [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AEDECOD  [3m[90m<chr>[39m[23m "APPLICATION SITE ERYTHEMA", "APPLICATION SITE PRURITUS", "DI…
    $ AEPTCD   [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AEHLT    [3m[90m<chr>[39m[23m "HLT_0617", "HLT_0317", "HLT_0148", "HLT_0415", "HLT_0284", "…
    $ AEHLTCD  [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AEHLGT   [3m[90m<chr>[39m[23m "HLGT_0152", "HLGT_0338", "HLGT_0588", "HLGT_0086", "HLGT_019…
    $ AEHLGTCD [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AEBODSYS [3m[90m<chr>[39m[23m "GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS", "GENE…
    $ AEBDSYCD [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AESOC    [3m[90m<chr>[39m[23m "GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS", "GENE…
    $ AESOCCD  [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AESEV    [3m[90m<chr>[39m[23m "MILD", "MILD", "MILD", "MILD", "MILD", "MODERATE", "MILD", "…
    $ AESER    [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AEACN    [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ AEREL    [3m[90m<chr>[39m[23m "PROBABLE", "PROBABLE", "REMOTE", "POSSIBLE", "POSSIBLE", "PR…
    $ AEOUT    [3m[90m<chr>[39m[23m "NOT RECOVERED/NOT RESOLVED", "NOT RECOVERED/NOT RESOLVED", "…
    $ AESCAN   [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESCONG  [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESDISAB [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESDTH   [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESHOSP  [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESLIFE  [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AESOD    [3m[90m<chr>[39m[23m "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "…
    $ AEDTC    [3m[90m<chr>[39m[23m "2014-01-16", "2014-01-16", "2014-01-16", "2012-08-27", "2012…
    $ AESTDTC  [3m[90m<chr>[39m[23m "2014-01-03", "2014-01-03", "2014-01-09", "2012-08-26", "2012…
    $ AEENDTC  [3m[90m<chr>[39m[23m NA, NA, "2014-01-11", NA, "2012-08-30", NA, "2012-08-30", NA,…
    $ AESTDY   [3m[90m<int>[39m[23m 2, 2, 8, 22, 3, 3, 3, 3, 21, 58, 125, 27, 1, 1, 23, 52, 52, 5…
    $ AEENDY   [3m[90m<int>[39m[23m NA, NA, 10, NA, 26, NA, 26, NA, NA, NA, NA, NA, 1, 1, NA, NA,…
    

## DROP und KEEP: Variablenselektion
Das Paket dplyr hat den Befehl **select()**, mit dem Variablen eingeschlossen und ausgeschlossen werden können.



```R
# select() wählt Variablen aus
# %>% wird als Piping-Operator bezeichnet, das Ergebnis links wird als Eingabe rechts an erster Stelle eingegeben.
# select() in dieser Form entspricht dem KEEP.
ae1 <- ae %>% select(DOMAIN, USUBJID, AEDECOD, AEBODSYS)
head(ae1)
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>AE</td><td>01-701-1015</td><td>APPLICATION SITE ERYTHEMA           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>2</th><td>AE</td><td>01-701-1015</td><td>APPLICATION SITE PRURITUS           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>3</th><td>AE</td><td>01-701-1015</td><td>DIARRHOEA                           </td><td>GASTROINTESTINAL DISORDERS                          </td></tr>
	<tr><th scope=row>4</th><td>AE</td><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>CARDIAC DISORDERS                                   </td></tr>
	<tr><th scope=row>5</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
	<tr><th scope=row>6</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
</tbody>
</table>




```R
# Die Domain soll ebenfalls entfernt werden. Mehrere Variablen werden als Vektor übergeben -c(DOMAIN, AEDECOD)
# select mit Minus-Zeichen entspricht dem DROP.
ae2 <- ae1 %>% select(-DOMAIN)
head(ae2)
```


<table class="dataframe">
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>01-701-1015</td><td>APPLICATION SITE ERYTHEMA           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>2</th><td>01-701-1015</td><td>APPLICATION SITE PRURITUS           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>3</th><td>01-701-1015</td><td>DIARRHOEA                           </td><td>GASTROINTESTINAL DISORDERS                          </td></tr>
	<tr><th scope=row>4</th><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>CARDIAC DISORDERS                                   </td></tr>
	<tr><th scope=row>5</th><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
	<tr><th scope=row>6</th><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
</tbody>
</table>




```R
ae %>% select(ends_with("DY")) %>% head()
```


<table class="dataframe">
<caption>A data.frame: 6 × 2</caption>
<thead>
	<tr><th></th><th scope=col>AESTDY</th><th scope=col>AEENDY</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td> 2</td><td>NA</td></tr>
	<tr><th scope=row>2</th><td> 2</td><td>NA</td></tr>
	<tr><th scope=row>3</th><td> 8</td><td>10</td></tr>
	<tr><th scope=row>4</th><td>22</td><td>NA</td></tr>
	<tr><th scope=row>5</th><td> 3</td><td>26</td></tr>
	<tr><th scope=row>6</th><td> 3</td><td>NA</td></tr>
</tbody>
</table>




```R
ae %>% select(starts_with("AELLT")) %>% head()
```


<table class="dataframe">
<caption>A data.frame: 6 × 2</caption>
<thead>
	<tr><th></th><th scope=col>AELLT</th><th scope=col>AELLTCD</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>APPLICATION SITE REDNESS</td><td>NA</td></tr>
	<tr><th scope=row>2</th><td>APPLICATION SITE ITCHING</td><td>NA</td></tr>
	<tr><th scope=row>3</th><td>DIARRHEA                </td><td>NA</td></tr>
	<tr><th scope=row>4</th><td>AV BLOCK SECOND DEGREE  </td><td>NA</td></tr>
	<tr><th scope=row>5</th><td>ERYTHEMA                </td><td>NA</td></tr>
	<tr><th scope=row>6</th><td>LOCALIZED ERYTHEMA      </td><td>NA</td></tr>
</tbody>
</table>




```R
ae %>% select(matches(".ST.")) %>% head()
```


<table class="dataframe">
<caption>A data.frame: 6 × 2</caption>
<thead>
	<tr><th></th><th scope=col>AESTDTC</th><th scope=col>AESTDY</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>2014-01-03</td><td> 2</td></tr>
	<tr><th scope=row>2</th><td>2014-01-03</td><td> 2</td></tr>
	<tr><th scope=row>3</th><td>2014-01-09</td><td> 8</td></tr>
	<tr><th scope=row>4</th><td>2012-08-26</td><td>22</td></tr>
	<tr><th scope=row>5</th><td>2012-08-07</td><td> 3</td></tr>
	<tr><th scope=row>6</th><td>2012-08-07</td><td> 3</td></tr>
</tbody>
</table>



## WHERE: Selektion von Beobachtungen

Bedingungen können mit UND (&) und/oder ODER (|) verknüpft und mit Klammern priorisiert werden. Weitere boolsche Operatoren sind !, xor, any, all.

Folgende Operatoren stehen zur Verfügung:

* < : Kleiner als
* \> : Größer als
* == : Gleich
* <= : Kleiner oder gleich
* \>= : Größer oder gleich
* != : Ungleich
* %in% : ist enthalten in
* is.na : ist missing
* !is.na : ist nicht missing
* is.null : ist null
* !is.null : ist nicht null



```R
ae1 %>% filter(AEDECOD == "ERYTHEMA") %>% head()
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>2</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>3</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>4</th><td>AE</td><td>01-701-1097</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>5</th><td>AE</td><td>01-701-1111</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>6</th><td>AE</td><td>01-701-1111</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
</tbody>
</table>




```R
ae1 %>% filter(AEDECOD == "ERYTHEMA" & USUBJID == "01-701-1023") %>% head()
```


<table class="dataframe">
<caption>A data.frame: 3 × 4</caption>
<thead>
	<tr><th></th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>2</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>3</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA</td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
</tbody>
</table>




```R
ae1 %>% filter(AEDECOD == "ERYTHEMA" | USUBJID == "01-701-1023") %>% head()
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>AE</td><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>CARDIAC DISORDERS                     </td></tr>
	<tr><th scope=row>2</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>3</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>4</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>5</th><td>AE</td><td>01-701-1097</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
	<tr><th scope=row>6</th><td>AE</td><td>01-701-1111</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS</td></tr>
</tbody>
</table>




```R
# Bestimmte Beobachtungen herausschneiden
head(ae1)
ae2 <- ae1 %>% slice(2:4)
ae2
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>AE</td><td>01-701-1015</td><td>APPLICATION SITE ERYTHEMA           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>2</th><td>AE</td><td>01-701-1015</td><td>APPLICATION SITE PRURITUS           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><th scope=row>3</th><td>AE</td><td>01-701-1015</td><td>DIARRHOEA                           </td><td>GASTROINTESTINAL DISORDERS                          </td></tr>
	<tr><th scope=row>4</th><td>AE</td><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>CARDIAC DISORDERS                                   </td></tr>
	<tr><th scope=row>5</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
	<tr><th scope=row>6</th><td>AE</td><td>01-701-1023</td><td>ERYTHEMA                            </td><td>SKIN AND SUBCUTANEOUS TISSUE DISORDERS              </td></tr>
</tbody>
</table>




<table class="dataframe">
<caption>A data.frame: 3 × 4</caption>
<thead>
	<tr><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>AEDECOD</th><th scope=col>AEBODSYS</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>AE</td><td>01-701-1015</td><td>APPLICATION SITE PRURITUS           </td><td>GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS</td></tr>
	<tr><td>AE</td><td>01-701-1015</td><td>DIARRHOEA                           </td><td>GASTROINTESTINAL DISORDERS                          </td></tr>
	<tr><td>AE</td><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>CARDIAC DISORDERS                                   </td></tr>
</tbody>
</table>



### MERGE BY: Verknüpfen von Datensätzen

Vier grundsätzliche Typen:

* left_join
* right_join
* inner_join
* full_join

TODO: Visualisierung über Venn-Diagramme ergänzen


```R
# Die erste 4 Studienteilnehmer im Datensatz suchen
head(unique(ae$USUBJID), 4)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'01-701-1015'</li><li>'01-701-1023'</li><li>'01-701-1028'</li><li>'01-701-1034'</li></ol>




```R
# Diesen willkürlich zu Demo-Zwecken eine Therapie zuweisen und einen weiteren Patienten ergänzen, der im Datensatz 
# ae nicht vorkommt.
# rep() ist eine Funktion zur Wiederholung eines Vektors.
# seq() gehört zu dieser Funktion dazu.
USUBJID = c('01-701-1015', '01-701-1023', '01-701-1028', '01-701-1034', '01-702-1001')
TRTP = c(rep(c("TRT_A", "TRT_B"), 2), "TRT_C")

Applied_TRT <- data.frame(USUBJID, TRTP)
Applied_TRT

```


<table class="dataframe">
<caption>A data.frame: 5 × 2</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>TRTP</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>TRT_A</td></tr>
	<tr><td>01-701-1023</td><td>TRT_B</td></tr>
	<tr><td>01-701-1028</td><td>TRT_A</td></tr>
	<tr><td>01-701-1034</td><td>TRT_B</td></tr>
	<tr><td>01-702-1001</td><td>TRT_C</td></tr>
</tbody>
</table>




```R
# Alle Patienten, die ein Treatment haben.
inner_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) # %>% select(USUBJID) %>% unique() %>% count()
```


<table class="dataframe">
<caption>A data.frame: 11 × 3</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>AETERM</th><th scope=col>TRTP</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>APPLICATION SITE ERYTHEMA           </td><td>TRT_A</td></tr>
	<tr><td>01-701-1015</td><td>APPLICATION SITE PRURITUS           </td><td>TRT_A</td></tr>
	<tr><td>01-701-1015</td><td>DIARRHOEA                           </td><td>TRT_A</td></tr>
	<tr><td>01-701-1023</td><td>ATRIOVENTRICULAR BLOCK SECOND DEGREE</td><td>TRT_B</td></tr>
	<tr><td>01-701-1023</td><td>ERYTHEMA                            </td><td>TRT_B</td></tr>
	<tr><td>01-701-1023</td><td>ERYTHEMA                            </td><td>TRT_B</td></tr>
	<tr><td>01-701-1023</td><td>ERYTHEMA                            </td><td>TRT_B</td></tr>
	<tr><td>01-701-1028</td><td>APPLICATION SITE ERYTHEMA           </td><td>TRT_A</td></tr>
	<tr><td>01-701-1028</td><td>APPLICATION SITE PRURITUS           </td><td>TRT_A</td></tr>
	<tr><td>01-701-1034</td><td>APPLICATION SITE PRURITUS           </td><td>TRT_B</td></tr>
	<tr><td>01-701-1034</td><td>FATIGUE                             </td><td>TRT_B</td></tr>
</tbody>
</table>




```R
# Alle Patienten, die kein Treatment haben.
# Strings haben einen NA Wert.
left_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) %>% filter(is.na(TRTP)) %>% select(USUBJID) %>% unique() %>% count()
```


<table class="dataframe">
<caption>A data.frame: 1 × 1</caption>
<thead>
	<tr><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>221</td></tr>
</tbody>
</table>




```R
# Patienten mit Treatment und ohne AE.
right_join(ae, Applied_TRT, by = c("USUBJID")) %>% select(USUBJID, AETERM, TRTP) %>% filter(is.na(AETERM))
```


<table class="dataframe">
<caption>A data.frame: 1 × 3</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>AETERM</th><th scope=col>TRTP</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-702-1001</td><td>NA</td><td>TRT_C</td></tr>
</tbody>
</table>




```R

```
