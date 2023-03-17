# Einführung in tidyverse - Teil 2

Es geht weiter mit tidyverse.

Wir arbeiten mit dem Datensatz ae weiter, den wir schon kennen.

Wir decken in dieser Datei die SAS-Konzepte 

* PROC SORT
* FIRST / LAST
* BY

ab.

## Daten laden

Nur, wenn das Programm zwischenzeitlich beendet worden ist.


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
# Wir wollen sehen, wie viele unterschiedliche Patienten AEs hatten
ae %>% group_by(USUBJID) %>% count() %>% ungroup()
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% nrow()
ae %>% nrow()
```


<table class="dataframe">
<caption>A tibble: 225 × 2</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td> 3</td></tr>
	<tr><td>01-701-1023</td><td> 4</td></tr>
	<tr><td>01-701-1028</td><td> 2</td></tr>
	<tr><td>01-701-1034</td><td> 2</td></tr>
	<tr><td>01-701-1047</td><td> 4</td></tr>
	<tr><td>01-701-1097</td><td>10</td></tr>
	<tr><td>01-701-1111</td><td> 8</td></tr>
	<tr><td>01-701-1115</td><td> 9</td></tr>
	<tr><td>01-701-1118</td><td> 1</td></tr>
	<tr><td>01-701-1130</td><td> 8</td></tr>
	<tr><td>01-701-1133</td><td> 4</td></tr>
	<tr><td>01-701-1146</td><td>11</td></tr>
	<tr><td>01-701-1148</td><td>10</td></tr>
	<tr><td>01-701-1153</td><td> 2</td></tr>
	<tr><td>01-701-1180</td><td> 9</td></tr>
	<tr><td>01-701-1181</td><td> 1</td></tr>
	<tr><td>01-701-1188</td><td> 8</td></tr>
	<tr><td>01-701-1192</td><td>15</td></tr>
	<tr><td>01-701-1203</td><td> 1</td></tr>
	<tr><td>01-701-1211</td><td> 9</td></tr>
	<tr><td>01-701-1239</td><td>10</td></tr>
	<tr><td>01-701-1275</td><td>15</td></tr>
	<tr><td>01-701-1287</td><td> 5</td></tr>
	<tr><td>01-701-1294</td><td> 6</td></tr>
	<tr><td>01-701-1302</td><td>23</td></tr>
	<tr><td>01-701-1317</td><td> 9</td></tr>
	<tr><td>01-701-1324</td><td> 4</td></tr>
	<tr><td>01-701-1341</td><td> 5</td></tr>
	<tr><td>01-701-1360</td><td> 3</td></tr>
	<tr><td>01-701-1363</td><td> 6</td></tr>
	<tr><td>...</td><td>...</td></tr>
	<tr><td>01-716-1177</td><td> 1</td></tr>
	<tr><td>01-716-1189</td><td> 4</td></tr>
	<tr><td>01-716-1229</td><td> 2</td></tr>
	<tr><td>01-716-1298</td><td> 6</td></tr>
	<tr><td>01-716-1308</td><td> 1</td></tr>
	<tr><td>01-716-1311</td><td> 4</td></tr>
	<tr><td>01-716-1364</td><td> 2</td></tr>
	<tr><td>01-716-1373</td><td> 2</td></tr>
	<tr><td>01-716-1418</td><td>10</td></tr>
	<tr><td>01-716-1441</td><td> 1</td></tr>
	<tr><td>01-716-1447</td><td> 5</td></tr>
	<tr><td>01-717-1004</td><td>19</td></tr>
	<tr><td>01-717-1109</td><td> 8</td></tr>
	<tr><td>01-717-1174</td><td> 6</td></tr>
	<tr><td>01-717-1201</td><td> 2</td></tr>
	<tr><td>01-717-1344</td><td> 5</td></tr>
	<tr><td>01-717-1357</td><td> 9</td></tr>
	<tr><td>01-717-1446</td><td> 9</td></tr>
	<tr><td>01-718-1066</td><td> 4</td></tr>
	<tr><td>01-718-1079</td><td> 3</td></tr>
	<tr><td>01-718-1101</td><td> 6</td></tr>
	<tr><td>01-718-1139</td><td> 3</td></tr>
	<tr><td>01-718-1150</td><td>10</td></tr>
	<tr><td>01-718-1170</td><td> 6</td></tr>
	<tr><td>01-718-1250</td><td>11</td></tr>
	<tr><td>01-718-1254</td><td> 9</td></tr>
	<tr><td>01-718-1328</td><td> 4</td></tr>
	<tr><td>01-718-1355</td><td>13</td></tr>
	<tr><td>01-718-1371</td><td> 6</td></tr>
	<tr><td>01-718-1427</td><td>16</td></tr>
</tbody>
</table>




225



1191


## Daten sortieren


```R
# Aufsteigend nach Zahl der AEs sortieren
# Sortieren nach mehreren Variablen, im Befehl **arrange()** in gewünschter Reihenfolge auflisten.
ae %>% arrange(AESTDY) %>% head() %>% select(USUBJID, AETERM, AESTDY)
#ae %>% filter(USUBJID == "01-705-1393")
```


<table class="dataframe">
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th></th><th scope=col>USUBJID</th><th scope=col>AETERM</th><th scope=col>AESTDY</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>01-705-1393</td><td>PRURITUS           </td><td>-277</td></tr>
	<tr><th scope=row>2</th><td>01-705-1393</td><td>PRURITUS           </td><td>-277</td></tr>
	<tr><th scope=row>3</th><td>01-711-1433</td><td>HYPERTENSION       </td><td>-188</td></tr>
	<tr><th scope=row>4</th><td>01-711-1433</td><td>HYPERTENSION       </td><td>-188</td></tr>
	<tr><th scope=row>5</th><td>01-704-1388</td><td>HEADACHE           </td><td>-106</td></tr>
	<tr><th scope=row>6</th><td>01-701-1111</td><td>LOCALISED INFECTION</td><td> -61</td></tr>
</tbody>
</table>




```R
# Gruppieren und sortieren
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% arrange(n)
```


<table class="dataframe">
<caption>A tibble: 225 × 2</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1118</td><td>1</td></tr>
	<tr><td>01-701-1181</td><td>1</td></tr>
	<tr><td>01-701-1203</td><td>1</td></tr>
	<tr><td>01-701-1442</td><td>1</td></tr>
	<tr><td>01-703-1175</td><td>1</td></tr>
	<tr><td>01-703-1295</td><td>1</td></tr>
	<tr><td>01-704-1218</td><td>1</td></tr>
	<tr><td>01-704-1388</td><td>1</td></tr>
	<tr><td>01-704-1435</td><td>1</td></tr>
	<tr><td>01-704-1445</td><td>1</td></tr>
	<tr><td>01-705-1031</td><td>1</td></tr>
	<tr><td>01-705-1059</td><td>1</td></tr>
	<tr><td>01-705-1186</td><td>1</td></tr>
	<tr><td>01-705-1280</td><td>1</td></tr>
	<tr><td>01-708-1032</td><td>1</td></tr>
	<tr><td>01-708-1372</td><td>1</td></tr>
	<tr><td>01-709-1301</td><td>1</td></tr>
	<tr><td>01-709-1424</td><td>1</td></tr>
	<tr><td>01-710-1083</td><td>1</td></tr>
	<tr><td>01-710-1187</td><td>1</td></tr>
	<tr><td>01-713-1073</td><td>1</td></tr>
	<tr><td>01-714-1425</td><td>1</td></tr>
	<tr><td>01-715-1207</td><td>1</td></tr>
	<tr><td>01-715-1319</td><td>1</td></tr>
	<tr><td>01-716-1177</td><td>1</td></tr>
	<tr><td>01-716-1308</td><td>1</td></tr>
	<tr><td>01-716-1441</td><td>1</td></tr>
	<tr><td>01-701-1028</td><td>2</td></tr>
	<tr><td>01-701-1034</td><td>2</td></tr>
	<tr><td>01-701-1153</td><td>2</td></tr>
	<tr><td>...</td><td>...</td></tr>
	<tr><td>01-717-1357</td><td> 9</td></tr>
	<tr><td>01-717-1446</td><td> 9</td></tr>
	<tr><td>01-718-1254</td><td> 9</td></tr>
	<tr><td>01-701-1097</td><td>10</td></tr>
	<tr><td>01-701-1148</td><td>10</td></tr>
	<tr><td>01-701-1239</td><td>10</td></tr>
	<tr><td>01-702-1082</td><td>10</td></tr>
	<tr><td>01-704-1065</td><td>10</td></tr>
	<tr><td>01-706-1384</td><td>10</td></tr>
	<tr><td>01-716-1418</td><td>10</td></tr>
	<tr><td>01-718-1150</td><td>10</td></tr>
	<tr><td>01-701-1146</td><td>11</td></tr>
	<tr><td>01-709-1217</td><td>11</td></tr>
	<tr><td>01-709-1259</td><td>11</td></tr>
	<tr><td>01-718-1250</td><td>11</td></tr>
	<tr><td>01-701-1383</td><td>12</td></tr>
	<tr><td>01-708-1272</td><td>12</td></tr>
	<tr><td>01-710-1006</td><td>12</td></tr>
	<tr><td>01-710-1045</td><td>13</td></tr>
	<tr><td>01-718-1355</td><td>13</td></tr>
	<tr><td>01-711-1143</td><td>14</td></tr>
	<tr><td>01-701-1192</td><td>15</td></tr>
	<tr><td>01-701-1275</td><td>15</td></tr>
	<tr><td>01-709-1309</td><td>15</td></tr>
	<tr><td>01-713-1179</td><td>15</td></tr>
	<tr><td>01-704-1266</td><td>16</td></tr>
	<tr><td>01-709-1029</td><td>16</td></tr>
	<tr><td>01-718-1427</td><td>16</td></tr>
	<tr><td>01-717-1004</td><td>19</td></tr>
	<tr><td>01-701-1302</td><td>23</td></tr>
</tbody>
</table>




```R
# Absteigend nach Zahl der AEs sortieren
ae %>% group_by(USUBJID) %>% count() %>% ungroup() %>% arrange(desc(n)) %>% head(10)
```


<table class="dataframe">
<caption>A tibble: 10 × 2</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1302</td><td>23</td></tr>
	<tr><td>01-717-1004</td><td>19</td></tr>
	<tr><td>01-704-1266</td><td>16</td></tr>
	<tr><td>01-709-1029</td><td>16</td></tr>
	<tr><td>01-718-1427</td><td>16</td></tr>
	<tr><td>01-701-1192</td><td>15</td></tr>
	<tr><td>01-701-1275</td><td>15</td></tr>
	<tr><td>01-709-1309</td><td>15</td></tr>
	<tr><td>01-713-1179</td><td>15</td></tr>
	<tr><td>01-711-1143</td><td>14</td></tr>
</tbody>
</table>



## Funktionen zum Aggregieren

Standardfunktionen

* min
* max
* mean
* median
* var
* sd


```R
# Neuen Datensatz SDTM DM laden
dm = read.csv(file = "data/dm.csv", sep = ",", header = TRUE, quote = "\"'")
head(dm)
glimpse(dm)
```


<table class="dataframe">
<caption>A data.frame: 6 × 25</caption>
<thead>
	<tr><th></th><th scope=col>STUDYID</th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>SUBJID</th><th scope=col>RFSTDTC</th><th scope=col>RFENDTC</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>RFICDTC</th><th scope=col>RFPENDTC</th><th scope=col>...</th><th scope=col>SEX</th><th scope=col>RACE</th><th scope=col>ETHNIC</th><th scope=col>ARMCD</th><th scope=col>ARM</th><th scope=col>ACTARMCD</th><th scope=col>ACTARM</th><th scope=col>COUNTRY</th><th scope=col>DMDTC</th><th scope=col>DMDY</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>...</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1015</td><td>1015</td><td>2014-01-02</td><td>2014-07-02</td><td>2014-01-02</td><td>2014-07-02</td><td>NA</td><td>2014-07-02T11:45</td><td>...</td><td>F</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-12-26</td><td> -7</td></tr>
	<tr><th scope=row>2</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1023</td><td>1023</td><td>2012-08-05</td><td>2012-09-02</td><td>2012-08-05</td><td>2012-09-01</td><td>NA</td><td>2013-02-18      </td><td>...</td><td>M</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2012-07-22</td><td>-14</td></tr>
	<tr><th scope=row>3</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1028</td><td>1028</td><td>2013-07-19</td><td>2014-01-14</td><td>2013-07-19</td><td>2014-01-14</td><td>NA</td><td>2014-01-14T11:10</td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2013-07-11</td><td> -8</td></tr>
	<tr><th scope=row>4</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1033</td><td>1033</td><td>2014-03-18</td><td>2014-04-14</td><td>2014-03-18</td><td>2014-03-31</td><td>NA</td><td>2014-09-15      </td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>USA</td><td>2014-03-10</td><td> -8</td></tr>
	<tr><th scope=row>5</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1034</td><td>1034</td><td>2014-07-01</td><td>2014-12-30</td><td>2014-07-01</td><td>2014-12-30</td><td>NA</td><td>2014-12-30T09:50</td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2014-06-24</td><td> -7</td></tr>
	<tr><th scope=row>6</th><td>CDISCPILOT01</td><td>DM</td><td>01-701-1047</td><td>1047</td><td>2013-02-12</td><td>2013-03-29</td><td>2013-02-12</td><td>2013-03-09</td><td>NA</td><td>2013-07-28      </td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-01-22</td><td>-21</td></tr>
</tbody>
</table>



    Rows: 306
    Columns: 25
    $ STUDYID  [3m[90m<chr>[39m[23m "CDISCPILOT01", "CDISCPILOT01", "CDISCPILOT01", "CDISCPILOT01…
    $ DOMAIN   [3m[90m<chr>[39m[23m "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "…
    $ USUBJID  [3m[90m<chr>[39m[23m "01-701-1015", "01-701-1023", "01-701-1028", "01-701-1033", "…
    $ SUBJID   [3m[90m<int>[39m[23m 1015, 1023, 1028, 1033, 1034, 1047, 1057, 1097, 1111, 1115, 1…
    $ RFSTDTC  [3m[90m<chr>[39m[23m "2014-01-02", "2012-08-05", "2013-07-19", "2014-03-18", "2014…
    $ RFENDTC  [3m[90m<chr>[39m[23m "2014-07-02", "2012-09-02", "2014-01-14", "2014-04-14", "2014…
    $ RFXSTDTC [3m[90m<chr>[39m[23m "2014-01-02", "2012-08-05", "2013-07-19", "2014-03-18", "2014…
    $ RFXENDTC [3m[90m<chr>[39m[23m "2014-07-02", "2012-09-01", "2014-01-14", "2014-03-31", "2014…
    $ RFICDTC  [3m[90m<lgl>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ RFPENDTC [3m[90m<chr>[39m[23m "2014-07-02T11:45", "2013-02-18", "2014-01-14T11:10", "2014-0…
    $ DTHDTC   [3m[90m<chr>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ DTHFL    [3m[90m<chr>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ SITEID   [3m[90m<int>[39m[23m 701, 701, 701, 701, 701, 701, 701, 701, 701, 701, 701, 701, 7…
    $ AGE      [3m[90m<int>[39m[23m 63, 64, 71, 74, 77, 85, 59, 68, 81, 84, 52, 84, 81, 57, 75, 5…
    $ AGEU     [3m[90m<chr>[39m[23m "YEARS", "YEARS", "YEARS", "YEARS", "YEARS", "YEARS", "YEARS"…
    $ SEX      [3m[90m<chr>[39m[23m "F", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "M", "…
    $ RACE     [3m[90m<chr>[39m[23m "WHITE", "WHITE", "WHITE", "WHITE", "WHITE", "WHITE", "WHITE"…
    $ ETHNIC   [3m[90m<chr>[39m[23m "HISPANIC OR LATINO", "HISPANIC OR LATINO", "NOT HISPANIC OR …
    $ ARMCD    [3m[90m<chr>[39m[23m "Pbo", "Pbo", "Xan_Hi", "Xan_Lo", "Xan_Hi", "Pbo", "Scrnfail"…
    $ ARM      [3m[90m<chr>[39m[23m "Placebo", "Placebo", "Xanomeline High Dose", "Xanomeline Low…
    $ ACTARMCD [3m[90m<chr>[39m[23m "Pbo", "Pbo", "Xan_Hi", "Xan_Lo", "Xan_Hi", "Pbo", "Scrnfail"…
    $ ACTARM   [3m[90m<chr>[39m[23m "Placebo", "Placebo", "Xanomeline High Dose", "Xanomeline Low…
    $ COUNTRY  [3m[90m<chr>[39m[23m "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA"…
    $ DMDTC    [3m[90m<chr>[39m[23m "2013-12-26", "2012-07-22", "2013-07-11", "2014-03-10", "2014…
    $ DMDY     [3m[90m<int>[39m[23m -7, -14, -8, -8, -7, -21, NA, -9, -13, -7, -13, -6, -5, NA, -…
    


```R
# Nacharbeiten des Import
dm = read_csv(file = "data/dm.csv")

