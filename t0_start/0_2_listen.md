# Datenstrukturen

## Listen
Listen stellen eine weitere Form einer eindimensionalen Datenstrukturen dar.
Sie bestehen aus einem bis vielen Elementen verschiedener Datentyps und Strukturen.



### Erzeugung von Listen


```R
# Listen können aus einem Datentyp bestehen.
l1 <- list(1L, 2L, 3L)
l1
```


```R
# Listen können aus unterschiedlichen Datentypen bestehen.
l2 <- list("Name", "Vorname", 13, TRUE)
l2
```


```R
typeof(l2)
```


```R
str(l2)
```

### Adressieren der Elemente einer Liste

Die Indizes sind 1-basiert, d.h., das erste Element einer Liste hat die Nummer 1.

Die Zugriff erfolgt über den Index in eckigen Klammern.


```R
# Zugriff auf das dritte Element.
l2[3]
```

### Ändern von Listenelementen


```R
# Änderung des dritten Elements.
l2[3] <- 25
l2
```

### Ergänzen von Listenelementen

Die ergänzte Liste muss einer Variablen zugewiesen werden. append() selbst ändert die Liste nicht.


```R
# Ein Element anhängen.
append(l2, "Gelb")
```


```R
# Das Element ist noch nicht in der Liste.
l2
```


```R
# Die neue Liste muss explizit gespeichert werden.
l2 <- append(l2, "Gelb")
l2
```

### Entfernen von Listenelementen


```R
# Entfernen des ersten Elementes.
l2 <- l2[-1]
l2
```


```R
# Entfernen des letzen Elements.
# length() gibt die Länge einer Liste zurück.
l2 <- l2[-length(l2)]
l2
```


```R
# Entfernen mehrerer Elemente.
l3 <- list(1, "A", "B", TRUE, 2, 10)
l3
```


```R
# Entfernen des dritten und vierten Elements.
l3 <- l3[-c(3,4)]
l3
```

### Schleifen und Listen
Es gibt eine For-Schleife, die jedes Listenelement anspricht.



```R
# Einfache For-Schleife, Bedingung in runden Klammern, Anweisungen in geschweiften Klammern.
l3 <- list(1, "A", "B", TRUE, 2, 10)
for (l in l3) {
    print(l)
}
```

### Prüfen auf Existenz
Die Liste kann auf die Existenz eines Elements geprüft werden, ohne dass man über alle Elemente iterieren muss.


```R
# Prüfung mit %in%-Operator.
l3 <- list(1, "A", "B", TRUE, 2, 10)
print("A" %in% l3)
print(TRUE %in% l3)
print(FALSE %in% l3)
print(2 %in% l3)

```


```R
# Prüfung mehrerer Elemente.
print(c(1, 2) %in% l3)
```

### Listen von Listen

[[]] gibt das Element selbst zurück

[] gibt eine Liste der gewählten Elemente zurück


```R
# Drucken von Listen.
print(list(3, 4))
```


```R
# Verschachtelte Listen.
l4 <- list(c(3, 1), c(4, 2), list("A", 3, "C"))
print(l4)
```


```R
l4
```


```R
# Zugriff.
l4[2]
```


```R
# Zugriff.
l4[[2]][2]
```


```R
# Zugriff.
l4[[3]][1]
```


```R

```
