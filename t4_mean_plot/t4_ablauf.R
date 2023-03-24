## ------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))



## ------------------------------------------------------------------------------------------------

# Startwert für Zufallszahlengenerator
set.seed(123)
# Zahl der Studienteilnehmer festlegen
n <- 500
# Folge 1 bis 500 speichern
id <- seq(1, n)
# Zufallswerte aus der Menge {"Test", "Reference"} mit den Wahrscheinlichkeiten (0.5, 0.5)
treatment <- sample(c("Test", "Reference"), n, replace = TRUE, prob = c(0.5, 0.5))
# Zufallswerte aus der Menge {"Female", "Male"} mit den Wahrscheinlichkeiten (0.5, 0.5)
gender <- sample(c("Female", "Male"), n, replace = TRUE, prob = c(0.5, 0.5))
# Gleichförmig verteilte Zufallszahlen aus dem Bereich 18 bis 65
age <- round(runif(n, 18, 65), 0)
summary(age)
# Normalverteilte Zufallszahlen mit Mittelwert 140 und SD 5 und Offset für Test-Behandlungsarm
bp_v1 <- round(rnorm(n, 160, 5))
bp_v2 <- round(bp_v1 + rnorm(n, 0, 2) + ifelse(treatment == "Test", rnorm(1, -5, 1), 0), 0)
bp_v3 <- round(bp_v2 + rnorm(n, 0, 2) + ifelse(treatment == "Test", rnorm(1, -5, 1), 0), 0)
# Speichern als data.frame, rechteckige Tabellenstruktur wie in einem SAS data set.
df <- data.frame(id, treatment, gender, age, bp_v1, bp_v2, bp_v3)
# head() gibt die ersten Zeilen einer Tabelle aus
head(df)



## ------------------------------------------------------------------------------------------------

df_long <- df %>% pivot_longer(cols = -c(id, treatment, gender, age), names_to = "Visit", values_to = "RR")
head(df_long)



## ------------------------------------------------------------------------------------------------


plot_df <- df_long %>%
  group_by(treatment, Visit) %>%
  summarize(m = mean(RR),
            s = sd(RR)) %>%
  ungroup()

plot_df <- plot_df %>% mutate(visitn = case_when(
                            Visit == "bp_v1" ~ 1,
                            Visit == "bp_v2" ~ 2,
                            Visit == "bp_v3" ~ 3))
plot_df$visitn <- ifelse(plot_df$treatment == "Reference", 
                         plot_df$visitn - 0.05, 
                         plot_df$visitn + 0.05)

head(plot_df)



## ------------------------------------------------------------------------------------------------

plt <- ggplot(data = plot_df, aes(x = visitn, y = m, color = treatment)) +
  geom_point() +
  ggtitle("Blood pressure by Treatment") +
  xlab("Visit") +
  xlim(0, 4) +
  ylab("RR [mm Hg]") +
  ylim(60, 180)
plt



## ------------------------------------------------------------------------------------------------

plt <- plt + scale_color_discrete(name = "Treatment", labels = c("Reference", "Test")) +
  scale_x_continuous(breaks = c(1, 2, 3), labels= c("V1", "V2", "V3"))
plt



## ------------------------------------------------------------------------------------------------

plt <- plt + geom_pointrange(aes(ymin = m - s, ymax = m + s))
plt



## ------------------------------------------------------------------------------------------------

plt <- plt + geom_segment(aes(x = visitn - 0.03, xend = visitn + 0.03, y = m + s, yend = m + s)) +
  geom_segment(aes(x = visitn - 0.03, xend = visitn + 0.03, y = m - s, yend = m - s))
plt



## ------------------------------------------------------------------------------------------------

plt <- plt + geom_line()
plt



## ------------------------------------------------------------------------------------------------

ggsave(filename = "t4_meanplot.png", plot = plt)



## ------------------------------------------------------------------------------------------------

txt <- "Und hier kommt noch weiterer Text für das Dokument."

my_doc <- read_docx() %>% 
  body_add_par("Erster importierter Plot im Word-Dokument.") %>%
  body_add_par("Zweite Zeile.") %>%
  body_add_par("") %>%
  body_add_par(txt) %>%
  body_add_par("") %>%
  body_add_gg(plt)
print(my_doc, target = "t4_meanplot.docx")