```

    [1mRows: [22m[34m306[39m [1mColumns: [22m[34m25[39m
    [36m──[39m [1mColumn specification[22m [36m────────────────────────────────────────────────────────────────────────────────────────────────[39m
    [1mDelimiter:[22m ","
    [31mchr[39m  (13): STUDYID, DOMAIN, USUBJID, DTHFL, AGEU, SEX, RACE, ETHNIC, ARMCD, ...
    [32mdbl[39m   (4): SUBJID, SITEID, AGE, DMDY
    [33mlgl[39m   (1): RFICDTC
    [34mdttm[39m  (1): RFPENDTC
    [34mdate[39m  (6): RFSTDTC, RFENDTC, RFXSTDTC, RFXENDTC, DTHDTC, DMDTC
    
    [36mℹ[39m Use `spec()` to retrieve the full column specification for this data.
    [36mℹ[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.
    


```R
head(dm)

table(dm$RFICDTC)
```


<table class="dataframe">
<caption>A tibble: 6 × 25</caption>
<thead>
	<tr><th scope=col>STUDYID</th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>SUBJID</th><th scope=col>RFSTDTC</th><th scope=col>RFENDTC</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>RFICDTC</th><th scope=col>RFPENDTC</th><th scope=col>...</th><th scope=col>SEX</th><th scope=col>RACE</th><th scope=col>ETHNIC</th><th scope=col>ARMCD</th><th scope=col>ARM</th><th scope=col>ACTARMCD</th><th scope=col>ACTARM</th><th scope=col>COUNTRY</th><th scope=col>DMDTC</th><th scope=col>DMDY</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>...</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1015</td><td>1015</td><td>2014-01-02</td><td>2014-07-02</td><td>2014-01-02</td><td>2014-07-02</td><td>NA</td><td>2014-07-02 11:45:00</td><td>...</td><td>F</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-12-26</td><td> -7</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1023</td><td>1023</td><td>2012-08-05</td><td>2012-09-02</td><td>2012-08-05</td><td>2012-09-01</td><td>NA</td><td>2013-02-18 00:00:00</td><td>...</td><td>M</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2012-07-22</td><td>-14</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1028</td><td>1028</td><td>2013-07-19</td><td>2014-01-14</td><td>2013-07-19</td><td>2014-01-14</td><td>NA</td><td>2014-01-14 11:10:00</td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2013-07-11</td><td> -8</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1033</td><td>1033</td><td>2014-03-18</td><td>2014-04-14</td><td>2014-03-18</td><td>2014-03-31</td><td>NA</td><td>2014-09-15 00:00:00</td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>USA</td><td>2014-03-10</td><td> -8</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1034</td><td>1034</td><td>2014-07-01</td><td>2014-12-30</td><td>2014-07-01</td><td>2014-12-30</td><td>NA</td><td>2014-12-30 09:50:00</td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2014-06-24</td><td> -7</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1047</td><td>1047</td><td>2013-02-12</td><td>2013-03-29</td><td>2013-02-12</td><td>2013-03-09</td><td>NA</td><td>2013-07-28 00:00:00</td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-01-22</td><td>-21</td></tr>
</tbody>
</table>




    < table of extent 0 >



```R
dm = read_csv(file = "data/dm.csv", 
              col_types = list(
              RFICDTC = col_date(format = "")
              ))
