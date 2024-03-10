library("data.table")

setwd("C:\Users\bhara\Desktop\6th Sem\PE\R_Studio_files\Exploratory_Data_Analysis\ExData_Plotting1")
#Reads in data from file then subsets data for specified dates
power_datatable <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Converts the Global_active_power column to numbers 
power_datatable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
power_datatable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_datatable <- power_datatable[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = power_datatable[, dateTime]
     , y = power_datatable[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
