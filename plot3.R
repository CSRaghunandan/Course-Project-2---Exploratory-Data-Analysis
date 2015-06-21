library(ggplot2)
library(plyr)

# Place the NEI and SCC datasets in the current working directory
# Load the NEI data frame
NEI <- readRDS("summarySCC_PM25.rds")

# extract the subset of NEI data by Baltimores fips
NEIBaltimore <- NEI[NEI$fips == "24510", ]

# create a png device
png(filename = "plot3.png")  

plot_data <- ddply(NEIBaltimore, .(year, type), numcolwise(sum))
plot <- ggplot(plot_data) + 
    aes(x = factor(year), y = Emissions, group = type, col = type) + 
    geom_line() + geom_point() + 
    labs(title = expression('Emissions of PM'[2.5] ~ ' in Baltimore City'), x = "Year", y = expression("Total PM"[2.5] ~ "emission in tons"), fill = "Year")

print(plot)
# close the png device
dev.off()
