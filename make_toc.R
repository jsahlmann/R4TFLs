#| warning: false

# extract R code from qmd-File

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(flextable))
suppressPackageStartupMessages(library(officer))





file1 <- "t1_table_1/t1_table_one.docx"
file2 <- "t1_table_1/t1_table_one_mit_total.docx"
file3 <- "t3_lm/t3_table_lm.docx"
file_out <- "main_doc.docx"

x <- read_docx(path = file1)
x <- body_add_break(x)
x <- body_add_docx(x, src = file2)
x <- body_add_break(x)
x <- body_add_docx(x, src = file3)
print(x, target = file_out)





file1 <- "t1_table_1/t1_table_one.docx"
file2 <- "t1_table_1/t1_table_one_mit_total.docx"
file3 <- "t3_lm/t3_table_lm.docx"
file_out <- "main_doc_toc_1.docx"

x <- read_docx()
x <- body_add_toc(x)
x <- body_add_break(x)
x <- body_add_docx(x, src = file1)
x <- body_add_break(x)
x <- body_add_docx(x, src = file2)
x <- body_add_break(x)
x <- body_add_docx(x, src = file3)
print(x, target = file_out)





file1 <- "t1_table_1/t1_table_one.docx"
file2 <- "t1_table_1/t1_table_one_mit_total.docx"
file3 <- "t3_lm/t3_table_lm.docx"
file_out <- "main_doc_toc_2.docx"

x <- read_docx()
x <- body_add_par(x, value = "Table of contents", style = "heading 1")
x <- body_add_toc(x)
x <- body_add_break(x)
x <- body_add_par(x, value = "Tables", style = "heading 1")
x <- body_add_par(x, value = "Table 1", style = "heading 2")
x <- body_add_docx(x, src = file1)
x <- body_add_break(x)
x <- body_add_par(x, value = "Table 2", style = "heading 2")
x <- body_add_docx(x, src = file2)
x <- body_add_break(x)
x <- body_add_docx(x, src = file3)
x <- body_add_par(x, value = "Table 3", style = "heading 2")
print(x, target = file_out)





file1 <- "t1_table_1/t1_table_one.docx"
file2 <- "t1_table_1/t1_table_one_mit_total.docx"
file3 <- "t3_lm/t3_table_lm.docx"
file_out <- "main_doc_toc_3.docx"

x <- read_docx(path = "main_doc_toc_vorlage.docx")
x <- body_add_par(x, value = "Table of contents", style = "heading 1")
x <- body_add_toc(x)
x <- body_add_break(x)
x <- body_add_par(x, value = "Tables", style = "heading 1")
x <- body_add_par(x, value = "Table 1", style = "heading 2")
x <- body_add_docx(x, src = file1)
x <- body_add_break(x)
x <- body_add_par(x, value = "Table 2", style = "heading 2")
x <- body_add_docx(x, src = file2)
x <- body_add_break(x)
x <- body_add_docx(x, src = file3)
x <- body_add_par(x, value = "Table 3", style = "heading 2")
print(x, target = file_out)


