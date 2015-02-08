# exdata-011: Assignment 1 ------------------------------------------------
# 
# Objective: Recreate the histogram from "Plot 1" at:
#
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions


# Read the full data set --------------------------------------------------

dat<-read.csv("household_power_consumption.txt",header = TRUE,sep = ";", 
              stringsAsFactors = FALSE, na.strings="?")

# Filter out unused data
dat<-dat[dat$Date=="1/2/2007" | dat$Date=="2/2/2007",]

# Change the class of our interesting variable so we can build a histogram.
class(dat$Global_active_power)<-c("numeric")



# Create the histogram ----------------------------------------------------

# Create a histogram with the Global_active_power in the designated file.
png(filename="plot1.png", width = 480, height = 480, bg = "transparent")
hist(dat$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