head(dm)
table(dm$RFICDTC)
```


<table class="dataframe">
<caption>A tibble: 6 × 25</caption>
<thead>
	<tr><th scope=col>STUDYID</th><th scope=col>DOMAIN</th><th scope=col>USUBJID</th><th scope=col>SUBJID</th><th scope=col>RFSTDTC</th><th scope=col>RFENDTC</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>RFICDTC</th><th scope=col>RFPENDTC</th><th scope=col>...</th><th scope=col>SEX</th><th scope=col>RACE</th><th scope=col>ETHNIC</th><th scope=col>ARMCD</th><th scope=col>ARM</th><th scope=col>ACTARMCD</th><th scope=col>ACTARM</th><th scope=col>COUNTRY</th><th scope=col>DMDTC</th><th scope=col>DMDY</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>...</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1015</td><td>1015</td><td>2014-01-02</td><td>2014-07-02</td><td>2014-01-02</td><td>2014-07-02</td><td>NA</td><td>2014-07-02 11:45:00</td><td>...</td><td>F</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-12-26</td><td> -7</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1023</td><td>1023</td><td>2012-08-05</td><td>2012-09-02</td><td>2012-08-05</td><td>2012-09-01</td><td>NA</td><td>2013-02-18 00:00:00</td><td>...</td><td>M</td><td>WHITE</td><td>HISPANIC OR LATINO    </td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2012-07-22</td><td>-14</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1028</td><td>1028</td><td>2013-07-19</td><td>2014-01-14</td><td>2013-07-19</td><td>2014-01-14</td><td>NA</td><td>2014-01-14 11:10:00</td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2013-07-11</td><td> -8</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1033</td><td>1033</td><td>2014-03-18</td><td>2014-04-14</td><td>2014-03-18</td><td>2014-03-31</td><td>NA</td><td>2014-09-15 00:00:00</td><td>...</td><td>M</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>Xan_Lo</td><td>Xanomeline Low Dose </td><td>USA</td><td>2014-03-10</td><td> -8</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1034</td><td>1034</td><td>2014-07-01</td><td>2014-12-30</td><td>2014-07-01</td><td>2014-12-30</td><td>NA</td><td>2014-12-30 09:50:00</td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>Xan_Hi</td><td>Xanomeline High Dose</td><td>USA</td><td>2014-06-24</td><td> -7</td></tr>
	<tr><td>CDISCPILOT01</td><td>DM</td><td>01-701-1047</td><td>1047</td><td>2013-02-12</td><td>2013-03-29</td><td>2013-02-12</td><td>2013-03-09</td><td>NA</td><td>2013-07-28 00:00:00</td><td>...</td><td>F</td><td>WHITE</td><td>NOT HISPANIC OR LATINO</td><td>Pbo   </td><td>Placebo             </td><td>Pbo   </td><td>Placebo             </td><td>USA</td><td>2013-01-22</td><td>-21</td></tr>
</tbody>
</table>




    < table of extent 0 >



```R
# Summary-Funktionen
# Mögliche "Fehlfunktionen" bei fehlenden Werten
dm %>% summarise(AGE_mean = mean(AGE))
dm %>% filter(is.na(AGE)) %>% count()
dm %>% summarise(AGE_mean = mean(AGE, na.rm = TRUE))
```


<table class="dataframe">
<caption>A tibble: 1 × 1</caption>
<thead>
	<tr><th scope=col>AGE_mean</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>75.08824</td></tr>
</tbody>
</table>




<table class="dataframe">
<caption>A spec_tbl_df: 1 × 1</caption>
<thead>
	<tr><th scope=col>n</th></tr>
	<tr><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>0</td></tr>
</tbody>
</table>




<table class="dataframe">
<caption>A tibble: 1 × 1</caption>
<thead>
	<tr><th scope=col>AGE_mean</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>75.08824</td></tr>
</tbody>
</table>




```R
# Mehrere Summary-Funktionen möglich
ae %>% summarise(AESTDY_n = n(),
                 AESTDY_mean = mean(AESTDY),
                 AESTDY_sd = sd(AESTDY))

