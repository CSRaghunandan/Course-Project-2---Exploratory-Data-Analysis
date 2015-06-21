library(ggplot2)

# Place the NEI and SCC datasets in the current working directory
# Load the NEI and SCC data frame
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# extract the Coal related SCC
coalSCC <- SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merges two data sets to get only coal related subset
mergeData <- merge(x = NEI, y = coalSCC, by = 'SCC')
mergeSum <- aggregate(Emissions ~ year, mergeData, FUN = sum)
colnames(mergeSum) <- c('Year', 'Emissions')

# create a png devoce
png(filename = "plot4.png")
plot <- ggplot(data = mergeSum, aes(x = Year, y = Emissions / 1000)) + 
    geom_line(aes(group = 1, col = Emissions)) +
    geom_point(aes(size = 2, col = Emissions)) + 
    ggtitle(expression('Total Emissions of PM'[2.5] ~ 'in US from coal-combustion related sources')) +
    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
    theme(legend.position = 'none') + 
    scale_colour_gradient(low = 'black', high = 'red')
print(plot)

# close the png device
dev.off()