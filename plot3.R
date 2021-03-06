## helper function to retrieve and return the dataset we want to work with for the plots.
## input: none
## output: a data frame - a sample of the larger file.

loadDataset <- function()
{
    ## Just to get the column names
    header <- read.csv("household_power_consumption.txt", nrows=1, sep=";", as.is=TRUE)
    
    ## We only want the lines pertaining to 2007-02-01 and 2007-02-02. 
    ## After a little bit of research, and the fact the csv is in date order, we can cheat and skip to these lines.
    dataset <- read.csv("household_power_consumption.txt", skip=66637, nrows=2879, sep=";", na.strings="?", as.is=TRUE)
    
    # Copy the column names over
    colnames(dataset) <- colnames(header)
    
    ## Add a column DATETIME
    dataset$DATETIME <- as.POSIXlt(paste(dataset$Date, dataset$Time), format = "%d/%m/%Y %H:%M:%S")
    dataset   
}

powerConsumption <- loadDataset()

## Set the graphic system to do a single plot, and also set up the text scaling.
par(mfrow=c(1,1),cex=0.8)

with(powerConsumption, 
{
    ## Initially draw an empty plot
    plot(DATETIME, Sub_metering_1,
        type="n",
        xlab="",
        ylab="Energy sub metering")
    ## Plot three instances of Energy sub metering (Sub_metering_1, 2, and 3) variables over DATETIME variable. 
    ## Each should be a line plot using a separate colour.
    lines(DATETIME, Sub_metering_1, col = "black")
    lines(DATETIME, Sub_metering_2, col = "red")
    lines(DATETIME, Sub_metering_3, col = "blue")
    
    ## Insert a legend (explanation) for the lines. No border, inset and scaled.
    legend("topright",
        lty=c(1,1), 
        bty="n",
        inset=0.1,
        cex=0.8,
        col=c("black","red","blue"),
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    ## Copy plot to png file
    dev.copy(png, file="plot3.png", width = 480, height = 480)
    dev.off()
})