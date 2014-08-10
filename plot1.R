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
    ## plot a histogram of the Global active power variable.
    hist(Global_active_power, 
        main="Global Active Power", 
        xlab="Global active power (kilowatts)", 
        col = "red")
    
    ## Copy plot to png file
    dev.copy(png, file="plot1.png", width = 480, height = 480)
    dev.off()
})