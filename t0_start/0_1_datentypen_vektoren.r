# Integer
v <- c(1L, 2L, 3L)
v

typeof(v)

str(v)

# Double
v <- c(1.0, 2.0, 3.0)
v

typeof(v)

str(v)

# Logical
v <- c(TRUE, FALSE, FALSE, TRUE)
v

typeof(v)

str(v)

# Character
v <- c("Anton", "Berta", "Christine")
v

typeof(v)

str(v)

# Einfache komplexe Zahl.
complex_value <- 3 + 2i
complex_value

typeof(complex_value)

str(complex_value)

# Vektor von komplexen Zahlen.
complex_vector <- complex(real = c(1, 2, 3), imaginary = c(3, 2,1))
complex_vector

typeof(complex_vector)

str(complex_vector)

# Raw Daten sind byteweise Darstellungen.
v <- charToRaw(c("Hallo!"))
v

typeof(v)

str(v)


