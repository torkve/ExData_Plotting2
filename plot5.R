library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

veh <- SCC[grep("Motor Vehicle", SCC$SCC.Level.Three),]
NEI <- subset(NEI, SCC %in% veh$SCC)

emissions <- tapply(NEI$Emissions, NEI$year, sum)
x <- as.numeric(names(emissions))
y <- emissions
png("plot5.png", width=480, height=480, units="px")
plot(x, y, type="p", xlab="Year",
     ylab="Total emission", main="Total emission from motor vehicles")
abline(lm(y ~ x))
legend("topright", legend="Regression line", lwd=1)

dev.off()