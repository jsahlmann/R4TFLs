## -------------------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(survival))
suppressPackageStartupMessages(library(survminer))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))
suppressPackageStartupMessages(library(safetyData))



## -------------------------------------------------------------------------------------------------------------------

data(adam_adtte, package = "safetyData")
df <- adam_adtte
#df <- read.xport("../data/adtte.xpt")
head(df)

df %>% select(STUDYID, USUBJID, TRTP, AVAL, CNSR) %>% head()



## -------------------------------------------------------------------------------------------------------------------

table(df$PARAMCD, df$CNSR) %>% as.data.frame() %>% rename("Event" = Var1, "Censoring" = Var2, "Count" = Freq) %>% flextable()



## -------------------------------------------------------------------------------------------------------------------

# proc lifetest;
#   time t*c(1); * 1 = Zensur, 0 = Event;
# run;

df$CNSR_neu <- 1 - df$CNSR
sf <- survfit(Surv(AVAL, CNSR_neu) ~ TRTP, data = df)
head(sf)



## -------------------------------------------------------------------------------------------------------------------

plt <- ggsurvplot(sf, data = df,  
                  palette =
    c("green", "#E7B800", "#2E9FDF")
)
plt
ggsave("t5_km.png")



## -------------------------------------------------------------------------------------------------------------------

ggsurvplot(
  sf,
  data = df,
  size = 1,                 # change line size
  palette =
    c("green", "#E7B800", "#2E9FDF"),# custom color palettes
  pval = TRUE,              # Add p-value
  risk.table = TRUE,        # Add risk table
  risk.table.col = "strata",# Risk table color by groups
  legend.labs =
    c("Placebo", "High dose", "Low dose"),    # Change legend labels
  risk.table.height = 0.35, # Useful to change when you have multiple groups
  ggtheme = theme_bw()      # Change ggplot2 theme
)



## -------------------------------------------------------------------------------------------------------------------

ggsurvplot(
  sf,
  data = df,
  size = 1,                 # change line size
  conf.int = TRUE,
  palette =
    c("green", "#E7B800", "#2E9FDF"),# custom color palettes
  pval = TRUE,              # Add p-value
  risk.table = TRUE,        # Add risk table
  risk.table.col = "strata",# Risk table color by groups
  legend.labs =
    c("Placebo", "High dose", "Low dose"),    # Change legend labels
  risk.table.height = 0.35, # Useful to change when you have multiple groups
  ggtheme = theme_bw()      # Change ggplot2 theme
)



## ---- eval = FALSE--------------------------------------------------------------------------------------------------
## 
## my_doc <- read_docx() %>% body_add_img(src = "t5_km.png", height = 4, width = 4)
## print(my_doc, target = "t5_km.docx")
## 

