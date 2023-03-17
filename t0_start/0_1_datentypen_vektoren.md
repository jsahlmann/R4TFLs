# Datenstrukturen

Es gibt verschiedene Datenstrukturen in R:

- Vektoren
- Matrix / Matrizen
- Listen
- Arrays
- Data Frames
- Faktoren

Es gibt 6 Datentypen in R:

- Integer
- Double
- Logical
- Character
- Complex
- Raw


## Vektoren
Vektoren stellen die einfachste Form der Datenstrukturen dar.
Sie bestehen aus einem bis vielen Elementen desselben Datentyps.


### Integer
Es gibt verschiedene Theorien, warum Integers mit L gekennzeichnet sind. Eine lautet, dass L in C für *32 bit long integer* steht.


```R
# Integer
v <- c(1L, 2L, 3L)
v
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>2</li><li>3</li></ol>




```R
typeof(v)
```


'integer'



```R
str(v)
```

     int [1:3] 1 2 3
    

### Double


```R
# Double
v <- c(1.0, 2.0, 3.0)
v
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>2</li><li>3</li></ol>




```R
typeof(v)
```


'double'



```R
str(v)
```

     num [1:3] 1 2 3
    

### Logical


```R
# Logical
v <- c(TRUE, FALSE, FALSE, TRUE)
v
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>TRUE</li><li>FALSE</li><li>FALSE</li><li>TRUE</li></ol>




```R
typeof(v)
```


'logical'



```R
str(v)
```

     logi [1:4] TRUE FALSE FALSE TRUE
    

### Character

Ein String als Datenstruktur besteht aus Charactern.

Ein Vektor als Datenstruktur kann aus mehreren Strings bestehen.


```R
# Character
v <- c("Anton", "Berta", "Christine")
v
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'Anton'</li><li>'Berta'</li><li>'Christine'</li></ol>




```R
typeof(v)
```


'character'



```R
str(v)
```

     chr [1:3] "Anton" "Berta" "Christine"
    

### Complex


```R
# Einfache komplexe Zahl.
complex_value <- 3 + 2i
complex_value
```


3+2i



```R
typeof(complex_value)
```


'complex'



```R
str(complex_value)
```

     cplx 3+2i
    


```R
# Vektor von komplexen Zahlen.
complex_vector <- complex(real = c(1, 2, 3), imaginary = c(3, 2,1))
complex_vector
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1+3i</li><li>2+2i</li><li>3+1i</li></ol>




```R
typeof(complex_vector)
```


'complex'



```R
str(complex_vector)
```

     cplx [1:3] 1+3i 2+2i 3+1i
    

### Raw

Raw Data sind byteweise Darstellungen.

Die Strings sind vom Grundsatz UTF-8 encodiert. Das Ö hat die Darstellung in zwei Bytes c3 96.


```R
# Raw Daten sind byteweise Darstellungen.
v <- charToRaw(c("Hallo!"))
v
v1 <- charToRaw(c("ÖPNV"))
v1
v2 <- charToRaw(c("OPNV"))
v2
```


    [1] 48 61 6c 6c 6f 21



    [1] c3 96 50 4e 56



    [1] 4f 50 4e 56



```R
typeof(v)
```


'raw'



```R
str(v)
```

     raw [1:6] 48 61 6c 6c ...
    

## Arbeiten mit Vektoren
Wir erzeugen verschiedene Vektoren.




```R
# seq() erzeugt eine Sequenz von Elementen mit 
v1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
v1
v1 <- seq(1:10)
v1
v2 <- seq(1, 10, by = 0.5)
v2
v3 <- seq(0, 100, by = 10)
v3
# rep() wiederholt kompletten Vektor oder elementweise
v4 <- c("rot", "gelb", "grün", "blau", "schwarz", "weiß")
v4
v5 <- rep(v4, times = 2)
v5
v6 <- rep(v4, each = 2)
v6
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>1.5</li><li>2</li><li>2.5</li><li>3</li><li>3.5</li><li>4</li><li>4.5</li><li>5</li><li>5.5</li><li>6</li><li>6.5</li><li>7</li><li>7.5</li><li>8</li><li>8.5</li><li>9</li><li>9.5</li><li>10</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>0</li><li>10</li><li>20</li><li>30</li><li>40</li><li>50</li><li>60</li><li>70</li><li>80</li><li>90</li><li>100</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'rot'</li><li>'gelb'</li><li>'gelb'</li><li>'grün'</li><li>'grün'</li><li>'blau'</li><li>'blau'</li><li>'schwarz'</li><li>'schwarz'</li><li>'weiß'</li><li>'weiß'</li></ol>



