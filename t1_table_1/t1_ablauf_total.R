## ------------------------------------------------------------------------------------------------
# extract R code from qmd-File
# knitr::purl("t1_table_1/t1_ablauf_total.qmd", output = "t1_table_1/t1_ablauf_total.R")

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
table(treatment)
# Zufallswerte aus der Menge {"Female", "Male"} mit den Wahrscheinlichkeiten (0.5, 0.5)
gender <- sample(c("Female", "Male"), n, replace = TRUE, prob = c(0.5, 0.5))
table(gender)
table(treatment, gender)
# Gleichförmig verteilte Zufallszahlen aus dem Bereich 18 bis 65
age <- round(runif(n, 18, 65), 0)
summary(age)
# Normalverteilte Zufallszahlen mit Mittelwert 140 und SD 5 und Offset für Referenz-Behandlungsarm
bp <- round(rnorm(n, 140, 5) + ifelse(treatment == "Reference", rnorm(1, 5, 1), 0), 0)
# Speichern als data.frame, rechteckige Tabellenstruktur wie in einem SAS data set.
df <- data.frame(id, treatment, gender, age, bp)
# head() gibt die ersten Zeilen einer Tabelle aus
head(df)


df_tot <- df %>% mutate(treatment = "Total")
df <- rbind(df, df_tot)



## ------------------------------------------------------------------------------------------------

n_trt <- df %>% group_by(treatment) %>% summarize(cnt_trt = n())
n_ref <- n_trt %>% filter(treatment == "Reference") %>% select(cnt_trt) %>% as.numeric()
n_test <- n_trt %>% filter(treatment == "Test") %>% select(cnt_trt) %>% as.numeric()
n_tot <- nrow(df)

n_trt
n_trt_gender <- df %>% 
  group_by(treatment, gender) %>% 
  summarize(cnt_gender = n()) %>%
  ungroup()
n_trt_gender

df1 <- left_join(n_trt_gender, n_trt, by = c("treatment" = "treatment"))
df1$pct <- round(df1$cnt_gender / df1$cnt_trt * 100, 1)
df1$value <- paste0(df1$cnt_gender, " (", df1$pct, "%)")
df1



## ------------------------------------------------------------------------------------------------

df1_t <- pivot_wider(df1 %>% select(treatment, gender, value), names_from = "treatment", values_from = "value")
df1_t



## ------------------------------------------------------------------------------------------------

df1_t$Order <- 1
df1_t$stat_order <- 1
df1_t$Label <- "Gender"
df1_t <- df1_t %>% rename("Category" = "gender") %>% 
  select(Order, stat_order, Label, Category, Test, Reference, Total)
df1_t



## ------------------------------------------------------------------------------------------------

df2 <- df %>% group_by(treatment) %>%
  summarize(m = mean(age),
            s = sd(age),
            md = median(age),
            n = n()) %>%
  ungroup()
df2$m <- as.character(round(df2$m, 2))
df2$s <- as.character(round(df2$s, 3))
df2$ms <- paste0(df2$m, " \U00B1 ", df2$s)
df2$md <- as.character(df2$md)
df2$n <- as.character(df2$n)
df2



## ------------------------------------------------------------------------------------------------

df2_t <- pivot_longer(df2 %>% select(treatment, n, ms, md), cols = -c("treatment"), names_to = "statistic", values_to = "value")
df2_t

df2_t <- df2_t %>% 
  mutate(stat_order = case_when(
    statistic == "n"  ~ 1,
    statistic == "ms" ~ 2,
    statistic == "md"  ~ 3
  )) %>% 
  mutate(stat_long = case_when(
    statistic == "n"  ~ "n",
    statistic == "ms" ~ "Mean \U00B1 SD",
    statistic == "md" ~ "Median"
  ))
df2_t



## ------------------------------------------------------------------------------------------------

