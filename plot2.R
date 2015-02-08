# exdata-011: Assignment 1 ------------------------------------------------
# 
# Objective: Recreate the chart from "Plot 2" at:
#
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions


# Read and clean data -----------------------------------------------------

dat<-read.csv("household_power_consumption.txt",header = TRUE,sep = ";", 
              stringsAsFactors = FALSE, na.strings="?")

# Filter out unused data (using the character dates given)
dat<-dat[dat$Date=="1/2/2007" | dat$Date=="2/2/2007",]

# Now... Convert dates / times only on the ones we care about. Faster.
dat<-within(dat, {
  timestamp=strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S") 
  })

# Change the class of our interesting variable so we can build a chart.
class(dat$Global_active_power)<-c("numeric")



# Create the line chart ---------------------------------------------------

# Create a line chart with the Global_active_power in the designated file.
png(filename="plot2.png", width = 480, height = 480, bg = "transparent")
plot(dat$timestamp, dat$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="", type="l",     
     main="")
dev.off()
