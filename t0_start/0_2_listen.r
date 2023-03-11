# Listen können aus einem Datentyp bestehen.
l1 <- list(1L, 2L, 3L)
l1

# Listen können aus unterschiedlichen Datentypen bestehen.
l2 <- list("Name", "Vorname", 13, TRUE)
l2

typeof(l2)

str(l2)

# Zugriff auf das dritte Element.
l2[3]

# Änderung des dritten Elements.
l2[3] <- 25
l2

# Ein Element anhängen.
append(l2, "Gelb")

# Das Element ist noch nicht in der Liste.
l2

# Die neue Liste muss explizit gespeichert werden.
l2 <- append(l2, "Gelb")
l2

# Entfernen des ersten Elementes.
l2 <- l2[-1]
l2

# Entfernen des letzen Elements.
# length() gibt die Länge einer Liste zurück.
l2 <- l2[-length(l2)]
l2

# Entfernen mehrerer Elemente.
l3 <- list(1, "A", "B", TRUE, 2, 10)
l3

# Entfernen des dritten und vierten Elements.
l3 <- l3[-c(3,4)]
l3

# Einfache For-Schleife, Bedingung in runden Klammern, Anweisungen in geschweiften Klammern.
l3 <- list(1, "A", "B", TRUE, 2, 10)
for (l in l3) {
    print(l)
}

# Prüfung mit %in%-Operator.
l3 <- list(1, "A", "B", TRUE, 2, 10)
print("A" %in% l3)
print(TRUE %in% l3)
print(FALSE %in% l3)
print(2 %in% l3)


# Prüfung mehrerer Elemente.
print(c(1, 2) %in% l3)

# Drucken von Listen.
print(list(3, 4))

# Verschachtelte Listen.
l4 <- list(c(3, 1), c(4, 2), list("A", 3, "C"))
print(l4)

l4

# Zugriff.
l4[2]

# Zugriff.
l4[[2]][2]

# Zugriff.
l4[[3]][1]


