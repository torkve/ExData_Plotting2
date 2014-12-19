library(ggplot2)
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI <- subset(NEI, fips == "24510")

emissions <- melt(tapply(NEI$Emissions, list(NEI$year, NEI$type), sum))
colnames(emissions) <- c("Year", "Type", "Emission")

png("plot3.png", width=480, height=480, units="px")
ggplot(data=emissions) +
  geom_point(aes(x=Year, y=Emission, col=Type)) +
  stat_smooth(aes(x=Year, y=Emission, col=Type), method="lm", se=FALSE) +
  ggtitle("Emission change trends in Baltimore City")
dev.off()