## 1.1:Check for a folder called data, if the folder does not exist it creates a folder called data

if(!file.exists("./data")){dir.create("./data")}

##  1.2: Downloading the data zip file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## 1.3 Unzipping the data zip file & defining the directory for the data.
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## 1.4  List all the files in the folder.
File_list <- file.path("./data")
files<-list.files(File_list , recursive=TRUE)
files

## 2:Reading all of the required files:

## 2.1 Reading the household_power_consumption file
House_hold <- read.table("./data/household_power_consumption.txt",skip = 1, sep=";",na.strings = "?")

## 2.2 Adding Col names to the output.
colnames(House_hold) <- c("Date", "Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## 2.3 Formatting the date
House_hold$Date <- as.Date(House_hold$Date, format="%d/%m/%Y")

## 2.4 Extracting the date range,
Output <- subset(House_hold, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## 2.5 Getting the datetime outout.
datetime <- paste(as.Date(Output$Date), Output$Time)
Output$Datetime <- as.POSIXct(datetime)


## 3:  Plotting and png output file
png("plot3.png", width=480, height=480)
plot(Output$Sub_metering_1~Output$Datetime,type ="l",col = "Black",xlab=" ",ylab="Energy Sub Metering",pch=1)
points(Output$Sub_metering_2~Output$Datetime,type ="l",col = "Red",pch=5)
points(Output$Sub_metering_3~Output$Datetime,type ="l",col = "Blue",pch=10)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=1, col=c("black", "red", "blue"), bty="0")


##logoff
dev.off()