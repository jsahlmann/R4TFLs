## -------------------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(survival))
suppressPackageStartupMessages(library(survminer))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))
suppressPackageStartupMessages(library(safetyData))



## -------------------------------------------------------------------------------------------------------------------

data(sdtm_ae, package = "safetyData")
df <- sdtm_ae
df %>% head()



## -------------------------------------------------------------------------------------------------------------------

str(df)



## -------------------------------------------------------------------------------------------------------------------

df2 <- df %>% select(USUBJID, AESEQ, AEDECOD, AESOC, AESEV, AESER, AEREL, AEOUT, AESTDTC, AEENDTC) %>% head(100)
head(df2)



## -------------------------------------------------------------------------------------------------------------------

df2 %>% head() %>% flextable()
ft_ae <- df2 %>% flextable() 



## -------------------------------------------------------------------------------------------------------------------


ft_ae <- ft_ae %>% autofit()
ft_ae 



## -------------------------------------------------------------------------------------------------------------------

ft_ae <- ft_ae %>% 
  set_header_labels(
    USUBJID = "Patient\nID",
    AESEQ = "AE No.",
    AEDECOD = "Preferred Term",
    AESOC = "System Organ Class",
    AESEV = "Severity",
    AESER = "Serious\nness",
    AEREL = "Relation",
    AEOUT = "Outcome",
    AESTDTC = "Start \ndate",
    AEENDTC = "End \ndate"
  ) %>%
  valign(i = 1, valign = "top", part = "header") %>%
  align(i = 1, align = "center", part = "header")
ft_ae



## -------------------------------------------------------------------------------------------------------------------

probab <- df2 %>% 
  mutate(fett = row_number()) %>% 
  filter(AEREL == "PROBABLE") %>% 
  select(fett)

ft_ae <- ft_ae %>%
  bold(i = probab$fett, bold = TRUE, part = "body") 
ft_ae



## -------------------------------------------------------------------------------------------------------------------

my_doc <- read_docx("table_vorlage_ae_listing.docx") %>% body_add_flextable(ft_ae)
print(my_doc, target = "t7_ae_listing_zu_breit.docx")



## -------------------------------------------------------------------------------------------------------------------

ft_ae <- ft_ae %>% 
  fontsize(size = 8, part = "all") %>%
  width(j = 1, width = 1.5, unit = "cm") %>%
  width(j = 2, width = 1.2, unit = "cm") %>%
  width(j = c(3, 4, 8), width = 3.3, unit = "cm") %>%
  width(j = c(5), width = 2, unit = "cm") %>%
  width(j = c(6), width = 1.5, unit = "cm") %>%
  width(j = c(7), width = 2, unit = "cm") %>%
  width(j = c(9, 10), width = 2.2, unit = "cm")
  
  




## -------------------------------------------------------------------------------------------------------------------

my_doc <- read_docx("table_vorlage_ae_listing.docx") %>% body_add_flextable(ft_ae)
print(my_doc, target = "t7_ae_listing_fitted.docx")


