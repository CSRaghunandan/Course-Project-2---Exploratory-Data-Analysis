library(ggplot2)

# Place the NEI and SCC datasets in the current working directory
# Load the NEI and SCC data frame
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c("1999", "2002", "2005", "2008"))
SCC <- readRDS("Source_Classification_Code.rds")

# extract baltimore city and motor vehicle sources observations from NEI
BaltimoreOnRoad <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
BaltimoreAggOnRoad <- aggregate(Emissions ~ year, BaltimoreOnRoad, FUN = sum)
BaltimoreAggOnRoad$City <- paste(rep('Baltimore', 4))

# extract LA and motor vehicle sources observationsg from NEI 
LAOnRoad <- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD", ]
LAAggOnRoad <- aggregate(Emissions ~ year, LAOnRoad, FUN = sum)
LAAggOnRoad$City <- paste(rep('LA', 4))

DF <- as.data.frame(rbind(BaltimoreAggOnRoad, LAAggOnRoad))

# create a png device
png(filename = "plot6.png")

plot <- ggplot(data = DF, aes(x = year, y = Emissions)) +
    geom_bar(aes(fill = year),stat = "identity") + 
    guides(fill = F) +
    ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles vs. Baltimore') +
    ylab(expression('PM'[2.5])) + xlab('Year') +
    theme(legend.position = 'none') + 
    facet_grid(. ~ City) +
    geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
print(plot)

# close the png device
dev.off()