df2_tt <- pivot_wider(df2_t %>% 
                        select(treatment, stat_long, value, stat_order), 
                      id_cols = c("stat_long", "stat_order"), 
                      names_from = "treatment", 
                      values_from = c("value"))
df2_tt



## ------------------------------------------------------------------------------------------------

df2_tt$Order <- 2
df2_tt$Label <- "Age"
df2_tt <- df2_tt %>% rename("Category" = "stat_long") %>% 
  select(Order, stat_order, Label, Category, Test, Reference, Total)
df2_tt



## ------------------------------------------------------------------------------------------------
df3 <- df %>% group_by(treatment) %>%
  summarize(m = mean(bp),
            s = sd(bp),
            md = median(bp),
            n = n()) %>%
  ungroup()
df3$m <- as.character(round(df3$m, 2))
df3$s <- as.character(round(df3$s, 3))
df3$ms <- paste0(df3$m, " \U00B1 ", df3$s)
df3$md <- as.character(df3$md)
df3$n <- as.character(df3$n)

df3_t <- pivot_longer(df3 %>% select(treatment, n, ms, md), cols = -c("treatment"), names_to = "statistic", values_to = "value")

df3_t <- df3_t %>% 
  mutate(stat_order = case_when(
    statistic == "n"  ~ 1,
    statistic == "ms" ~ 2,
    statistic == "md"  ~ 3
  )) %>% 
  mutate(stat_long = case_when(
    statistic == "n"  ~ "n",
    statistic == "ms" ~ "Mean \U00B1 SD",
    statistic == "md" ~ "Median"
  ))

df3_tt <- pivot_wider(df3_t %>% 
                        select(treatment, stat_long, value, stat_order), 
                      id_cols = c("stat_long", "stat_order"), 
                      names_from = "treatment", 
                      values_from = c("value"))

df3_tt$Order <- 2
df3_tt$Label <- "Blood pressure [mmHg]"
df3_tt <- df3_tt %>% rename("Category" = "stat_long") %>% 
  select(Order, stat_order, Label, Category, Test, Reference, Total)
df3_tt



## ------------------------------------------------------------------------------------------------

dfc <- rbind(df1_t, df2_tt, df3_tt) %>% select(Label, Category, Test, Reference, Total)

head(dfc, 9)



## ------------------------------------------------------------------------------------------------

ft <- dfc %>% flextable() %>% autofit()
ft



## ------------------------------------------------------------------------------------------------


ft <- ft %>% 
  add_header_lines(c("Study title", "1.2.3 Table title", "FAS")) %>%
  add_footer_lines(c("Abbreviations and comments", "Program name / Run date / Data cut date")) %>%
  border_remove()
ft



## ------------------------------------------------------------------------------------------------

ft <- ft %>% set_header_labels(
  Label = "",
  Category = "", 
  Test = paste0("Test\n(n = ", n_test, ")"),
  Reference = paste0("Reference\n(n = ", n_ref, ")"),
  Total = paste0("Total\n(n = ", n_tot, ")")
)
ft



## ------------------------------------------------------------------------------------------------

ft_merged <- ft %>%
  merge_v(j = "Label") %>% 
  valign(j = c(1), valign = "top", part = "body")
ft_merged



## ------------------------------------------------------------------------------------------------

my_border = fp_border(color="black", width = 2)

ft_merged <- ft_merged %>%
  hline_top(border = my_border, part = "footer") %>%
  hline_bottom(border = my_border, part = "header") %>%
  hline_bottom(border = my_border, part = "body") %>%
  hline(i = c(3), border = my_border, part = "header") %>%
  hline(i = c(2, 5), border = my_border, part = "body") %>%
  hline(i = c(6), j = c(1), border = my_border, part = "body")
ft_merged
  


## ------------------------------------------------------------------------------------------------

my_doc <- read_docx() %>% body_add_flextable(value = ft_merged)
print(my_doc, target = "t1_table_one_mit_total.docx")


