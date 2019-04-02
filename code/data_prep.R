library(data.table)
library(ggplot2)

#CHANGE THIS
home_dir <- "C:/Users/twh42/Documents/operation_french_bulldog/"
home_dir <- 'C:/Users/klau314/Downloads/'
setwd(home_dir)

#' Call data downloaded from https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy
data_path <- "Call_Data.csv"
df   <- fread(data_path)

#' Cleaning - Drop
#' 1. Bad dates
#' 2. Non-drug and narcotics related police responses
#' 3. 
df[, `Initial Call Type` := tolower(`Initial Call Type`)]
df[, `Final Call Type` := tolower(`Final Call Type`)]

narc <- df[grepl("narc|drug", `Final Call Type`) | 
           grepl("narc|drug", `Initial Call Type`)]

narc <- narc[!grepl("excl narc", `Final Call Type`) & 
             !grepl("excl narc", `Initial Call Type`)]

narc[, orig_date := as.Date(`Original Time Queued`, "%m/%d/%Y %H:%M:%S")]
narc[ ,arrive_date := as.Date(`Arrived Time`, "%b %d %Y %H:%M:%S")]


#' Plot number of crimes by date of original call
narc[, total_per_orig_date := .N, by = orig_date]

ggplot(narc, aes(x = orig_date, y = total_per_orig_date, )) +
  geom_line() +
  facet_wrap(~ Beat)
