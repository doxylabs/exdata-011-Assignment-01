# exdata-011: Assignment 1 ------------------------------------------------
# 
# Objective: Recreate the image from "Plot 4" at:
#
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions



# Read and munge the data set ---------------------------------------------

# Gobble up this beast. nom, nom, nom...
dat<-read.csv("household_power_consumption.txt",header = TRUE,sep = ";", 
              stringsAsFactors = FALSE, na.strings="?")

# Filter out unused data (using the character dates given - mind the day/month
# order if you went to U.S. public schools)
dat<-dat[dat$Date=="1/2/2007" | dat$Date=="2/2/2007",]

# Now... Convert dates / times only on the ones we care about. Faster if you
# only convert these two days, filter first.
dat<-within(dat, {
  timestamp=strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S") 
})



# Convert variables -------------------------------------------------------
class(dat$Sub_metering_1)<-c("numeric")
class(dat$Sub_metering_2)<-c("numeric")
class(dat$Sub_metering_3)<-c("numeric")
class(dat$Global_active_power)<-c("numeric")
class(dat$Global_reactive_power)<-c("numeric")
class(dat$Voltage)<-c("numeric")



# Create the PNG with our plots -------------------------------------------

# m'kay! We're going to reproduce two of our previous plots (2&3) with two new 
# plots for voltage and Global_reactive_power. This means we need four quadrants
# and might need to kinky about with the margins.

# Create the designated file and set it as the active device.
png(filename="plot4.png", width = 480, height = 480, bg = "transparent")

# Set up the row-first filled quadrants.
# Don't use all the extra stuff from class. Margins match with this...
par(mfrow=c(2,2)) 
#par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


# Re-create plot 2 --------------------------------------------------------

# Remove the (kilowatts) designation from the ylab!

plot(dat$timestamp, dat$Global_active_power,
     ylab="Global Active Power",
     xlab="", type="l",     
     main="")


# New plot for voltage ----------------------------------------------------

# Similar to plot2. Add 'datetime' to xlab. Change ylab to 'Voltage'. The line 
# looks a bit heavier. It may be due to the large variance of the data 
# clustering points together on the screen. Play with this one. The y-axis hash
# mark labels are only marked every other one. This may be a free adjustment the
# system will make for us. [ed: yes it is...]

plot(dat$timestamp, dat$Voltage,
     ylab="Voltage",
     xlab="datetime", type="l",     
     main="")


# Re-create plot 3 --------------------------------------------------------

plot(dat$timestamp, dat$Sub_metering_1, type="l", col="black", 
                 xlab="", ylab="Energy sub metering")
lines(dat$timestamp, dat$Sub_metering_2, col="red")
lines(dat$timestamp, dat$Sub_metering_3, col="blue")

# place a legend in the "topright". NOTE: In this fourth png, there is no line
# around the legend box.
legend("topright", lty=c(1,1,1),
       bty="n",
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# New plot for global reactive power --------------------------------------

# Looks a lot like the gat and voltage plots. The datetime xlab is still there.

plot(dat$timestamp, dat$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime", type="l",     
     main="")


# close the file
dev.off() 
