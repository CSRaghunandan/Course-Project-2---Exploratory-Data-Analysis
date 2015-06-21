# Place the NEI and SCC datasets in the current working directory
# Load the NEI data frame
NEI <- readRDS("summarySCC_PM25.rds")

# Aggregate by sum of the total emissions by year
aggEmissions <- aggregate(Emissions ~ year, NEI, FUN = sum)

# open a png graphics device
png(filename = "plot1.png")

# plot the barplot
barplot(
    (aggEmissions$Emissions)/10^3,
    names.arg=aggEmissions$year,
    xlab="Year",
    ylab=expression(paste('PM', ''[2.5], ' in kilotons')),
    main=expression('Total Emission of PM'[2.5])
)

# close the png graphics device
dev.off()