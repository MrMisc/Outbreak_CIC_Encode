library(echarty)
library(echarts4r)
library(readxl)
library(dplyr)
library(lubridate)
library(stringr)
library(reshape2)
library(rmarkdown)

setwd("E:/Outbreak_CIC_Encode/")
df<-read.csv("output.csv", header = F)

names(df)<-c("Rupturing Probability %","No.of.Lines","No.of.Probes","N","Actual infected","Appx_Infected_Perline","Host/Probe","Appx_Inf/Probe","Contamination","Zone")


df %>% e_charts(`Rupturing Probability %`) %>%
  e_scatter(Contamination) %>%
  e_loess(Contamination~`Rupturing Probability %`, smooth = T, showSymbol = T) %>%
  e_tooltip(trigger = "item") %>%
  e_theme("westeros") %>%
  e_datazoom(orient = "vertical",start = 0) %>%
  e_datazoom(orient = "horizontal",start = 0) %>%
  e_legend(top = "7%") %>%
  e_title("Final contamination sensitivity to rupturing frequency")
