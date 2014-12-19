library(ggplot2)
library(reshape2)
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

places <- data.frame(fips=c("24510", "06037"),
                     name=c("Baltimore City", "Los Angeles County"))

NEI <- subset(NEI, fips %in% places$fips)

veh <- SCC[grep("Motor Vehicle", SCC$SCC.Level.Three),]
NEI <- subset(NEI, SCC %in% veh$SCC)

NEI <- join(NEI, places, by="fips")
emissions <- melt(tapply(NEI$Emissions, list(NEI$year, NEI$name), sum))
colnames(emissions) <- c("Year", "Place", "Emission")

png("plot6.png", width=480, height=480, units="px")
ggplot(data=emissions) +
  geom_point(aes(x=Year, y=Emission, col=Place)) +
  stat_smooth(aes(x=Year, y=Emission, col=Place), method="lm", se=FALSE) +
  ggtitle("Emission change trends")
dev.off()