Wir selektieren auf unterschiedliche Art und Weise


```R
# Elemente auswählen nach Position
v4
v4[3] # das dritte Element
v4[-v3] # alle außer dem dritten Element
v4[3:5] # Elemente 3 bis 5
v4[-(3:5)] # alle außer den Elementen 3 bis 5
v4[c(2, 4)] # Element 2 und Element 4
v4[length(v4)] # Letztes Element, eine von vielen Möglichkeiten

```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




'grün'



<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'grün'</li><li>'blau'</li><li>'schwarz'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'gelb'</li><li>'blau'</li></ol>




'weiß'



```R
# Elemente auswählen nach Wert
v2
v2[v2 == 4] # Element gleich 4
v2[v2 < 4] # Elemente kleiner als 4
mychoice <- c(2, 4, 6, 8, 10, 12)
v2[v2 %in% mychoice]
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>1.5</li><li>2</li><li>2.5</li><li>3</li><li>3.5</li><li>4</li><li>4.5</li><li>5</li><li>5.5</li><li>6</li><li>6.5</li><li>7</li><li>7.5</li><li>8</li><li>8.5</li><li>9</li><li>9.5</li><li>10</li></ol>




4



<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1</li><li>1.5</li><li>2</li><li>2.5</li><li>3</li><li>3.5</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>2</li><li>4</li><li>6</li><li>8</li><li>10</li></ol>



## Weitere Vektorfunktionen


```R
# Vektor sortieren
v5
sort(v5)
order(v5)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'blau'</li><li>'blau'</li><li>'gelb'</li><li>'gelb'</li><li>'grün'</li><li>'grün'</li><li>'rot'</li><li>'rot'</li><li>'schwarz'</li><li>'schwarz'</li><li>'weiß'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>4</li><li>10</li><li>2</li><li>8</li><li>3</li><li>9</li><li>1</li><li>7</li><li>5</li><li>11</li><li>6</li><li>12</li></ol>




```R
# Im Vektor die Reihenfolge der Elemente umkehren
rev(v5)
rev(sort(v5))
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'weiß'</li><li>'schwarz'</li><li>'blau'</li><li>'grün'</li><li>'gelb'</li><li>'rot'</li><li>'weiß'</li><li>'schwarz'</li><li>'blau'</li><li>'grün'</li><li>'gelb'</li><li>'rot'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'weiß'</li><li>'weiß'</li><li>'schwarz'</li><li>'schwarz'</li><li>'rot'</li><li>'rot'</li><li>'grün'</li><li>'grün'</li><li>'gelb'</li><li>'gelb'</li><li>'blau'</li><li>'blau'</li></ol>




```R
# Eindeutige Elemente ausgeben / Dubletten entfernen
unique(v5)
sort(unique(v5))
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'rot'</li><li>'gelb'</li><li>'grün'</li><li>'blau'</li><li>'schwarz'</li><li>'weiß'</li></ol>




<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'blau'</li><li>'gelb'</li><li>'grün'</li><li>'rot'</li><li>'schwarz'</li><li>'weiß'</li></ol>




```R
# Einfache Häufigkeitstabelle
table(v5)
```


    v5
       blau    gelb    grün     rot schwarz    weiß 
          2       2       2       2       2       2 



```R
# Einfache Stichprobe mit Häufigkeitstabelle
set.seed(123)
n <- 1000
s1 <- sample(x = c("rot", "gelb", "grün"), size = n, replace = TRUE, prob = c(1/4, 1/4, 1/2))
table(s1)
dfs1 <- data.frame(table(s1))

dfs1$Pct <- dfs1$Freq/n*100
dfs1
```


    s1
    gelb grün  rot 
     245  507  248 



<table class="dataframe">
<caption>A data.frame: 3 × 3</caption>
<thead>
	<tr><th scope=col>s1</th><th scope=col>Freq</th><th scope=col>Pct</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>gelb</td><td>245</td><td>24.5</td></tr>
	<tr><td>grün</td><td>507</td><td>50.7</td></tr>
	<tr><td>rot </td><td>248</td><td>24.8</td></tr>
</tbody>
</table>




```R

```


```R

```
