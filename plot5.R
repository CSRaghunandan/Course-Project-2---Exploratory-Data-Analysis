library(ggplot2)

# Place the NEI and SCC datasets in the current working directory
# Load the NEI
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c("1999", "2002", "2005", "2008"))

# extract baltimore city and motor vehicle sources observations from NEI
onRoad <- NEI[NEI$fips == 24510 & NEI$type == "ON-ROAD", ]
aggOnRoad <- aggregate(Emissions ~ year, onRoad, FUN = sum)
png(filename = "plot5.png")

plot <- ggplot(data = aggOnRoad, aes(x = year, y = Emissions)) + 
    geom_bar(aes(fill = year), stat = "identity") + 
    guides(fill = F) + ggtitle('Total Emissions from Motor Vehicle Sources in Baltimore City') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + 
    theme(legend.position = 'none') +
    geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
print(plot)

# close the png device
dev.off()