library("data.table")

setwd("C:\Users\bhara\Desktop\6th Sem\PE\R_Studio_files\Exploratory_Data_Analysis\ExData_Plotting1")

##Reading the data from the file and sub-setting data for the specified dates
power_datatable <- data.table::fread(input = "household_power_consumption.txt",
                                     na.strings = "?")

## to ensure that the values in the column Global_active power are treated as numbers not strings
# ':=' ensure that the column is updated in place. 
power_datatable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

## Changing the Date column to Date type
power_datatable[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## Filter Dates for 2007-02-01 and 2007-02-02
power_datatable <- power_datatable[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width = 480, height = 480)

## Plot 
hist(power_datatable[, Global_active_power], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red")

dev.off() 
