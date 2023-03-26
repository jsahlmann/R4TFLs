## -------------------------------------------------------------------------------------------------------------------
# extract R code from qmd-File
# knitr::purl("t2_ae_tables/t2_ablauf.qmd", output = "t2_ae_tables/t2_ablauf.R")
# https://quarto.org/docs/authoring/markdown-basics.html

suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))
suppressPackageStartupMessages(library(safetyData))



## -------------------------------------------------------------------------------------------------------------------

#sdtm_ae <- read_csv("../data/ae.csv", col_types = cols(AEENDTC = col_character()))
data(sdtm_ae, package = "safetyData")
data(sdtm_dm, package = "safetyData")

ae <- sdtm_ae
dm <- sdtm_dm %>% select(USUBJID, ACTARMCD, ACTARM)

df1 <- left_join(ae, dm, by = c("USUBJID"))
df1$TRT <- df1$ACTARMCD


#   Pbo Xan_Hi Xan_Lo 
#   301    436    454 
   


## -------------------------------------------------------------------------------------------------------------------

cnt_level_1 <- df1 %>% 
  group_by(TRT) %>% 
  summarize(cnt_1 = n()) %>% 
  ungroup()

n_Pbo <- cnt_level_1 %>% filter(TRT == "Pbo") %>% select(cnt_1) %>% as.integer()
n_Xan_Hi <- cnt_level_1 %>% filter(TRT == "Xan_Hi") %>% select(cnt_1) %>% as.integer()
n_Xan_Lo <- cnt_level_1 %>% filter(TRT == "Xan_Lo") %>% select(cnt_1) %>% as.integer()

cl1 <- cnt_level_1 %>% pivot_wider(names_from = TRT, values_from = cnt_1)
cl1$order <- 1
cl1$SOC <- "Any Adverse Event"
cl1$PT <- ""
cl1 <- cl1 %>% select(SOC, PT, Pbo, Xan_Hi, Xan_Lo)
cl1$Pbo <- paste0(cl1$Pbo, " (100%)")
cl1$Xan_Hi <- paste0(cl1$Xan_Hi, " (100%)")
cl1$Xan_Lo <- paste0(cl1$Xan_Lo, " (100%)")

cnt_level_2 <- df1 %>% 
  group_by(TRT, AEBODSYS) %>% 
  summarize(cnt_2 = n()) %>% 
  ungroup()

cl2 <- cnt_level_2 %>% pivot_wider(names_from = TRT, values_from = cnt_2)
cl2$order <- 2
cl2$SOC <- cl2$AEBODSYS
cl2$PT <- ""
cl2 <- cl2 %>% select(SOC, PT, Pbo, Xan_Hi, Xan_Lo, order)

cnt_level_3 <- df1 %>% 
  group_by(TRT, AEBODSYS, AEDECOD) %>% 
  summarize(cnt_3 = n()) %>% 
  ungroup()

cl3 <- cnt_level_3 %>% pivot_wider(names_from = TRT, values_from = cnt_3)
cl3$order <- 3
cl3$SOC <- cl3$AEBODSYS
cl3$PT <- cl3$AEDECOD
cl3 <- cl3 %>% select(SOC, PT, Pbo, Xan_Hi, Xan_Lo, order)

ddf <- rbind(cl2, cl3) %>% arrange(SOC, PT)
df3 <- left_join(ddf, cl2 %>% select(-c(PT)), by = c("SOC" = "SOC"))

df3$Pbo <- paste0(df3$Pbo.x, " (", round(df3$Pbo.x / df3$Pbo.y * 100, 1), "%)")
df3$Pbo <- ifelse(df3$Pbo == "NA (NA%)", "", df3$Pbo)

df3$Xan_Hi <- paste0(df3$Xan_Hi.x, " (", round(df3$Xan_Hi.x / df3$Xan_Hi.y * 100, 1), "%)")
df3$Xan_Hi <- ifelse(df3$Xan_Hi == "NA (NA%)", "", df3$Xan_Hi)

df3$Xan_Lo <- paste0(df3$Xan_Lo.x, " (", round(df3$Xan_Lo.x / df3$Xan_Lo.y * 100, 1), "%)")
df3$Xan_Lo <- ifelse(df3$Xan_Lo == "NA (NA%)", "", df3$Xan_Lo)

df4 <- df3 %>% select(SOC, PT, Pbo, Xan_Hi, Xan_Lo)
df4 <- rbind(cl1, df4)

df4 %>% flextable() %>% autofit()



## -------------------------------------------------------------------------------------------------------------------

df4$SOC_PT <- ifelse(df4$PT != "", paste0("\U00A0\U00A0\U00A0", df4$PT), df4$SOC)

ft_ae <- df4 %>% select(SOC_PT, Xan_Hi, Xan_Lo, Pbo) %>% flextable() %>% autofit()
ft_ae



## -------------------------------------------------------------------------------------------------------------------

my_border = fp_border(color="black", width = 2)

ft_ae <- ft_ae %>% 
  add_header_lines(c("Study title", "1.2.3 Summary of Adverse Events", "SAF")) %>%
  add_footer_lines(c("Abbreviations and comments", "Program name / Run date / Data cut date")) %>%
  border_remove() %>% 
  set_header_labels(
  SOC_PT = "System Organ Class\n\U00A0\U00A0\U00A0Preferred Term", 
  Xan_Hi = paste0("Xan High\n(n = ", n_Xan_Hi, ")"),
  Xan_Lo = paste0("Xan Low\n(n = ", n_Xan_Lo, ")"),
  Pbo = paste0("Placebo\n(n = ", n_Pbo, ")")
) %>%
  hline_top(border = my_border, part = "footer") %>%
  hline_bottom(border = my_border, part = "header") %>%
  hline_bottom(border = my_border, part = "body") %>%
  hline(i = c(3), border = my_border, part = "header") %>%
  align(j = c(2, 3, 4), align = "right", part = "header") %>%
  align(j = c(2, 3, 4), align = "right", part = "body")
ft_ae




## -------------------------------------------------------------------------------------------------------------------

my_doc <- read_docx() %>% body_add_flextable(value = ft_ae)
print(my_doc, target = "table_ae_lang.docx")



## -------------------------------------------------------------------------------------------------------------------

my_doc <- read_docx("table_vorlage.docx") %>% body_add_flextable(value = ft_ae)
print(my_doc, target = "table_ae_quer.docx")