ae %>% summarise(AESTDY_n = n(),
                 AESTDY_mean = mean(AESTDY, na.rm = TRUE),
                 AESTDY_sd = sd(AESTDY, na.rm = TRUE))
```


<table class="dataframe">
<caption>A data.frame: 1 × 3</caption>
<thead>
	<tr><th scope=col>AESTDY_n</th><th scope=col>AESTDY_mean</th><th scope=col>AESTDY_sd</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1191</td><td>NA</td><td>NA</td></tr>
</tbody>
</table>




<table class="dataframe">
<caption>A data.frame: 1 × 3</caption>
<thead>
	<tr><th scope=col>AESTDY_n</th><th scope=col>AESTDY_mean</th><th scope=col>AESTDY_sd</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1191</td><td>45.82833</td><td>48.22689</td></tr>
</tbody>
</table>




```R
# Mehrere Summary-Funktionen möglich
# Zusätzliches Gruppieren nach Treatment
dm %>% group_by(ACTARM) %>%
  summarise(AGE_n = n(),
            AGE_mean = mean(AGE, na.rm = TRUE),
            AGE_sd = sd(AGE, na.rm = TRUE))
```


<table class="dataframe">
<caption>A tibble: 4 × 4</caption>
<thead>
	<tr><th scope=col>ACTARM</th><th scope=col>AGE_n</th><th scope=col>AGE_mean</th><th scope=col>AGE_sd</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Placebo             </td><td>86</td><td>75.20930</td><td>8.590167</td></tr>
	<tr><td>Screen Failure      </td><td>52</td><td>75.09615</td><td>9.699928</td></tr>
	<tr><td>Xanomeline High Dose</td><td>72</td><td>73.77778</td><td>7.943856</td></tr>
	<tr><td>Xanomeline Low Dose </td><td>96</td><td>75.95833</td><td>8.113558</td></tr>
</tbody>
</table>



## FIRST und LAST

FIRST und LAST lassen sich nachbauen oder mit entsprechenden Funktionen nutzen.



```R
# Welcher Patient hat als erstes welche Therapie bekommen?
dm1 <- dm %>% select(USUBJID, ACTARM, RFXSTDTC)
head(dm1)
```


<table class="dataframe">
<caption>A tibble: 6 × 3</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td></tr>
</tbody>
</table>




```R
# Sortieren nach ACTARM und RFXSTDTC
dm1 %>% arrange(ACTARM, RFXSTDTC) %>% head()
```


<table class="dataframe">
<caption>A tibble: 6 × 3</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-716-1024</td><td>Placebo</td><td>2012-07-09</td></tr>
	<tr><td>01-711-1036</td><td>Placebo</td><td>2012-07-29</td></tr>
	<tr><td>01-701-1023</td><td>Placebo</td><td>2012-08-05</td></tr>
	<tr><td>01-704-1260</td><td>Placebo</td><td>2012-08-30</td></tr>
	<tr><td>01-703-1299</td><td>Placebo</td><td>2012-09-12</td></tr>
	<tr><td>01-704-1164</td><td>Placebo</td><td>2012-09-19</td></tr>
</tbody>
</table>




```R
# Nutzen der first()- und last()-Funktionen
dm1 %>% arrange(ACTARM, RFXSTDTC) %>% group_by(ACTARM) %>% 
  summarise(trt_first = first(USUBJID),
            trt_last = last(USUBJID)) %>% 
  ungroup()
