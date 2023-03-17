library(tidyverse)
library(ggplot2)

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

# Simpler Beginn und schrittweiser Aufbau.
plt <- ggplot(data = df, aes(x = VSDY, y = VSSTRESN, group = vstest2)) +
  geom_line() 
plt

# Gruppierung in unterschiedliche Zeichenflächen mit facet_wrap().
plt <- ggplot(data = df, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  facet_wrap(vstest2~., scales = "free", dir = "v")

plt

# Zur angepassten Sortierung werden die Strings der Labels in Faktoren umgewandelt.
df2 <- df
df2$vstest2 <- factor(df$vstest2, levels =  c("Systolic", "Diastolic", "Pulse"))
head(df2)
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  facet_wrap(vstest2~., scales = "free", dir = "v")

plt

# Punkte ergänzt
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  geom_point() +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt

# Punkte benutzerdefiniert formatiert
# https://www.datanovia.com/en/blog/ggplot-point-shapes-best-tips/
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt

# Linien farbig.
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN, color = vstest2)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") 
plt

# Linien benutzerdefiniert coloriert.
# http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
plt <- ggplot(data = df2, aes(x = VSDY, y = VSSTRESN, color = vstest2)) +
  geom_line() +
  geom_point(shape = 16, size = 2, color = "white") +
  facet_wrap(vstest2~., scales = "free", dir = "v") +
  scale_color_manual(breaks = c("Systolic", "Diastolic", "Pulse"),
                     values=c("blue", "red", "green"))
plt

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


