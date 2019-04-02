library(data.table)

#CHANGE THIS
home_dir <- "C:/Users/twh42/Documents/operation_french_bulldog/"
setwd(home_dir)

#' Call data downloaded from https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy
data_path <- "data/Call_Data.csv"
df   <- fread(data_path)
df[, `Initial Call Type` := tolower(`Initial Call Type`)]
narc <- df[grepl("narc|drug", `Final Call Type`) | 
             grepl("narc|drug", `Initial Call Type`)]
narc[, orig_date := as.Date(`Original Time Queued`, "%m/%d/%Y %H:%M:%S")]
narc[ ,arrive_date := as.Date(`Arrived Time`, "%b %d %Y %H:%M:%S")]

#' Cleaning - Drop
#' 1. Bad dates
#' 2. Non-drug and narcotics related police responses
#' 3. 


