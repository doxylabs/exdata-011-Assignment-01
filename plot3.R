# exdata-011: Assignment 1 ------------------------------------------------
# 
# Objective: Recreate the image from "Plot 3" at:
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
# Change the class of our interesting variables so we can chart them.
class(dat$Sub_metering_1)<-c("numeric")
class(dat$Sub_metering_2)<-c("numeric")
class(dat$Sub_metering_3)<-c("numeric")




# Create the PNG with our plot --------------------------------------------

# Create the png with a chart showing all three of the sub-metering variables. 
# The example from lecture showed a single variable with the subsets being
# colored in. Here, we'll need to do something a little different as the
# multiple plots seem to generate different charts.
# [edit: yep. See the note below for par(new=T/F)]

# Create the designated file and set it as the active device.
png(filename="plot3.png", width = 480, height = 480, bg = "transparent")

# We don't really need the par(new=T/F) here as it's implied by the use of a
# plot() and subsequent lines(). I kept it because you can do other neat things
# with it like add new top-level plots. I figure I'm going to come looking for
# this some day...
par(new=F); plot(dat$timestamp, dat$Sub_metering_1, type="l", col="black", 
                 xlab="", ylab="Energy sub metering")
par(new=T); lines(dat$timestamp, dat$Sub_metering_2, col="red")
par(new=T); lines(dat$timestamp, dat$Sub_metering_3, col="blue")

# place a legend in the "topright". It would look a lot nicer offset from the
# corner, but it wouldn't match the example from class.
legend("topright", lty=c(1,1,1),
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# close the file
dev.off() 
