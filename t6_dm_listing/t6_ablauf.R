## -------------------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(survival))
suppressPackageStartupMessages(library(survminer))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))
suppressPackageStartupMessages(library(safetyData))



## -------------------------------------------------------------------------------------------------------------------

data(sdtm_dm, package = "safetyData")
df <- sdtm_dm
df %>% head()



## -------------------------------------------------------------------------------------------------------------------

str(df)



## -------------------------------------------------------------------------------------------------------------------

df2 <- df %>% select(SUBJID, DMDTC, RFSTDTC, RFENDTC, AGE, SEX, ACTARM, DTHDTC) %>% head(100)
head(df2)
df2$SUBJID <- as.character(df2$SUBJID)
df2$DTHDTC <- ifelse(is.na(df2$DTHDTC), "", df2$DTHDTC)
df2$RFSTDTC <- ifelse(is.na(df2$RFSTDTC), "", df2$RFSTDTC)
df2$RFENDTC <- ifelse(is.na(df2$RFENDTC), "", df2$RFENDTC)
df2$SEX <- df2$SEX %>% dplyr::recode(
                      "F" = "Female",
                      "M" = "Male")
head(df2)



## -------------------------------------------------------------------------------------------------------------------

df2 %>% head() %>% flextable()
ft_dm <- df2 %>% flextable() 



## -------------------------------------------------------------------------------------------------------------------


ft_dm <- ft_dm %>% autofit()
ft_dm 



## -------------------------------------------------------------------------------------------------------------------

ft_dm <- ft_dm %>% 
  set_header_labels(
    SUBJID = "PatientID",
    DMDTC = "Study Start",
    RFSTDTC = "Start of\nTreatment",
    RFENDTC = "End of\nTreatment",
    AGE = "Age\n[years]",
    SEX = "Gender",
    ACTARM = "Treatment",
    DTHDTC = "Date of\nDeath"
  ) %>%
  valign(i = 1, valign = "top", part = "header") %>%
  align(i = 1, align = "center", part = "header")
ft_dm



## -------------------------------------------------------------------------------------------------------------------

highdose <- df2 %>% 
  mutate(fett = row_number()) %>% 
  filter(ACTARM == "Xanomeline High Dose") %>% 
  select(fett)

ft_dm <- ft_dm %>%
  bold(i = highdose$fett, bold = TRUE, part = "body") 
ft_dm



## -------------------------------------------------------------------------------------------------------------------

my_doc <- read_docx("table_vorlage_dm_listing.docx") %>% body_add_flextable(ft_dm)
print(my_doc, target = "t6_dm_listing.docx")


