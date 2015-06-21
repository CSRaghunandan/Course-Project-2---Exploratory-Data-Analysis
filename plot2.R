# Place the NEI and SCC datasets in the current working directory
# Load the NEI data frame
NEI <- readRDS("summarySCC_PM25.rds")

# extract the subset of NEI data by Baltimores fips
NEIBaltimore <- NEI[NEI$fips == "24510", ]

# aggregate by sum of the total emissions by year in Baltimore
aggBaltimore <- aggregate(Emissions ~ year, NEIBaltimore, FUN = sum)

# create a png graphics device
png(filename = "plot2.png")

barplot(
    (aggBaltimore$Emissions),
    names.arg=aggBaltimore$year,
    xlab="Year",
    ylab=expression(paste('PM', ''[2.5], ' in tons')),
    main=expression(paste('Total Emission of PM', ''[2.5], ' from Baltimore city'))
)

# close the png device
dev.off()