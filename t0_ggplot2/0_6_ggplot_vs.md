# Grafiken mit ggplot2

Grundlagen am Beispiel von klinischen Grafiken, die mit SAS erstellt worden sind.
https://support.sas.com/rnd/datavisualization/yourGraphs/analyticalCustom/clinical/sas94/7L_VS_By_Type.html
## Vitalparameter auf getrennten Zeichenflächen


```R
library(tidyverse)
library(ggplot2)
```


```R
# Einlesen der Rohdaten aus dem Programm heraus.
CSV_text_string = "VSSTRESN, VSDY, vstest2, id
68, -16, 'Diastolic', 2
68, -2, 'Diastolic', 2
68, 1, 'Diastolic', 2
70, 15, 'Diastolic', 2
68, 16, 'Diastolic', 2
70, 27, 'Diastolic', 2
70, 29, 'Diastolic', 2
74, 41, 'Diastolic', 2
60, 57, 'Diastolic', 2
62, 83, 'Diastolic', 2
64, 114, 'Diastolic', 2
54, -16, 'Pulse', 3
57, -2, 'Pulse', 3
54, 1, 'Pulse', 3
57, 15, 'Pulse', 3
54, 16, 'Pulse', 3
57, 27, 'Pulse', 3
60, 29, 'Pulse', 3
60, 41, 'Pulse', 3
51, 57, 'Pulse', 3
72, 83, 'Pulse', 3
51, 114, 'Pulse', 3
132, -16, 'Systolic', 1
146, -2, 'Systolic', 1
130, 1, 'Systolic', 1
122, 15, 'Systolic', 1
132, 16, 'Systolic', 1
130, 27, 'Systolic', 1
120, 29, 'Systolic', 1
120, 41, 'Systolic', 1
140, 57, 'Systolic', 1
122, 83, 'Systolic', 1
130, 114, 'Systolic', 1
"

df = read.csv(text = CSV_text_string, header = TRUE, quote = "\'")
df$vstest2 <- trimws(df$vstest2)
head(df)
table(df$vstest2)
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>VSSTRESN</th><th scope=col>VSDY</th><th scope=col>vstest2</th><th scope=col>id</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>68</td><td>-16</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>2</th><td>68</td><td> -2</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>3</th><td>68</td><td>  1</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>4</th><td>70</td><td> 15</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>5</th><td>68</td><td> 16</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>6</th><td>70</td><td> 27</td><td>Diastolic</td><td>2</td></tr>
</tbody>
</table>




    
    Diastolic     Pulse  Systolic 
           11        11        11 



```R
# Simpler Beginn und schrittweiser Aufbau.
plt <- ggplot(data = df, aes(x = VSDY, y = VSSTRESN, group = vstest2)) +
  geom_line() 
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_3_0.png)
    



```R
# Gruppierung in unterschiedliche Zeichenflächen mit facet_wrap().
plt <- ggplot(data = df, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  facet_wrap(vstest2~., scales = "free", dir = "v")

plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_4_0.png)
    



```R
# Zur angepassten Sortierung werden die Strings der Labels in Faktoren umgewandelt.
df2 <- df
df2$vstest2 <- factor(df$vstest2, levels =  c("Systolic", "Diastolic", "Pulse"))
head(df2)
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  facet_wrap(vstest2~., scales = "free", dir = "v")

plt
```


<table class="dataframe">
<caption>A data.frame: 6 × 4</caption>
<thead>
	<tr><th></th><th scope=col>VSSTRESN</th><th scope=col>VSDY</th><th scope=col>vstest2</th><th scope=col>id</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>68</td><td>-16</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>2</th><td>68</td><td> -2</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>3</th><td>68</td><td>  1</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>4</th><td>70</td><td> 15</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>5</th><td>68</td><td> 16</td><td>Diastolic</td><td>2</td></tr>
	<tr><th scope=row>6</th><td>70</td><td> 27</td><td>Diastolic</td><td>2</td></tr>
</tbody>
</table>




    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_5_1.png)
    



```R
# Punkte ergänzt
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  geom_point() +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_6_0.png)
    



```R
# Punkte benutzerdefiniert formatiert
# https://www.datanovia.com/en/blog/ggplot-point-shapes-best-tips/
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_7_0.png)
    



```R
# Linien farbig.
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN, color = vstest2)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_8_0.png)
    



```R
# Linien benutzerdefiniert coloriert.
# http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN, color = vstest2)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") +
  scale_color_manual(breaks = c("Systolic", "Diastolic", "Pulse"),
                     values=c("blue", "red", "green"))
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_9_0.png)
    



```R
# Beschriftungen und Lokalisation von Achsen und Legende anpassen
# Referenzlinie einzeichnen
# http://www.sthda.com/english/wiki/
# ggplot2-legend-easy-steps-to-change-the-position-and-the-appearance-of-a-graph-legend-in-r-software
# https://stackoverflow.com/questions/14622421/how-to-change-legend-title-in-ggplot

plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN, color = vstest2)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  geom_vline(xintercept = 0, color = "grey") +
  facet_wrap(vstest2~., scales = "free", dir = "v") +
  labs(color = "Vitals") +
  scale_color_manual(breaks = c("Systolic", "Diastolic", "Pulse"),
                     values=c("blue", "red", "green")) + 
  theme(legend.position="bottom") +
  scale_x_continuous(breaks = c(0, 25, 50, 100)) +
  xlab("Study Days") +
  ylab("") + 
  ggtitle("Vital Statistics for Patient Id = x")
plt
```


    
![png](https://github.com/jsahlmann/R4TFLs/blob/main/t0_ggplot2/img_06/output_10_0.png)
    



```R

```
