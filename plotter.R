#! /usr/bin/Rscript
library(stringr)
library(NeuralNetTools)
library(tibble)
library(pandoc)
library(echarty)
library(echarts4r)
library(dplyr)
library(zoo)
library(lubridate)
library(tidyr)
# Using the e1071 package for SVM
library(e1071)
library(caret)
library(randomForest)
library(varImp)
library(relaimpo)
library(earth)
library(Boruta)
library(devtools)
library(woe)
library(riv)
library(glmnet)
library(DT)
# setwd("C:/Users/Victus/OneDrive/Desktop/HD2")
setwd("E:/Outbreak_CIC_Encode/")
source('echarty_themes.R')





df<-read.csv("output.csv", header = T)

df<-df %>% group_by(No.of.Lines,N) %>% mutate(Trial = row_number()) %>% ungroup()

df%>% 
  mutate(No.of.Lines = as.factor(No.of.Lines), N = as.factor(N)) %>% 
  group_by(Trial) %>% e_charts(No.of.Lines, timeline = T) %>% 
  e_heatmap(N,Contamination) %>% 
  e_visual_map(Contamination) %>% 
  e_theme("essos") %>% 
  e_title("Contamination difference across scale and configuration") %>% 
  e_timeline_opts(playInterval = 550, autoPlay  = T) %>% 
  e_animation(easing = "easeElastic")



df %>% filter(TRUE) %>% arrange(No.of.Lines,N) %>% 
  mutate(No.of.Lines = as.factor(No.of.Lines), N = as.factor(N)) %>%
  group_by(N,No.of.Lines) %>% summarise(Contamination = mean(Contamination)) %>% ungroup() %>% e_charts(No.of.Lines) %>% 
  e_heatmap(N,Contamination) %>% 
  e_visual_map(Contamination) %>% 
  e_tooltip() %>% 
  e_theme("essos") %>% 
  e_title("Contamination difference across scale and configuration")



df %>% group_by(No.of.Lines) %>% e_charts() %>% 
  e_boxplot(Contamination) %>% 
  e_scatter(Contamination) %>% 
  e_loess(Contamination~No.of.Lines, smooth = T, showSymbol = T) %>%
  e_tooltip() %>% 
  e_theme("westeros") %>% 
  e_datazoom(orient = "vertical",start = 75) %>% 
  e_title("Contamination difference across scale and configuration")
  # e_axis(y = list(min = min_val, max = max_val))


df  %>% e_charts(Appx_Inf.Probe) %>% 
  # e_boxplot(Contamination) %>%
  e_scatter(Contamination) %>% 
  e_loess(Contamination~Appx_Inf.Probe, smooth = T, showSymbol = T) %>%
  e_tooltip(trigger = "item") %>% 
  e_theme("westeros") %>%                  
  e_datazoom(orient = "vertical",start = 75) %>% 
  e_title("Contamination difference across scale and configuration")

