## ------------------------------------------------------------------------------------------------
# https://quarto.org/docs/authoring/markdown-basics.html

# knitr::purl("t3_lm/t3_ablauf.qmd", output = "t3_lm/t3_ablauf.R")

suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))
suppressPackageStartupMessages(library(car))
suppressPackageStartupMessages(library(broom))



## ------------------------------------------------------------------------------------------------

head(Prestige) %>% flextable() %>% autofit()



## ------------------------------------------------------------------------------------------------

lm1 <- lm(prestige ~ education + log2(income) + women, data = Prestige)
summary(lm1)



## ------------------------------------------------------------------------------------------------

lm1



## ------------------------------------------------------------------------------------------------

ft <- tidy(lm1) %>% flextable()
ft



## ------------------------------------------------------------------------------------------------
# Modellparameter auf einen Blick
gl <- glance(lm1)
gl



## ------------------------------------------------------------------------------------------------
# glance()-Ausgabe als data frame
df_gl <- data.frame(t(gl))
df_gl


# Reihennamen in Variable umwandeln
df_gl$parameter <- rownames(df_gl)
rownames(df_gl) <- NULL
df_gl <- df_gl %>% dplyr::rename("value" = "t.gl.")
df_gl$value <- sprintf("%.4f", df_gl$value)
df_gl %>% select(parameter, value)



## ------------------------------------------------------------------------------------------------
# Funktion zum Formatieren der p-Werte
format_p <- function(p) {
  p_c <- sprintf("%.3f", p)
  if (p < 0.001) {
    p_c <- "< 0.001 ***"
  } else if (p < 0.01) {
    p_c <- paste0(p_c, " **")
  } else if (p < 0.05) {
    p_c <- paste0(p_c, " *")
  }
  p_c
}

df <- tidy(lm1) 
df$p.value <- sapply(df$p.value, format_p, simplify = TRUE)

df$estimate <- sprintf("%.4f", df$estimate)
df$std.error <- sprintf("%.4f", df$std.error)
df$statistic <- sprintf("%.4f", df$statistic)

ft <- df %>% flextable() %>% autofit()

my_border = fp_border(color="black", width = 2)

ft_lm <- ft %>% 
  add_header_lines(c("Study title", "1.2.3 Linear Model", "FAS")) %>%
  add_footer_lines(c("Abbreviations and comments", "Program name / Run date / Data cut date")) %>%
  border_remove() %>% 
  set_header_labels(
  term = "Variable",
  estimate = "Estimate", 
  std.error = "SE",
  statistic = "Statistic",
  p.value = "p") %>%
  hline_top(border = my_border, part = "footer") %>%
  hline_bottom(border = my_border, part = "header") %>%
  hline_bottom(border = my_border, part = "body") %>%
  hline(i = c(3), border = my_border, part = "header") %>%
  align(j = c(2:5), align = "right", part = "header") %>%
  align(j = c(2:5), align = "right", part = "body")
ft_lm



## ------------------------------------------------------------------------------------------------

my_doc <- read_docx() %>% body_add_flextable(value = ft_lm)
print(my_doc, target = "t3_table_lm.docx")



## ------------------------------------------------------------------------------------------------