```


<table class="dataframe">
<caption>A tibble: 4 × 3</caption>
<thead>
	<tr><th scope=col>ACTARM</th><th scope=col>trt_first</th><th scope=col>trt_last</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Placebo             </td><td>01-716-1024</td><td>01-716-1177</td></tr>
	<tr><td>Screen Failure      </td><td>01-701-1057</td><td>01-716-1331</td></tr>
	<tr><td>Xanomeline High Dose</td><td>01-703-1258</td><td>01-701-1034</td></tr>
	<tr><td>Xanomeline Low Dose </td><td>01-701-1192</td><td>01-701-1317</td></tr>
</tbody>
</table>




```R
head(dm1)
```


<table class="dataframe">
<caption>A tibble: 6 × 3</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td></tr>
</tbody>
</table>




```R
# Alternativer Ansatz unter Beibehaltung aller Daten und 
# anschließendem Filtern
dm2 <- dm1 %>% arrange(ACTARM, RFXSTDTC) %>% 
         group_by(ACTARM) %>% 
         mutate(id = row_number()) %>%
         mutate(id_min = min(id)) %>%
         mutate(id_max = max(id)) %>%
         ungroup()
head(dm2)
```


<table class="dataframe">
<caption>A tibble: 6 × 6</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>id</th><th scope=col>id_min</th><th scope=col>id_max</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-716-1024</td><td>Placebo</td><td>2012-07-09</td><td>1</td><td>1</td><td>86</td></tr>
	<tr><td>01-711-1036</td><td>Placebo</td><td>2012-07-29</td><td>2</td><td>1</td><td>86</td></tr>
	<tr><td>01-701-1023</td><td>Placebo</td><td>2012-08-05</td><td>3</td><td>1</td><td>86</td></tr>
	<tr><td>01-704-1260</td><td>Placebo</td><td>2012-08-30</td><td>4</td><td>1</td><td>86</td></tr>
	<tr><td>01-703-1299</td><td>Placebo</td><td>2012-09-12</td><td>5</td><td>1</td><td>86</td></tr>
	<tr><td>01-704-1164</td><td>Placebo</td><td>2012-09-19</td><td>6</td><td>1</td><td>86</td></tr>
</tbody>
</table>




```R
# Filtern kann auch nur für eine Bedingung erfolgen, um first und last getrennt zu erhalten.
dm2 %>% filter(id == id_min | id == id_max)
```


<table class="dataframe">
<caption>A tibble: 8 × 6</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>id</th><th scope=col>id_min</th><th scope=col>id_max</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-716-1024</td><td>Placebo             </td><td>2012-07-09</td><td> 1</td><td>1</td><td>86</td></tr>
	<tr><td>01-716-1177</td><td>Placebo             </td><td>2014-09-02</td><td>86</td><td>1</td><td>86</td></tr>
	<tr><td>01-701-1057</td><td>Screen Failure      </td><td>NA</td><td> 1</td><td>1</td><td>52</td></tr>
	<tr><td>01-716-1331</td><td>Screen Failure      </td><td>NA</td><td>52</td><td>1</td><td>52</td></tr>
	<tr><td>01-703-1258</td><td>Xanomeline High Dose</td><td>2012-07-20</td><td> 1</td><td>1</td><td>72</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td><td>72</td><td>1</td><td>72</td></tr>
	<tr><td>01-701-1192</td><td>Xanomeline Low Dose </td><td>2012-07-22</td><td> 1</td><td>1</td><td>96</td></tr>
	<tr><td>01-701-1317</td><td>Xanomeline Low Dose </td><td>2014-05-22</td><td>96</td><td>1</td><td>96</td></tr>
</tbody>
</table>



## Neue Variablen erzeugen

Wir haben oben den Befehl mutate() gesehen. Dieser erzeugt im Data Frame eine neue Variable. Hier können auch mehrere Variablen miteinander verknüpft werden.


```R
dm3 <- dm %>% select(USUBJID, ACTARM, RFXSTDTC, RFXENDTC)
head(dm3)
```


<table class="dataframe">
<caption>A tibble: 6 × 4</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td><td>2014-07-02</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td><td>2012-09-01</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td><td>2014-01-14</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td><td>2014-03-31</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td><td>2014-12-30</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td><td>2013-03-09</td></tr>
</tbody>
</table>




```R
# Wir erhalten ein Datendifferenz-Objekt.
dm3 %>% mutate(dd = RFXENDTC - RFXSTDTC) %>% head()
```


<table class="dataframe">
<caption>A tibble: 6 × 5</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>dd</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;drtn&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td><td>2014-07-02</td><td>181 days</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td><td>2012-09-01</td><td> 27 days</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td><td>2014-01-14</td><td>179 days</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td><td>2014-03-31</td><td> 13 days</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td><td>2014-12-30</td><td>182 days</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td><td>2013-03-09</td><td> 25 days</td></tr>
</tbody>
</table>




```R
# Jetzt gibt es einen Integerwert.
dm3 %>% mutate(dd = as.integer(RFXENDTC - RFXSTDTC)) %>% head()
```


<table class="dataframe">
<caption>A tibble: 6 × 5</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>dd</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td><td>2014-07-02</td><td>181</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td><td>2012-09-01</td><td> 27</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td><td>2014-01-14</td><td>179</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td><td>2014-03-31</td><td> 13</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td><td>2014-12-30</td><td>182</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td><td>2013-03-09</td><td> 25</td></tr>
</tbody>
</table>




```R
# Alternative Zuweisung über $ möglich
# Geschmackssache ...
dm3$dd <- as.integer(dm3$RFXENDTC - dm3$RFXSTDTC)
head(dm3)
```


<table class="dataframe">
<caption>A tibble: 6 × 5</caption>
<thead>
	<tr><th scope=col>USUBJID</th><th scope=col>ACTARM</th><th scope=col>RFXSTDTC</th><th scope=col>RFXENDTC</th><th scope=col>dd</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>01-701-1015</td><td>Placebo             </td><td>2014-01-02</td><td>2014-07-02</td><td>181</td></tr>
	<tr><td>01-701-1023</td><td>Placebo             </td><td>2012-08-05</td><td>2012-09-01</td><td> 27</td></tr>
	<tr><td>01-701-1028</td><td>Xanomeline High Dose</td><td>2013-07-19</td><td>2014-01-14</td><td>179</td></tr>
	<tr><td>01-701-1033</td><td>Xanomeline Low Dose </td><td>2014-03-18</td><td>2014-03-31</td><td> 13</td></tr>
	<tr><td>01-701-1034</td><td>Xanomeline High Dose</td><td>2014-07-01</td><td>2014-12-30</td><td>182</td></tr>
	<tr><td>01-701-1047</td><td>Placebo             </td><td>2013-02-12</td><td>2013-03-09</td><td> 25</td></tr>
</tbody>
</table>




```R

```
